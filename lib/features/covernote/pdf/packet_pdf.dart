import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../records/domain/record_models.dart';
import '../domain/case_facts.dart';
import '../domain/case_models.dart';
import '../domain/record_snapshot.dart';

/// Inputs for one packet. Everything printed comes from these values; the
/// builder adds no clinical opinion, test result, or plan address.
class PacketInput {
  const PacketInput({
    required this.caseRow,
    required this.facts,
    required this.requirements,
    required this.evidence,
    required this.generatedAt,
    this.includeLetterText = false,
    this.letterPages = const [],
  });

  final CaseRow caseRow;
  final CaseFacts facts;
  final List<CaseRequirement> requirements;
  final List<EvidenceItem> evidence;
  final DateTime generatedAt;
  final bool includeLetterText;
  final List<LetterPage> letterPages;

  bool get isSample =>
      caseRow.demo ||
      facts.source == 'demo_seed' ||
      evidence.any(
        (e) => e.sourceType == 'synthetic' || e.snapshot['synthetic'] == true,
      );
}

class PacketFonts {
  const PacketFonts(this.regular, this.bold);

  final pw.Font regular;
  final pw.Font bold;

  static PacketFonts fromBytes(ByteData regular, ByteData bold) =>
      PacketFonts(pw.Font.ttf(regular), pw.Font.ttf(bold));
}

class PacketResult {
  const PacketResult(
    this.bytes,
    this.includes,
    this.pageCount, {
    this.draftPages = 0,
  });

  final Uint8List bytes;

  /// Parts actually in the file, listed in the app and stored with the artifact.
  final List<String> includes;
  final int pageCount;

  /// Pages right after the one-page summary that hold the review request draft.
  final int draftPages;
}

const _footer =
    'Patient-reported records and location-matched context; clinician review required.';
const _navy = PdfColor.fromInt(0xFF142D4E);
const _teal = PdfColor.fromInt(0xFF167D8D);
const _mint = PdfColor.fromInt(0xFFD8F2EC);
const _grey = PdfColor.fromInt(0xFF5B6675);
const _line = PdfColor.fromInt(0xFFC9D2DC);

String packetFileName(DateTime at) => 'covernote-packet-${isoDate(at)}.pdf';

String _date(String? iso) {
  final d = parseIsoDate(iso);
  if (d == null) return iso ?? '';
  const m = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${m[d.month - 1]} ${d.day}, ${d.year}';
}

String _dt(DateTime d) => _date(isoDate(d));

String _cut(String s, int max) =>
    s.length <= max ? s : '${s.substring(0, max - 1).trimRight()}…';

String _kindLabel(String? k) => switch (k) {
  'initial_drug_denial' => 'Initial drug coverage denial',
  'additional_information_request' => 'Request for additional information',
  'reauthorization_notice' => 'Reauthorization notice',
  'final_appeal_denial' => 'Final appeal decision',
  'eob_or_bill' => 'Explanation of benefits or bill',
  'other' => 'Other letter',
  _ => 'Letter type not confirmed',
};

String _status(Fact f) {
  if (!f.hasValue) return 'Not in letter';
  if (f.status == FactStatus.userEntered) return 'Entered by patient';
  if (f.confirmed) return 'Checked by patient';
  if (f.status == FactStatus.ambiguous) return 'Needs check';
  return 'Not checked';
}

String _value(Fact f) => f.hasValue ? f.value! : '—';

String deadlineText(DeadlineView d) {
  switch (d.state) {
    case DeadlineResolution.date:
      final basis = switch (d.basis) {
        'calculated' =>
          'calculated from ${d.source?.anchor == 'received_date' ? 'received date' : 'notice date'} + ${d.source?.durationValue} calendar days',
        'user' => 'entered by patient',
        _ => 'stated in letter',
      };
      return '${_dt(d.date!)} ($basis)';
    case DeadlineResolution.needsReceivedDate:
      return 'Needs the date the letter was received (${d.source?.durationValue} calendar days after receipt)';
    case DeadlineResolution.conflict:
      return 'Letter gives different dates: ${d.candidates.map((c) => c.date == null ? (c.rawText ?? '?') : _date(c.date)).join(' / ')}. Confirm with the plan.';
    case DeadlineResolution.needsReview:
      return 'Wording unclear: "${_cut(d.source?.rawText ?? '', 120)}". Confirm with the plan.';
    case DeadlineResolution.none:
      return 'No review deadline found in the letter';
  }
}

