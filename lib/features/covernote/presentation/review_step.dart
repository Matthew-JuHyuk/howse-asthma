import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../records/domain/record_models.dart' show isoDate;
import '../domain/case_facts.dart';
import '../ui/brand.dart';
import 'case_labels.dart';

typedef FactsChanged = void Function(CaseFacts facts, {bool immediate});
typedef ShowQuote = void Function(int? page, String? quote);

/// Why / Next / Date cards, then the details to check. Every change autosaves.
class ReviewStep extends StatelessWidget {
  const ReviewStep({
    super.key,
    required this.facts,
    required this.original,
    required this.today,
    required this.onChanged,
    required this.onShowQuote,
    required this.onContinue,
  });

  final CaseFacts facts;
  final CaseFacts original;
  final DateTime today;
  final FactsChanged onChanged;
  final ShowQuote onShowQuote;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final remaining = facts.factsToConfirm;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        _KindCard(
          facts: facts,
          original: original,
          onChanged: onChanged,
          onShowQuote: onShowQuote,
        ),
        const SizedBox(height: 12),
        _WhyCard(facts: facts, onShowQuote: onShowQuote),
        const SizedBox(height: 12),
        _NextCard(facts: facts),
        const SizedBox(height: 12),
        _DateCard(
          facts: facts,
          today: today,
          onChanged: onChanged,
          onShowQuote: onShowQuote,
        ),
        SectionLabel(l.cnCheckDetails),
        Text(
          l.cnCheckDetailsHint,
          style: const TextStyle(color: CnColors.muted, fontSize: 14),
        ),
        const SizedBox(height: 8),
        for (final k in [
          ...keyFieldKeys,
          ...fieldKeys.where((k) => !keyFieldKeys.contains(k)),
        ])
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _FactTile(
              key: ValueKey('fact-$k'),
              fieldKey: k,
              fact: facts.field(k),
              original: original.field(k),
              isKey: keyFieldKeys.contains(k),
              onChanged: (f, {bool immediate = false}) =>
                  onChanged(facts.withField(k, f), immediate: immediate),
              onShowQuote: onShowQuote,
            ),
          ),
        const SizedBox(height: 16),
        if (remaining > 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              l.cnItemsLeftToCheck(remaining),
              textAlign: TextAlign.center,
              style: const TextStyle(color: CnColors.warn),
            ),
          ),
        SizedBox(
          height: 52,
          child: FilledButton.icon(
            onPressed: facts.readyForEvidence ? onContinue : null,
            icon: const Icon(Icons.arrow_forward),
            label: Text(l.cnContinueToEvidence),
          ),
        ),
      ],
    );
  }
}

class _QuoteLink extends StatelessWidget {
  const _QuoteLink({
    required this.page,
    required this.quote,
    required this.onShowQuote,
  });

  final int? page;
  final String? quote;
  final ShowQuote onShowQuote;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    if (quote == null && page == null) return const SizedBox.shrink();
    return InkWell(
      onTap: () => onShowQuote(page, quote),
      borderRadius: BorderRadius.circular(6),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.format_quote, size: 18, color: CnColors.teal),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  quote == null
                      ? l.cnSeePage(page ?? 1)
                      : '"$quote"${page == null ? '' : ' · ${l.cnPageN(page!)}'}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: CnColors.teal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle(this.icon, this.text, {this.trailing});

  final IconData icon;
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: CnColors.teal),
      const SizedBox(width: 8),
      Expanded(
        child: Semantics(
          header: true,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: CnColors.navy,
            ),
          ),
        ),
      ),
      ?trailing,
    ],
  );
}

class _KindCard extends StatelessWidget {
  const _KindCard({
    required this.facts,
    required this.original,
    required this.onChanged,
    required this.onShowQuote,
  });

  final CaseFacts facts;
  final CaseFacts original;
  final FactsChanged onChanged;
  final ShowQuote onShowQuote;

