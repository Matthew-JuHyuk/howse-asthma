/// Mirrors the `covernote.facts.v1` JSON written by the analyze-letter
/// function (`supabase/functions/analyze-letter/validate.ts`).
library;

const factsSchemaVersion = 'covernote.facts.v1';

const fieldKeys = [
  'patient_name',
  'plan_name',
  'member_id',
  'case_reference',
  'medication',
  'dose',
  'notice_date',
  'contact',
  'submission_route',
];

/// Fields the user must look at before the evidence step opens.
const keyFieldKeys = ['medication', 'dose', 'patient_name', 'case_reference'];

const documentKinds = [
  'initial_drug_denial',
  'additional_information_request',
  'reauthorization_notice',
  'final_appeal_denial',
  'eob_or_bill',
  'other',
  'uncertain',
];

class FactStatus {
  static const extracted = 'extracted';
  static const missing = 'missing';
  static const ambiguous = 'ambiguous';
  static const userEntered = 'user_entered';
}

String? _s(Object? v) => v is String && v.trim().isNotEmpty ? v : null;
int? _i(Object? v) => v is num ? v.toInt() : null;
bool _b(Object? v) => v == true;

class Fact {
  const Fact({
    this.value,
    this.page,
    this.quote,
    this.status = FactStatus.missing,
    this.confirmed = false,
    this.validation,
  });

  final String? value;
  final int? page;
  final String? quote;
  final String status;
  final bool confirmed;
  final String? validation;

  bool get hasValue => value != null && value!.trim().isNotEmpty;
  bool get needsAttention =>
      !confirmed &&
      (status == FactStatus.ambiguous || status == FactStatus.missing);

  factory Fact.fromJson(Object? raw) {
    if (raw is! Map) return const Fact();
    return Fact(
      value: _s(raw['value']),
      page: _i(raw['page']),
      quote: _s(raw['quote']),
      status: _s(raw['status']) ?? FactStatus.missing,
      confirmed: _b(raw['confirmed']),
      validation: _s(raw['validation']),
    );
  }

  Map<String, Object?> toJson() => {
    'value': value,
    'page': page,
    'quote': quote,
    'status': status,
    'confirmed': confirmed,
    if (validation != null) 'validation': validation,
  };

  /// User typed a new value: the letter quote no longer backs it.
  Fact edited(String? newValue) {
    final v = newValue?.trim();
    if (v == null || v.isEmpty) {
      return const Fact(status: FactStatus.missing, confirmed: true);
    }
    if (v == value) return confirm();
    return Fact(
      value: v,
      page: page,
      quote: quote,
      status: FactStatus.userEntered,
      confirmed: true,
    );
  }

  Fact confirm() => Fact(
    value: value,
    page: page,
    quote: quote,
    status: status,
    confirmed: true,
    validation: validation,
  );
}

class ReasonFact {
  const ReasonFact({
    required this.text,
    required this.code,
    this.page,
    this.quote,
    this.status = FactStatus.extracted,
    this.confirmed = false,
  });

  final String text;
  final String code;
  final int? page;
  final String? quote;
  final String status;
  final bool confirmed;

  factory ReasonFact.fromJson(Map raw) => ReasonFact(
    text: _s(raw['text']) ?? '',
    code: _s(raw['code']) ?? 'other',
    page: _i(raw['page']),
    quote: _s(raw['quote']),
    status: _s(raw['status']) ?? FactStatus.extracted,
    confirmed: _b(raw['confirmed']),
  );

  Map<String, Object?> toJson() => {
    'text': text,
    'code': code,
    'page': page,
    'quote': quote,
    'status': status,
    'confirmed': confirmed,
  };

  ReasonFact copyWith({String? text, bool? confirmed}) => ReasonFact(
    text: text ?? this.text,
    code: code,
    page: page,
    quote: quote,
    status: text != null && text != this.text ? FactStatus.userEntered : status,
    confirmed: confirmed ?? this.confirmed,
  );
}

class RequestedItemFact {
  const RequestedItemFact({
    required this.label,
    this.page,
    this.quote,
    this.status = FactStatus.extracted,
  });