class _Compaction {
  const _Compaction(
    this.reasons,
    this.reasonChars,
    this.rows,
    this.labelChars,
    this.quotes, {
    this.contextOnSummary = true,
  });

  final int reasons;
  final int reasonChars;
  final int rows;
  final int labelChars;
  final bool quotes;

  /// Optional local context moves to the appendix as the last step.
  final bool contextOnSummary;
}

const _levels = [
  _Compaction(2, 260, 4, 90, true),
  _Compaction(2, 180, 4, 70, false),
  _Compaction(1, 160, 3, 60, false),
  _Compaction(1, 120, 2, 50, false),
  _Compaction(1, 120, 2, 50, false, contextOnSummary: false),
];

const _format = PdfPageFormat(
  8.5 * PdfPageFormat.inch,
  11 * PdfPageFormat.inch,
  marginAll: 0.5 * PdfPageFormat.inch,
);

pw.ThemeData _theme(PacketFonts fonts) =>
    pw.ThemeData.withFont(base: fonts.regular, bold: fonts.bold).copyWith(
      defaultTextStyle: pw.TextStyle(
        font: fonts.regular,
        fontSize: 10,
        color: PdfColors.black,
        lineSpacing: 1.5,
      ),
    );

/// Builds the packet. The summary must fit one page: rows are shortened step
/// by step (never the font size) and the full text moves to the appendix.
Future<PacketResult> buildPacketPdf(
  PacketInput input,
  PacketFonts fonts,
) async {
  for (var i = 0; i < _levels.length; i++) {
    final probe = pw.Document(theme: _theme(fonts));
    probe.addPage(_summaryPage(input, _levels[i]));
    if (probe.document.pdfPageList.pages.length == 1) {
      return _build(input, fonts, _levels[i], i);
    }
  }
  throw StateError('summary_does_not_fit');
}

Future<PacketResult> _build(
  PacketInput input,
  PacketFonts fonts,
  _Compaction c,
  int level,
) async {
  final doc = pw.Document(
    theme: _theme(fonts),
    title: 'Coverage review packet',
    author: 'Prepared by the patient with CoverNote',
    creator: 'CoverNote',
  );
  const format = _format;
  final includes = <String>['clinician_summary'];
  final f = input.facts;
  final sample = input.isSample;
  final needsAppendix =
      level > 0 ||
      f.reasons.length > c.reasons ||
      input.requirements.length > c.rows;

  doc.addPage(_summaryPage(input, c));

  // ---------------- Review request draft ----------------
  if (f.supportsReviewDraft) {
    includes.add('review_request_draft');
    doc.addPage(
      pw.MultiPage(
        pageFormat: format,
        maxPages: 4,
        header: (_) => _pageHeader(sample, 'DRAFT - FOR REVIEW', draft: true),
        footer: (ctx) => _pageFooter(ctx),
        build: (_) => _draft(input),
      ),
    );
  }
  final draftPages = doc.document.pdfPageList.pages.length - 1;

  // ---------------- Appendix ----------------
  if (needsAppendix || input.includeLetterText) {
    includes.add('appendix_letter_details');
    if (input.includeLetterText && input.letterPages.isNotEmpty) {
      includes.add('appendix_letter_text');
    }
    doc.addPage(
      pw.MultiPage(
        pageFormat: format,
        maxPages: 12,
        header: (_) =>
            _pageHeader(sample, 'Appendix - letter details', draft: false),
        footer: (ctx) => _pageFooter(ctx),
        build: (_) => _appendix(input, c),
      ),
    );
  }

  final bytes = await doc.save();
  return PacketResult(
    bytes,
    includes,
    doc.document.pdfPageList.pages.length,
    draftPages: draftPages,
  );
}