  Future<void> _change(BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    final picked = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(l.cnWhatLetterIs),
        children: [
          for (final k in documentKinds)
            ListTile(
              title: Text(documentKindLabel(l, k)),
              leading: Icon(
                k == facts.kind
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
              ),
              onTap: () => Navigator.pop(ctx, k),
            ),
        ],
      ),
    );
    if (picked == null) return;
    final o = original.documentKind;
    final next = picked == o.value
        ? o.confirm()
        : Fact(
            value: picked,
            page: o.page,
            quote: o.quote,
            status: FactStatus.userEntered,
            confirmed: true,
          );
    onChanged(facts.copyWith(documentKind: next), immediate: true);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final k = facts.documentKind;
    final (chip, tone) = factStatus(l, k);
    return CnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(Icons.description_outlined, l.cnWhatLetterIs),
          const SizedBox(height: 8),
          Text(
            documentKindLabel(l, k.value),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          StatusChip(chip, tone: tone),
          _QuoteLink(page: k.page, quote: k.quote, onShowQuote: onShowQuote),
          Wrap(
            spacing: 8,
            children: [
              if (!k.confirmed)
                FilledButton.tonal(
                  onPressed: () => onChanged(
                    facts.copyWith(documentKind: k.confirm()),
                    immediate: true,
                  ),
                  child: Text(l.cnLooksRight),
                ),
              TextButton(
                onPressed: () => _change(context),
                child: Text(l.cnChange),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WhyCard extends StatelessWidget {
  const _WhyCard({required this.facts, required this.onShowQuote});

  final CaseFacts facts;
  final ShowQuote onShowQuote;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final denial =
        facts.kind == 'initial_drug_denial' ||
        facts.kind == 'final_appeal_denial';
    final title = denial
        ? l.cnCardWhyDenied
        : facts.kind == 'additional_information_request'
        ? l.cnCardWhatTheyNeed
        : l.cnCardWhatItSays;
    return CnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(Icons.help_outline, title),
          const SizedBox(height: 8),
          if (facts.reasons.isEmpty && facts.requestedItems.isEmpty)
            Text(
              l.cnNoReasonFound,
              style: const TextStyle(color: CnColors.muted),
            ),
          for (final r in facts.reasons) ...[
            Text(r.text, style: const TextStyle(fontSize: 16)),
            _QuoteLink(page: r.page, quote: r.quote, onShowQuote: onShowQuote),
          ],
          if (facts.reasons.isEmpty && facts.requestedItems.isNotEmpty)
            for (final r in facts.requestedItems) ...[
              Text('• ${r.label}', style: const TextStyle(fontSize: 16)),
              _QuoteLink(
                page: r.page,
                quote: r.quote,
                onShowQuote: onShowQuote,
              ),
            ],
        ],
      ),
    );
  }
}

class _NextCard extends StatelessWidget {
  const _NextCard({required this.facts});

  final CaseFacts facts;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final n = facts.requestedItems.length;
    final text = switch (facts.kind) {
      'initial_drug_denial' => l.cnNextDenial(n),
      'additional_information_request' => l.cnNextInfoRequest(n),
      'reauthorization_notice' => l.cnNextReauth,
      'final_appeal_denial' => l.cnNextFinal,
      'eob_or_bill' => l.cnNextEob,
      _ => l.cnNextUncertain,
    };
    final route = facts.field('submission_route');
    final contact = facts.field('contact');
    return CnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(Icons.directions_outlined, l.cnCardNextStep),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(fontSize: 16)),
          if (route.hasValue) ...[
            const SizedBox(height: 8),
            Text(
              l.cnWhereToSend(route.value!),
              style: const TextStyle(fontSize: 15),
            ),
          ],
          if (contact.hasValue) ...[
            const SizedBox(height: 4),
            Text(
              l.cnWhoToCall(contact.value!),
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ],
      ),
    );
  }
}

class _DateCard extends StatelessWidget {
  const _DateCard({
    required this.facts,
    required this.today,
    required this.onChanged,
    required this.onShowQuote,
  });

  final CaseFacts facts;
  final DateTime today;
  final FactsChanged onChanged;
  final ShowQuote onShowQuote;