  final String label;
  final int? page;
  final String? quote;
  final String status;

  factory RequestedItemFact.fromJson(Map raw) => RequestedItemFact(
    label: _s(raw['label']) ?? '',
    page: _i(raw['page']),
    quote: _s(raw['quote']),
    status: _s(raw['status']) ?? FactStatus.extracted,
  );

  Map<String, Object?> toJson() => {
    'label': label,
    'page': page,
    'quote': quote,
    'status': status,
  };
}

class DeadlineFact {
  const DeadlineFact({
    required this.purpose,
    required this.kind,
    this.date,
    this.durationValue,
    this.durationUnit,
    this.anchor,
    this.rawText,
    this.page,
    this.quote,
    this.status = FactStatus.extracted,
    this.validation,
  });

  /// review_request / information_response / other
  final String purpose;

  /// explicit_date / relative / unclear
  final String kind;
  final String? date;
  final int? durationValue;

  /// calendar_day / business_day
  final String? durationUnit;

  /// received_date / notice_date
  final String? anchor;
  final String? rawText;
  final int? page;
  final String? quote;
  final String status;
  final String? validation;

  factory DeadlineFact.fromJson(Map raw) => DeadlineFact(
    purpose: _s(raw['purpose']) ?? 'other',
    kind: _s(raw['kind']) ?? 'unclear',
    date: _s(raw['date']),
    durationValue: _i(raw['duration_value']),
    durationUnit: _s(raw['duration_unit']),
    anchor: _s(raw['anchor']),
    rawText: _s(raw['raw_text']),
    page: _i(raw['page']),
    quote: _s(raw['quote']),
    status: _s(raw['status']) ?? FactStatus.extracted,
    validation: _s(raw['validation']),
  );

  Map<String, Object?> toJson() => {
    'purpose': purpose,
    'kind': kind,
    'date': date,
    'duration_value': durationValue,
    'duration_unit': durationUnit,
    'anchor': anchor,
    'raw_text': rawText,
    'page': page,
    'quote': quote,
    'status': status,
    if (validation != null) 'validation': validation,
  };
}

class DeadlineState {
  const DeadlineState({
    this.conflict = false,
    this.receivedDate,
    this.receivedDateSource,
    this.confirmed = false,
    this.userDate,
  });

  final bool conflict;
  final String? receivedDate;

  /// document / user
  final String? receivedDateSource;
  final bool confirmed;

  /// A date the user chose or typed when the letter was unclear or in conflict.
  final String? userDate;

  factory DeadlineState.fromJson(Object? raw) {
    if (raw is! Map) return const DeadlineState();
    return DeadlineState(
      conflict: _b(raw['conflict']),
      receivedDate: _s(raw['received_date']),
      receivedDateSource: _s(raw['received_date_source']),
      confirmed: _b(raw['confirmed']),
      userDate: _s(raw['user_date']),
    );
  }

  Map<String, Object?> toJson() => {
    'conflict': conflict,
    'received_date': receivedDate,
    'received_date_source': receivedDateSource,
    'confirmed': confirmed,
    if (userDate != null) 'user_date': userDate,
  };

  DeadlineState copyWith({
    String? receivedDate,
    String? receivedDateSource,
    bool? confirmed,
    String? userDate,
    bool clearUserDate = false,
  }) => DeadlineState(
    conflict: conflict,
    receivedDate: receivedDate ?? this.receivedDate,
    receivedDateSource: receivedDateSource ?? this.receivedDateSource,
    confirmed: confirmed ?? this.confirmed,
    userDate: clearUserDate ? null : (userDate ?? this.userDate),
  );
}

class PageMeta {
  const PageMeta(this.pageNumber, this.legibility);

  final int pageNumber;
  final String legibility;
}

class CaseFacts {
  const CaseFacts({
    required this.source,
    required this.documentKind,
    required this.fields,
    required this.reasons,
    required this.requestedItems,
    required this.deadlines,
    required this.deadlineState,
    required this.pages,
    required this.warnings,
  });