pw.MultiPage _summaryPage(PacketInput input, _Compaction c) => pw.MultiPage(
  pageFormat: _format,
  header: (_) =>
      _pageHeader(input.isSample, 'Coverage review brief', draft: false),
  footer: (ctx) => _pageFooter(ctx),
  build: (_) => [
    _identity(input),
    pw.SizedBox(height: 8),
    _sectionTitle('B. What the plan decided'),
    _insuranceTable(input, c),
    pw.SizedBox(height: 8),
    _sectionTitle('C. Requested vs. available'),
    _requestedTable(input, c),
    pw.SizedBox(height: 8),
    _sectionTitle('D. Patient records (self-reported)'),
    ..._recordsTable(input),
    if (c.contextOnSummary)
      ..._localContext(input)
    else if (_contextSnapshot(input) != null) ...[
      pw.SizedBox(height: 8),
      _sectionTitle('E. Local context (supporting background only)'),
      pw.Text('Attached in the appendix.'),
    ],
    pw.SizedBox(height: 8),
    _sectionTitle('F. For the care team to review'),
    ..._careTeamItems(input),
  ],
);

pw.Widget _pageHeader(bool sample, String title, {required bool draft}) {
  return pw.Container(
    margin: const pw.EdgeInsets.only(bottom: 8),
    padding: const pw.EdgeInsets.only(bottom: 4),
    decoration: const pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(color: _navy, width: 1.2)),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Text(
            title,
            style: pw.TextStyle(
              fontSize: draft ? 14 : 16,
              fontWeight: pw.FontWeight.bold,
              color: _navy,
            ),
          ),
        ),
        if (sample)
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.red800, width: 1),
            ),
            child: pw.Text(
              'SAMPLE - SYNTHETIC DATA',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.red800,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          )
        else
          pw.Text(
            'Patient-prepared · For clinician review',
            style: const pw.TextStyle(fontSize: 10, color: _grey),
          ),
        pw.SizedBox(width: 8),
        pw.Text(
          'CoverNote',
          style: pw.TextStyle(
            fontSize: 10,
            color: _teal,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

pw.Widget _pageFooter(pw.Context ctx) => pw.Container(
  margin: const pw.EdgeInsets.only(top: 6),
  padding: const pw.EdgeInsets.only(top: 3),
  decoration: const pw.BoxDecoration(
    border: pw.Border(top: pw.BorderSide(color: _line, width: 0.6)),
  ),
  child: pw.Row(
    children: [
      pw.Expanded(
        child: pw.Text(
          _footer,
          style: const pw.TextStyle(fontSize: 10, color: _grey),
        ),
      ),
      pw.Text(
        'Page ${ctx.pageNumber} of ${ctx.pagesCount}',
        style: const pw.TextStyle(fontSize: 10, color: _grey),
      ),
    ],
  ),
);

pw.Widget _sectionTitle(String t) => pw.Padding(
  padding: const pw.EdgeInsets.only(bottom: 3),
  child: pw.Text(
    t,
    style: pw.TextStyle(
      fontSize: 11,
      fontWeight: pw.FontWeight.bold,
      color: _navy,
    ),
  ),
);

pw.Widget _cell(String text, {bool bold = false, PdfColor? color}) =>
    pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2.5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: bold ? pw.FontWeight.bold : null,
          color: color,
        ),
      ),
    );

pw.Widget _table(
  List<List<String>> rows, {
  List<double>? widths,
  bool header = true,
}) {
  return pw.Table(
    border: const pw.TableBorder(
      horizontalInside: pw.BorderSide(color: _line, width: 0.5),
      bottom: pw.BorderSide(color: _line, width: 0.5),
      top: pw.BorderSide(color: _line, width: 0.5),
    ),
    columnWidths: widths == null
        ? null
        : {
            for (var i = 0; i < widths.length; i++)
              i: pw.FlexColumnWidth(widths[i]),
          },
    children: [
      for (var r = 0; r < rows.length; r++)
        pw.TableRow(
          decoration: header && r == 0
              ? const pw.BoxDecoration(color: _mint)
              : null,
          children: [for (final c in rows[r]) _cell(c, bold: header && r == 0)],
        ),
    ],
  );
}