  DeadlineState get _s => facts.deadlineState;

  Future<DateTime?> _pick(
    BuildContext context, {
    DateTime? initial,
    DateTime? last,
  }) => showDatePicker(
    context: context,
    initialDate: initial ?? today,
    firstDate: DateTime(today.year - 3),
    lastDate: last ?? DateTime(today.year + 3),
  );

  void _set(DeadlineState s) =>
      onChanged(facts.copyWith(deadlineState: s), immediate: true);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final d = resolveDeadline(facts);
    final src = d.source;
    final children = <Widget>[];

    switch (d.state) {
      case DeadlineResolution.date:
        final past = d.isPast(today);
        children.addAll([
          Text(
            formatDay(context, d.date!),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: CnColors.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(switch (d.basis) {
            'calculated' => l.cnDateCalculated(
              src?.anchor == 'received_date'
                  ? l.cnReceivedDateWord
                  : l.cnNoticeDateWord,
              src?.durationValue ?? 0,
            ),
            'user' => l.cnDateEnteredByYou,
            _ => l.cnDateFromLetter,
          }, style: const TextStyle(color: CnColors.muted)),
          if (d.basis == 'calculated' &&
              src?.anchor == 'received_date' &&
              _s.receivedDate != null)
            Text(
              l.cnReceivedOn(formatIsoDay(context, _s.receivedDate)),
              style: const TextStyle(color: CnColors.muted),
            ),
          if (past) ...[
            const SizedBox(height: 8),
            Text(
              l.cnDatePassed,
              style: const TextStyle(
                color: CnColors.warn,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ]);
      case DeadlineResolution.needsReceivedDate:
        children.addAll([
          Text(
            l.cnNeedReceivedDate(src?.durationValue ?? 0),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          FilledButton.tonalIcon(
            onPressed: () async {
              final picked = await _pick(context, last: today);
              if (picked != null) {
                _set(
                  _s.copyWith(
                    receivedDate: isoDate(picked),
                    receivedDateSource: 'user',
                    confirmed: false,
                  ),
                );
              }
            },
            icon: const Icon(Icons.event),
            label: Text(l.cnEnterReceivedDate),
          ),
        ]);
      case DeadlineResolution.conflict:
        children.addAll([
          Text(l.cnDateConflict, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 8),
          for (final c in d.candidates)
            if (parseIsoDate(c.date) != null)
              OutlinedButton(
                onPressed: () =>
                    _set(_s.copyWith(userDate: c.date, confirmed: true)),
                child: Text(l.cnUseThisDate(formatIsoDay(context, c.date))),
              ),
        ]);
      case DeadlineResolution.needsReview:
        children.addAll([
          Text(l.cnDateUnclear, style: const TextStyle(fontSize: 16)),
          if (src?.rawText != null) ...[
            const SizedBox(height: 6),
            Text(
              '"${src!.rawText}"',
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ]);
      case DeadlineResolution.none:
        children.add(
          Text(l.cnNoDeadline, style: const TextStyle(fontSize: 16)),
        );
    }

    if (d.infoResponseDate != null) {
      children.addAll([
        const SizedBox(height: 8),
        Text(
          l.cnReplyBy(formatDay(context, d.infoResponseDate!)),
          style: const TextStyle(fontSize: 15),
        ),
      ]);
    }
    if (src != null) {
      children.add(
        _QuoteLink(
          page: src.page,
          quote: src.quote ?? src.rawText,
          onShowQuote: onShowQuote,
        ),
      );
    }

    final needsConfirm = d.state != DeadlineResolution.none && !_s.confirmed;
    children.add(
      Wrap(
        spacing: 8,
        children: [
          if (needsConfirm && d.state == DeadlineResolution.date)
            FilledButton.tonal(
              onPressed: () => _set(_s.copyWith(confirmed: true)),
              child: Text(l.cnLooksRight),
            ),
          if (d.state != DeadlineResolution.none)
            TextButton(
              onPressed: () async {
                final picked = await _pick(context, initial: d.date);
                if (picked != null) {
                  _set(_s.copyWith(userDate: isoDate(picked), confirmed: true));
                }
              },
              child: Text(l.cnEnterDatePlanGave),
            ),
          if (_s.userDate != null)
            TextButton(
              onPressed: () =>
                  _set(_s.copyWith(clearUserDate: true, confirmed: false)),
              child: Text(l.cnUseLetterDate),
            ),
          if (needsConfirm && d.state != DeadlineResolution.date)
            TextButton(
              onPressed: () => _set(_s.copyWith(confirmed: true)),
              child: Text(l.cnLeaveUnknown),
            ),
        ],
      ),
    );

    final (chip, tone) = d.state == DeadlineResolution.none
        ? (l.cnFactNotInLetter, ChipTone.neutral)
        : _s.confirmed
        ? (
            d.date == null ? l.cnDateUnknownChecked : l.cnFactChecked,
            d.date == null ? ChipTone.warn : ChipTone.good,
          )
        : (l.cnFactNeedsCheck, ChipTone.warn);

    return CnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CardTitle(
            Icons.event_outlined,
            l.cnCardDate,
            trailing: StatusChip(chip, tone: tone),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class _FactTile extends StatefulWidget {
  const _FactTile({
    super.key,
    required this.fieldKey,
    required this.fact,
    required this.original,
    required this.isKey,
    required this.onChanged,
    required this.onShowQuote,
  });

  final String fieldKey;
  final Fact fact;
  final Fact original;
  final bool isKey;
  final void Function(Fact f, {bool immediate}) onChanged;
  final ShowQuote onShowQuote;

  @override
  State<_FactTile> createState() => _FactTileState();
}

class _FactTileState extends State<_FactTile> {
  bool _editing = false;
  late final _ctrl = TextEditingController(text: widget.fact.value ?? '');

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final f = widget.fact;
    final (chip, tone) = factStatus(l, f);
    final verbatim =
        widget.fieldKey == 'medication' || widget.fieldKey == 'dose';
    final attention =
        widget.isKey &&
        !f.confirmed &&
        (f.hasValue || f.status == FactStatus.ambiguous);
    return CnCard(
      color: attention ? const Color(0xFFFFFBF2) : null,
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  fieldLabel(l, widget.fieldKey),
                  style: const TextStyle(fontSize: 14, color: CnColors.muted),
                ),
              ),
              StatusChip(chip, tone: tone),
            ],
          ),
          const SizedBox(height: 4),
          if (_editing)
            TextField(
              controller: _ctrl,
              autofocus: true,
              maxLength: 300,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                isDense: true,
                helperText: verbatim ? l.cnTypeAsWritten : null,
                counterText: '',
              ),
              onChanged: (v) => widget.onChanged(widget.original.edited(v)),
              onSubmitted: (_) => setState(() => _editing = false),
            )
          else
            Text(
              f.hasValue ? f.value! : l.cnFactNotInLetter,
              style: TextStyle(
                fontSize: 17,
                fontWeight: f.hasValue ? FontWeight.w600 : FontWeight.w400,
                color: f.hasValue ? CnColors.ink : CnColors.muted,
              ),
            ),
          if (f.validation != null && !f.confirmed)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                l.cnCheckThisValue,
                style: const TextStyle(color: CnColors.warn, fontSize: 14),
              ),
            ),
          _QuoteLink(
            page: f.page,
            quote: f.quote,
            onShowQuote: widget.onShowQuote,
          ),
          Wrap(
            spacing: 4,
            children: [
              if (!f.confirmed &&
                  (f.hasValue || f.status == FactStatus.ambiguous) &&
                  !_editing)
                FilledButton.tonal(
                  onPressed: () =>
                      widget.onChanged(f.confirm(), immediate: true),
                  child: Text(l.cnLooksRight),
                ),
              TextButton(
                onPressed: () => setState(() {
                  if (!_editing) _ctrl.text = f.value ?? '';
                  _editing = !_editing;
                }),
                child: Text(
                  _editing ? l.cnDone : (f.hasValue ? l.cnEdit : l.cnAdd),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