  /// ai / user_edit / demo_seed
  final String source;
  final Fact documentKind;
  final Map<String, Fact> fields;
  final List<ReasonFact> reasons;
  final List<RequestedItemFact> requestedItems;
  final List<DeadlineFact> deadlines;
  final DeadlineState deadlineState;
  final List<PageMeta> pages;
  final List<String> warnings;

  Fact field(String key) => fields[key] ?? const Fact();
  String? get kind => documentKind.value;

  /// Initial denial and information requests lead to a review packet.
  bool get supportsReviewDraft =>
      kind == 'initial_drug_denial' || kind == 'additional_information_request';

  bool get hasUnreadablePage => pages.any((p) => p.legibility != 'clear');

  factory CaseFacts.fromJson(Map raw) {
    final f = raw['fields'];
    return CaseFacts(
      source: _s(raw['source']) ?? 'ai',
      documentKind: Fact.fromJson(raw['document_kind']),
      fields: {
        for (final k in fieldKeys) k: Fact.fromJson(f is Map ? f[k] : null),
      },
      reasons: [
        for (final r in (raw['reasons'] as List? ?? const []))
          if (r is Map) ReasonFact.fromJson(r),
      ],
      requestedItems: [
        for (final r in (raw['requested_items'] as List? ?? const []))
          if (r is Map) RequestedItemFact.fromJson(r),
      ],
      deadlines: [
        for (final r in (raw['deadlines'] as List? ?? const []))
          if (r is Map) DeadlineFact.fromJson(r),
      ],
      deadlineState: DeadlineState.fromJson(raw['deadline_state']),
      pages: [
        for (final p in (raw['pages'] as List? ?? const []))
          if (p is Map)
            PageMeta(_i(p['page_number']) ?? 0, _s(p['legibility']) ?? 'clear'),
      ],
      warnings: [
        for (final w in (raw['warnings'] as List? ?? const []))
          if (w is String) w,
      ],
    );
  }

  Map<String, Object?> toJson() => {
    'schema_version': factsSchemaVersion,
    'source': source,
    'document_kind': documentKind.toJson(),
    'fields': {for (final e in fields.entries) e.key: e.value.toJson()},
    'reasons': [for (final r in reasons) r.toJson()],
    'requested_items': [for (final r in requestedItems) r.toJson()],
    'deadlines': [for (final d in deadlines) d.toJson()],
    'deadline_state': deadlineState.toJson(),
    'pages': [
      for (final p in pages)
        {'page_number': p.pageNumber, 'legibility': p.legibility},
    ],
    'warnings': warnings,
  };

  CaseFacts copyWith({
    Fact? documentKind,
    Map<String, Fact>? fields,
    List<ReasonFact>? reasons,
    DeadlineState? deadlineState,
  }) => CaseFacts(
    source: 'user_edit',
    documentKind: documentKind ?? this.documentKind,
    fields: fields ?? this.fields,
    reasons: reasons ?? this.reasons,
    requestedItems: requestedItems,
    deadlines: deadlines,
    deadlineState: deadlineState ?? this.deadlineState,
    pages: pages,
    warnings: warnings,
  );

  CaseFacts withField(String key, Fact value) =>
      copyWith(fields: {...fields, key: value});

  /// Key facts the user has not looked at yet (medication, dose, name, case
  /// number, the deadline, and the letter type).
  int get factsToConfirm {
    var n = 0;
    for (final k in keyFieldKeys) {
      final f = field(k);
      if (!f.confirmed && (f.hasValue || f.status == FactStatus.ambiguous)) n++;
    }
    if (!documentKind.confirmed) n++;
    final d = resolveDeadline(this);
    if (d.state != DeadlineResolution.none && !deadlineState.confirmed) n++;
    return n;
  }

  bool get readyForEvidence {
    for (final k in keyFieldKeys) {
      final f = field(k);
      if (!f.confirmed && (f.hasValue || f.status == FactStatus.ambiguous)) {
        return false;
      }
    }
    if (!documentKind.confirmed) return false;
    final d = resolveDeadline(this);
    if (d.state != DeadlineResolution.none && !deadlineState.confirmed) {
      return false;
    }
    return true;
  }
}