pw.Widget _identity(PacketInput input) {
  final f = input.facts;
  final range = _recordRange(input);
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _sectionTitle('A. Patient and case'),
      _table(
        [
          [
            'Patient',
            _value(f.field('patient_name')),
            'Plan',
            _value(f.field('plan_name')),
          ],
          [
            'Member ID',
            _value(f.field('member_id')),
            'Case / reference',
            _value(f.field('case_reference')),
          ],
          [
            'Prepared',
            _dt(input.generatedAt),
            'Records period',
            range ?? 'No records attached',
          ],
          [
            'Letter type',
            _kindLabel(f.kind),
            'Fact version',
            'r${input.caseRow.factRevision}',
          ],
        ],
        widths: [1.1, 2, 1.2, 2],
        header: false,
      ),
    ],
  );
}

String? _recordRange(PacketInput input) {
  final ranges = input.evidence
      .where((e) => e.from != null && e.to != null)
      .toList();
  if (ranges.isEmpty) return null;
  final from = ranges
      .map((e) => e.from!)
      .reduce((a, b) => a.compareTo(b) <= 0 ? a : b);
  final to = ranges
      .map((e) => e.to!)
      .reduce((a, b) => a.compareTo(b) >= 0 ? a : b);
  return '${_date(from)} - ${_date(to)}';
}

pw.Widget _insuranceTable(PacketInput input, _Compaction c) {
  final f = input.facts;
  final d = resolveDeadline(f);
  final reasons = f.reasons.take(c.reasons).toList();
  final rows = <List<String>>[
    ['Item', 'From the letter', 'Status'],
    [
      'Medication (as written)',
      _value(f.field('medication')),
      _status(f.field('medication')),
    ],
    ['Dose (as written)', _value(f.field('dose')), _status(f.field('dose'))],
    [
      'Notice date',
      f.field('notice_date').hasValue
          ? _date(f.field('notice_date').value)
          : '—',
      _status(f.field('notice_date')),
    ],
    for (final r in reasons)
      [
        'Reason given${r.page != null ? ' (p.${r.page})' : ''}',
        c.quotes && r.quote != null
            ? '"${_cut(r.quote!, c.reasonChars)}"'
            : _cut(r.text, c.reasonChars),
        r.status == FactStatus.userEntered
            ? 'Entered by patient'
            : (r.confirmed ? 'Checked by patient' : 'Not checked'),
      ],
    if (f.reasons.isEmpty)
      ['Reason given', 'No reason found in the letter', '—'],
    [
      'Review deadline',
      deadlineText(d),
      input.facts.deadlineState.confirmed
          ? 'Checked by patient'
          : 'Not checked',
    ],
    if (d.infoResponseDate != null)
      ['Reply to info request by', _dt(d.infoResponseDate!), 'From letter'],
  ];
  return _table(rows, widths: [1.4, 3.6, 1.3]);
}

String _requirementState(CaseRequirement r, PacketInput input) {
  switch (r.status) {
    case RequirementStatus.linked:
      final e = input.evidence
          .where((x) => x.id == r.linkedEvidenceId)
          .firstOrNull;
      return e == null ? 'Marked as attached' : 'Attached: ${_evidenceName(e)}';
    case RequirementStatus.askedCareTeam:
      return 'Asked care team';
    case RequirementStatus.notAvailable:
      return 'Not available to patient';
    case RequirementStatus.notApplicable:
      return 'Patient marked not applicable';
    default:
      return 'Not yet gathered';
  }
}

String _responsible(String r) => switch (r) {
  'patient' => 'Patient',
  'care_team' => 'Care team',
  'insurer' => 'Plan',
  _ => 'To confirm',
};

String _evidenceName(EvidenceItem e) => switch (e.recordType) {
  'medication_summary' => 'medication log summary',
  'symptom_summary' => 'symptom log summary',
  'local_context' => 'local context summary',
  _ => e.recordType,
};

