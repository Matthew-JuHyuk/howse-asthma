import 'package:flutter/material.dart';
import '../../../l10n/app_localizations.dart';
import '../data/preparation_repository.dart';
import '../domain/preparation.dart';
import 'preparation_strings.dart';
import 'source_review_screen.dart';

class RecordReviewController {
  RecordReviewController(this.context, this.repo, this.patientName);
  final BuildContext context;
  final PreparationRepository repo;
  final String patientName;
  Future<Map<String, dynamic>?> _editProposal(Map<String, dynamic> v) async {
    final day = TextEditingController(text: v['day'] ?? dayKey(repo.today));
    final medication = TextEditingController(text: v['medication'] ?? '');
    final quantity = TextEditingController(
      text: v['quantity']?.toString() ?? '',
    );
    final night = TextEditingController(
      text: v['night_wakings']?.toString() ?? '',
    );
    final summary = TextEditingController(text: v['english_summary'] ?? '');
    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(s10(c, 'confirm')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(v['quote'] ?? ''),
              TextField(
                controller: day,
                decoration: InputDecoration(labelText: s10(c, 'date')),
              ),
              TextField(
                controller: medication,
                decoration: InputDecoration(labelText: s10(c, 'current')),
              ),
              TextField(
                controller: quantity,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: s10(c, 'quantity')),
              ),
              TextField(
                controller: night,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: s10(c, 'nightCount')),
              ),
              TextField(
                controller: summary,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: s10(c, 'englishSummary'),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: Text(s10(c, 'cancel')),
          ),
          FilledButton(
            onPressed: () {
              final d = DateTime.tryParse(day.text);
              final q = quantity.text.isEmpty
                  ? null
                  : double.tryParse(quantity.text);
              final n = night.text.isEmpty ? null : int.tryParse(night.text);
              if (d == null ||
                  dayKey(d) != day.text ||
                  d.isAfter(repo.today) ||
                  (quantity.text.isNotEmpty &&
                      (q == null || !q.isFinite || q <= 0)) ||
                  (night.text.isNotEmpty && (n == null || n < 0 || n > 100))) {
                return;
              }
              Navigator.pop(c, {
                ...v,
                'model_proposal':
                    v['model_proposal'] ?? Map<String, dynamic>.from(v),
                'day': day.text,
                'medication': medication.text.trim().isEmpty
                    ? null
                    : medication.text.trim(),
                'quantity': q,
                'night_wakings': n,
                'english_summary': summary.text,
                'user_edited': true,
              });
            },
            child: Text(s10(c, 'save')),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>?> confirm(
    List<Map<String, dynamic>> proposals,
    String text,
  ) async {
    final chosen = <int>{
      for (var i = 0; i < proposals.length; i++)
        if (proposals[i]['omit'] != true &&
            proposals[i]['subject'] == 'selected_patient')
          i,
    };
    final date = TextEditingController(text: dayKey(repo.today));
    try {
      return await Navigator.push<List<Map<String, dynamic>>>(
        context,
        MaterialPageRoute(
          builder: (c) => StatefulBuilder(
            builder: (c, change) => ReviewPage(
              title: s10(c, 'confirm'),
              body: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Text(patientName, style: Theme.of(c).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Text(s10(c, 'checkPatient')),
                  const SizedBox(height: 20),
                  if (proposals.any((v) => v['day'] == null))
                    TextField(
                      controller: date,
                      decoration: InputDecoration(
                        labelText: s10(c, 'date'),
                        helperText: s10(c, 'unknown'),
                      ),
                    ),
                  const SizedBox(height: 16),
                  for (var i = 0; i < proposals.length; i++)
                    Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recordKindLabel(c, proposals[i]['kind'] ?? ''),
                              style: Theme.of(c).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(proposals[i]['quote'] ?? ''),
                            const SizedBox(height: 8),
                            Text(proposals[i]['day'] ?? s10(c, 'unknown')),
                            if ((proposals[i]['uncertainty'] ?? '')
                                .toString()
                                .isNotEmpty)
                              Text(proposals[i]['uncertainty']),
                            if (proposals[i]['subject'] != 'selected_patient')
                              Text(
                                s10(c, 'checkPatient'),
                                style: TextStyle(
                                  color: Theme.of(c).colorScheme.error,
                                ),
                              ),
                            ExpansionTile(
                              tilePadding: EdgeInsets.zero,
                              title: Text(s10(c, 'changeSelection')),
                              children: [
                                CheckboxListTile(
                                  value: chosen.contains(i),
                                  onChanged: proposals[i]['omit'] == true
                                      ? null
                                      : (v) => change(
                                          () => v == true
                                              ? chosen.add(i)
                                              : chosen.remove(i),
                                        ),
                                  title: Text(s10(c, 'connectRecords')),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.edit_outlined),
                                  label: Text(AppLocalizations.of(c)!.cnEdit),
                                  onPressed: () async {
                                    final edited = await _editProposal(
                                      proposals[i],
                                    );
                                    if (edited != null && c.mounted) {
                                      change(() => proposals[i] = edited);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ExpansionTile(
                    title: Text(s10(c, 'originalWords')),
                    children: [SelectableText(text)],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(c),
                  child: Text(s10(c, 'cancel')),
                ),
                FilledButton(
                  onPressed: chosen.isEmpty
                      ? null
                      : () {
                          final fallback = DateTime.tryParse(date.text);
                          if (fallback == null ||
                              dayKey(fallback) != date.text ||
                              fallback.isAfter(repo.today)) {
                            return;
                          }
                          if (chosen.any((i) {
                            final d = DateTime.tryParse(
                              proposals[i]['day'] ?? date.text,
                            );
                            return d == null || d.isAfter(repo.today);
                          })) {
                            return;
                          }
                          Navigator.pop(c, [
                            for (final i in chosen)
                              {
                                ...proposals[i],
                                'day': proposals[i]['day'] ?? date.text,
                                'subject_confirmed': true,
                              },
                          ]);
                        },
                  child: Text('${s10(c, 'confirm')} (${chosen.length})'),
                ),
              ],
            ),
          ),
        ),
      );
    } finally {
      date.dispose();
    }
  }
}