enum DeadlineResolution {
  /// A date is known (from the letter, a calculation, or the user).
  date,

  /// "N calendar days after you receive this" and the received date is unknown.
  needsReceivedDate,

  /// Two or more different review dates.
  conflict,

  /// Business days, unclear wording, or a date that failed validation.
  needsReview,

  /// No review deadline in the letter.
  none,
}

class DeadlineView {
  const DeadlineView({
    required this.state,
    this.date,
    this.basis,
    this.source,
    this.candidates = const [],
    this.infoResponseDate,
    this.infoResponseSource,
  });

  final DeadlineResolution state;
  final DateTime? date;

  /// letter / calculated / user
  final String? basis;
  final DeadlineFact? source;
  final List<DeadlineFact> candidates;
  final DateTime? infoResponseDate;
  final DeadlineFact? infoResponseSource;

  bool isPast(DateTime today) =>
      date != null &&
      date!.isBefore(DateTime(today.year, today.month, today.day));
}

DateTime? parseIsoDate(String? s) {
  if (s == null) return null;
  final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(s);
  if (m == null) return null;
  final d = DateTime(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!));
  if (d.month != int.parse(m[2]!) || d.day != int.parse(m[3]!)) return null;
  return d;
}

/// Calendar-day arithmetic on local dates. Never estimates business days.
DateTime addCalendarDays(DateTime start, int days) =>
    DateTime(start.year, start.month, start.day + days);

DeadlineView resolveDeadline(CaseFacts f) {
  final review = f.deadlines
      .where((d) => d.purpose == 'review_request')
      .toList();
  final info = f.deadlines
      .where(
        (d) =>
            d.purpose == 'information_response' &&
            d.kind == 'explicit_date' &&
            d.status == FactStatus.extracted,
      )
      .toList();
  final infoDate = info.isEmpty ? null : parseIsoDate(info.first.date);
  final user = parseIsoDate(f.deadlineState.userDate);

  DeadlineView view(
    DeadlineResolution s, {
    DateTime? date,
    String? basis,
    DeadlineFact? src,
    List<DeadlineFact> cands = const [],
  }) => DeadlineView(
    state: s,
    date: date,
    basis: basis,
    source: src,
    candidates: cands,
    infoResponseDate: infoDate,
    infoResponseSource: info.isEmpty ? null : info.first,
  );

  if (user != null) {
    return view(
      DeadlineResolution.date,
      date: user,
      basis: 'user',
      cands: review,
    );
  }
  if (review.isEmpty) return view(DeadlineResolution.none);
  if (f.deadlineState.conflict) {
    return view(DeadlineResolution.conflict, cands: review);
  }
  final d = review.first;
  if (d.kind == 'explicit_date' && d.status == FactStatus.extracted) {
    return view(
      DeadlineResolution.date,
      date: parseIsoDate(d.date),
      basis: 'letter',
      src: d,
    );
  }
  if (d.kind == 'relative' &&
      d.status == FactStatus.extracted &&
      d.durationUnit == 'calendar_day') {
    final n = d.durationValue!;
    if (d.anchor == 'received_date') {
      final received = parseIsoDate(f.deadlineState.receivedDate);
      if (received == null) {
        return view(DeadlineResolution.needsReceivedDate, src: d);
      }
      return view(
        DeadlineResolution.date,
        date: addCalendarDays(received, n),
        basis: 'calculated',
        src: d,
      );
    }
    if (d.anchor == 'notice_date') {
      final notice = f.field('notice_date');
      final nd =
          notice.status == FactStatus.extracted ||
              notice.status == FactStatus.userEntered
          ? parseIsoDate(notice.value)
          : null;
      if (nd != null) {
        return view(
          DeadlineResolution.date,
          date: addCalendarDays(nd, n),
          basis: 'calculated',
          src: d,
        );
      }
    }
  }
  return view(DeadlineResolution.needsReview, src: d, cands: review);
}