pw.Widget _requestedTable(PacketInput input, _Compaction c) {
  final reqs = input.requirements.take(c.rows).toList();
  if (reqs.isEmpty) {
    return pw.Text(
      'The letter does not list specific documents. Confirm with the plan what to send.',
    );
  }
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      _table(
        [
          ['Requested in the letter', 'Current status', 'Who confirms'],
          for (final r in reqs)
            [
              '${_cut(r.label, c.labelChars)}${r.sourcePage != null ? ' (p.${r.sourcePage})' : ''}${r.origin == 'user_added' ? ' [added by patient]' : ''}',
              _requirementState(r, input),
              _responsible(r.responsible),
            ],
        ],
        widths: [2.6, 2.4, 1.1],
      ),
      if (input.requirements.length > reqs.length)
        pw.Text(
          '${input.requirements.length - reqs.length} more item(s) in the appendix.',
          style: const pw.TextStyle(color: _grey),
        ),
    ],
  );
}

List<pw.Widget> _recordsTable(PacketInput input) {
  final r = recordRows(input);
  if (r == null) {
    return [pw.Text('No patient records attached to this case.')];
  }
  return [
    _table(r.rows, widths: [1.3, 2.9, 2.2]),
    pw.Text(r.notes.join(' '), style: const pw.TextStyle(color: _grey)),
  ];
}

/// Section D rows (header first) and the notes line, or null when the case
/// has no medication or symptom record attached.
({List<List<String>> rows, List<String> notes})? recordRows(PacketInput input) {
  final med = input.evidence
      .where((e) => e.recordType == 'medication_summary')
      .map((e) => MedicationSnapshot.fromJson(e.snapshot))
      .whereType<MedicationSnapshot>()
      .firstOrNull;
  final sym = input.evidence
      .where((e) => e.recordType == 'symptom_summary')
      .map((e) => SymptomSnapshot.fromJson(e.snapshot))
      .whereType<SymptomSnapshot>()
      .firstOrNull;
  if (med == null && sym == null) return null;
  final rows = <List<String>>[
    ['Record', 'Count', 'Note'],
  ];
  final notes = <String>[];
  if (med != null) {
    notes.add('Period ${_dt(med.range.from)} - ${_dt(med.range.to)}.');
    if (med.hasSchedule) {
      rows.add([
        'Scheduled doses',
        '${med.taken} taken / ${med.notTaken} not taken / ${med.unknown + med.deferred} unknown of ${med.scheduled}',
        _cut(med.medications.join(', '), 40),
      ]);
      notes.add('Unknown = no answer recorded; not counted as missed.');
    } else {
      rows.add(['Scheduled doses', 'No schedule recorded', '']);
    }
    rows.add([
      'As-needed use',
      '${med.prnUses} uses${med.prnUses > 0 ? ' / ${med.prnPuffs} puffs' : ''}${med.prnUsesWithoutCount > 0 ? ' (${med.prnUsesWithoutCount} without puff count)' : ''}',
      'Separate from scheduled doses',
    ]);
  }
  if (sym != null) {
    if (med == null) {
      notes.add('Period ${_dt(sym.range.from)} - ${_dt(sym.range.to)}.');
    }
    rows.add([
      'Symptom days',
      '${sym.daysWithSymptoms} with symptoms; ${sym.nightWakingDays} with night waking',
      'Entries on ${sym.daysWithEntries} of ${sym.range.dayCount} days',
    ]);
  }
  return (rows: rows, notes: notes);
}

LocalContextSnapshot? _contextSnapshot(PacketInput input) {
  final ctx = input.evidence
      .where((e) => e.recordType == 'local_context')
      .map((e) => LocalContextSnapshot.fromJson(e.snapshot))
      .whereType<LocalContextSnapshot>()
      .firstOrNull;
  return ctx == null || ctx.isEmpty ? null : ctx;
}

