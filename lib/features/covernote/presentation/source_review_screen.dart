import 'package:flutter/material.dart';
import '../domain/preparation.dart';
import '../ui/app_chrome.dart';
import 'preparation_strings.dart';

/// A task with a persistent action, outside the scrollable content and OS inset.
class ReviewPage extends StatelessWidget {
  const ReviewPage({
    super.key,
    required this.title,
    required this.body,
    required this.actions,
  });
  final String title;
  final Widget body;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CoverNoteAppBar(title: Text(title)),
    body: SafeArea(child: body),
    bottomNavigationBar: Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: Wrap(
          alignment: WrapAlignment.end,
          spacing: 12,
          runSpacing: 12,
          children: actions,
        ),
      ),
    ),
  );
}

String recordKindLabel(BuildContext context, String kind) =>
    s10(context, switch (kind) {
      'medication_use' => 'treatmentDocs',
      'symptom' => 'symptomRecord',
      'urgent_visit' => 'visit',
      'environment' => 'environmentDay',
      _ => 'document',
    });

String needLabel(BuildContext context, EvidenceNeed need) => switch (need.id) {
  'treatment' => s10(context, 'treatmentDocs'),
  'burden' => s10(context, 'burdenDocs'),
  'tests' => s10(context, 'testDocs'),
  _ => need.label,
};

/// Full-screen, lazy list: hundreds of records do not inflate a dialog.
/// Suggestions are only persisted after the user reviews and confirms.
class SourceReviewScreen extends StatefulWidget {
  const SourceReviewScreen({
    super.key,
    required this.title,
    required this.patient,
    required this.events,
    required this.linked,
    this.suggestAll = false,
  });
  final String title, patient;
  final List<TreatmentEvent> events;
  final List<String> linked;
  final bool suggestAll;
  @override
  State<SourceReviewScreen> createState() => _SourceReviewScreenState();
}

class _SourceReviewScreenState extends State<SourceReviewScreen> {
  late final Set<String> _ids;
  bool _customize = false;
  @override
  void initState() {
    super.initState();
    final allowed = widget.events.map((e) => e.id).toSet();
    _ids = widget.linked.isEmpty && widget.suggestAll
        ? allowed
        : widget.linked.toSet().intersection(allowed);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: CoverNoteAppBar(title: Text(widget.title)),
    bottomNavigationBar: SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      child: FilledButton.icon(
        onPressed: widget.events.isEmpty
            ? null
            : () => Navigator.pop(context, _ids.toList()),
        icon: const Icon(Icons.check),
        label: Text('${s10(context, 'connectRecords')} (${_ids.length})'),
      ),
    ),
    body: SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        itemCount: widget.events.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.patient,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    s10(
                      context,
                      widget.events.isEmpty
                          ? 'noMatchingRecords'
                          : widget.suggestAll || widget.linked.isNotEmpty
                          ? 'reviewSuggested'
                          : 'chooseRecords',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${widget.events.length} ${s10(context, 'recordCount')}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TextButton.icon(
                        onPressed: () =>
                            setState(() => _customize = !_customize),
                        icon: const Icon(Icons.tune),
                        label: Text(s10(context, 'changeSelection')),
                      ),
                      if (_customize)
                        TextButton(
                          onPressed: () => setState(() {
                            if (_ids.length == widget.events.length) {
                              _ids.clear();
                            } else {
                              _ids.addAll(widget.events.map((e) => e.id));
                            }
                          }),
                          child: Text(
                            s10(
                              context,
                              _ids.length == widget.events.length
                                  ? 'clearSelection'
                                  : 'selectAll',
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            );
          }
          final e = widget.events[index - 1];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: _customize
                  ? Checkbox(
                      value: _ids.contains(e.id),
                      onChanged: (v) => setState(
                        () => v == true ? _ids.add(e.id) : _ids.remove(e.id),
                      ),
                    )
                  : Icon(
                      _ids.contains(e.id)
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              title: Text(
                '${e.day} · ${recordKindLabel(context, e.kind)}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  e.text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              onTap: () => Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: CoverNoteAppBar(
                      title: Text(recordKindLabel(context, e.kind)),
                    ),
                    body: CoverNoteBody(
                      scrollable: true,
                      child: SelectableText('${e.day}\n\n${e.text}'),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