List<pw.Widget> _localContext(PacketInput input, {bool appendix = false}) {
  final ctx = _contextSnapshot(input);
  if (ctx == null) return const [];
  final rows = <List<String>>[
    ['Context (optional)', 'Values', 'Source'],
  ];
  if (ctx.pm25Days > 0) {
    rows.add([
      'PM2.5 air quality (regional AQI)',
      'Data on ${ctx.pm25Days} of ${ctx.range.dayCount} days; ${ctx.pm25DaysAbove100} day(s) above AQI 100${ctx.pm25MaxAqi != null ? '; max ${ctx.pm25MaxAqi}' : ''}',
      '${_cut(ctx.sources.join(', '), 60)}${ctx.places.isEmpty ? '' : ' · ${_cut(ctx.places.join(', '), 30)}'}${ctx.synthetic ? ' (synthetic)' : ''}',
    ]);
  }
  if (ctx.reportCounts.isNotEmpty) {
    String name(String k) => switch (k) {
      'strong_exhaust' => 'strong exhaust nearby',
      'water_intrusion' => 'water intrusion at home',
      'damp_musty' => 'damp or musty indoor area',
      _ => k,
    };
    rows.add([
      'Patient reports',
      ctx.reportCounts.entries
          .map((e) => '${name(e.key)}: ${e.value} day(s)')
          .join('; '),
      'Self-report${ctx.synthetic ? ' (synthetic)' : ''}',
    ]);
  }
  return [
    pw.SizedBox(height: 8),
    appendix
        ? pw.Text(
            'Local context (supporting background only)',
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: _navy),
          )
        : _sectionTitle('E. Local context (supporting background only)'),
    _table(rows, widths: [1.6, 2.6, 2.0]),
    pw.Text(
      'Days without data are left blank. Same-day timing does not show a cause.',
      style: const pw.TextStyle(color: _grey),
    ),
  ];
}

List<pw.Widget> _careTeamItems(PacketInput input) {
  final f = input.facts;
  final open = input.requirements
      .where(
        (r) =>
            r.responsible == 'care_team' &&
            r.status != RequirementStatus.linked &&
            r.status != RequirementStatus.notApplicable,
      )
      .map((r) => r.label)
      .toList();
  final d = resolveDeadline(f);
  final route = f.field('submission_route');
  final items = <String>[
    if (open.isNotEmpty)
      'Check clinical records for: ${_cut(open.join('; '), 140)}.',
    'Deadline: ${d.state == DeadlineResolution.date ? _dt(d.date!) : 'not confirmed - see section B'}.',
    route.hasValue
        ? 'Where to send (from letter): ${_cut(route.value!, 110)}.'
        : 'Where to send: not stated in the letter; confirm with the plan.',
  ].take(3).toList();
  return [
    for (var i = 0; i < items.length; i++)
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: 14, child: pw.Text('${i + 1}.')),
            pw.Expanded(child: pw.Text(items[i])),
          ],
        ),
      ),
  ];
}

List<pw.Widget> _draft(PacketInput input) {
  final f = input.facts;
  final infoRequest = f.kind == 'additional_information_request';
  String v(String key, String missing) =>
      f.field(key).hasValue ? f.field(key).value! : missing;
  final notice = f.field('notice_date').hasValue
      ? _date(f.field('notice_date').value)
      : '[notice date]';
  final med = v('medication', '[medication as written in the letter]');
  final dose = f.field('dose').hasValue ? ' (${f.field('dose').value})' : '';
  final pending = input.requirements
      .where(
        (r) =>
            r.status != RequirementStatus.linked &&
            r.status != RequirementStatus.notApplicable,
      )
      .toList();
  final d = resolveDeadline(f);
  final blank = pw.Container(
    height: 18,
    decoration: const pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(color: _grey, width: 0.6)),
    ),
  );

  pw.Widget p(String t) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 6),
    child: pw.Text(t),
  );
  pw.Widget label(String t) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 6, bottom: 3),
    child: pw.Text(
      t,
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: _navy),
    ),
  );

  return [
    pw.Text(
      infoRequest
          ? 'Response to request for additional information'
          : 'Request for review of a coverage decision',
      style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
    ),
    pw.SizedBox(height: 8),
    _table(
      [
        ['Date', '____________________'],
        ['To', v('plan_name', '[plan name - confirm]')],
        [
          'Send by',
          f.field('submission_route').hasValue
              ? f.field('submission_route').value!
              : '[not stated in the letter - confirm address or fax with the plan or care team]',
        ],
        ['Member', v('patient_name', '[member name]')],
        ['Member ID', v('member_id', '[member ID]')],
        ['Reference', v('case_reference', '[case or reference number]')],
        ['Medication', '$med$dose'],
        ['Notice date', notice],
      ],
      widths: [1.2, 5],
      header: false,
    ),
    pw.SizedBox(height: 10),
    if (infoRequest)
      p(
        'This responds to the notice dated $notice asking for more information about the request for $med.',
      )
    else
      p(
        'I am asking for a review of the decision in the notice dated $notice about $med.',
      ),
    if (f.reasons.isNotEmpty) ...[
      label('Reason stated in the notice'),
      for (final r in f.reasons)
        p(
          r.quote != null
              ? '"${r.quote}"${r.page != null ? ' (page ${r.page})' : ''}'
              : r.text,
        ),
    ],
    label('Items the notice asks for'),
    if (input.requirements.isEmpty)
      p('The notice does not list specific items.'),
    for (final r in input.requirements)
      p('- ${r.label}: ${_requirementState(r, input)}'),
    label('Enclosed'),
    p(
      '- Coverage review brief (patient-prepared summary, page 1 of this packet)',
    ),
    for (final e in input.evidence)
      p(
        '- ${_evidenceName(e)[0].toUpperCase()}${_evidenceName(e).substring(1)} (${_date(e.from)} - ${_date(e.to)})',
      ),
    label('Clinician statement (to be completed by the clinician)'),
    blank,
    blank,
    blank,
    pw.SizedBox(height: 6),
    _table(
      [
        ['Clinician name', ''],
        ['Clinician signature and date', ''],
        ['Patient or representative signature and date', ''],
      ],
      widths: [2.4, 3.6],
      header: false,
    ),
    label('Before sending - checklist'),
    p('[ ] Deadline: ${deadlineText(d)}'),
    for (final r in pending)
      p(
        '[ ] ${r.responsible == 'care_team' ? 'Ask the care team for' : 'Gather'}: ${r.label}',
      ),
    p('[ ] Confirm where and how to send this request.'),
    p('[ ] Keep a copy and note the date you send it.'),
    pw.SizedBox(height: 6),
    pw.Text(
      'This is a draft prepared by the patient. It is not a submitted request and not a medical opinion.',
      style: const pw.TextStyle(color: _grey),
    ),
  ];
}

List<pw.Widget> _appendix(PacketInput input, _Compaction c) {
  final f = input.facts;
  final out = <pw.Widget>[
    pw.Text(
      'Reasons in the letter',
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: _navy),
    ),
    if (f.reasons.isEmpty) pw.Text('None found.'),
    for (final r in f.reasons)
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Text(
          '${r.text}${r.quote != null ? '\nQuote${r.page != null ? ' (p.${r.page})' : ''}: "${r.quote}"' : ''}',
        ),
      ),
    pw.SizedBox(height: 8),
    pw.Text(
      'Requested items',
      style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: _navy),
    ),
    if (input.requirements.isEmpty) pw.Text('None listed.'),
    for (final r in input.requirements)
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 4),
        child: pw.Text(
          '${r.label} - ${_requirementState(r, input)}${r.sourceQuote != null ? '\nQuote${r.sourcePage != null ? ' (p.${r.sourcePage})' : ''}: "${r.sourceQuote}"' : ''}',
        ),
      ),
    if (!c.contextOnSummary) ..._localContext(input, appendix: true),
  ];
  if (input.includeLetterText) {
    for (final p in input.letterPages) {
      out.add(pw.SizedBox(height: 10));
      out.add(
        pw.Text(
          'Letter text, page ${p.pageNumber} (machine reading; check against the original)',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: _navy),
        ),
      );
      out.add(pw.Text(p.text ?? '(no text)'));
    }
  }
  return out;
}
