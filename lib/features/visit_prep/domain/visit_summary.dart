import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../environment/data/environment_snapshot.dart';
import '../../environment/presentation/env_labels.dart';
import '../../records/domain/record_models.dart';
import '../../records/domain/record_summary.dart';
import '../../records/presentation/record_inputs.dart';
import '../data/visit_prep_repository.dart';

/// A line of the summary. Free text keeps its original wording; it is never
/// machine-translated, so in the English version it is flagged instead.
class SummaryLine {
  const SummaryLine(this.text, {this.original, this.originalLang});

  final String text;
  final String? original;
  final String? originalLang;

  bool get untranslated => original != null;
}

class SummarySection {
  const SummarySection(this.title, this.lines);
  final String title;
  final List<SummaryLine> lines;
}

class VisitSummaryDoc {
  const VisitSummaryDoc({
    required this.title,
    required this.meta,
    required this.sections,
    required this.appendix,
    required this.appendixTitle,
    required this.disclaimer,
  });

  final String title;
  final String appendixTitle;
  final List<String> meta;
  final List<SummarySection> sections;

  /// Full patient notes (original language), never truncated.
  final List<SummaryLine> appendix;
  final String disclaimer;

  int get untranslatedCount =>
      [
        for (final s in sections) ...s.lines,
        ...appendix,
      ].where((l) => l.untranslated).length;
}

/// Builds the summary in [t]'s language from structured data only.
/// Counts come from [RecordSummary]; nothing is recalculated or inferred.
class VisitSummaryBuilder {
  VisitSummaryBuilder({
    required this.t,
    required this.localeTag,
    required this.patientLang,
  });

  final AppLocalizations t;
  final String localeTag;

  /// Language the patient typed free text in (fallback for old entries).
  final String patientLang;

  bool get _english => t.localeName.startsWith('en');

  SummaryLine _free(String text, String? lang) {
    final source = lang ?? patientLang;
    if (!_english || source.startsWith('en')) return SummaryLine(text);
    return SummaryLine(
      t.s5NotTranslatedLine(t.s5LanguageName(source), text),
      original: text,
      originalLang: source,
    );
  }

  String _d(DateTime d) => DateFormat.yMMMd(localeTag).format(d);
  String _dt(DateTime d) => DateFormat.yMMMd(localeTag).add_jm().format(d);

  VisitSummaryDoc build({
    required VisitPrepDraft draft,
    required RecordSummary summary,
    required RecordBundle bundle,
    required DateTime generatedAt,
    EnvironmentSnapshot? environment,
    List<String> environmentLines = const [],
  }) {
    final s = summary;
    final notRecorded = SummaryLine(t.s5PdfNotRecorded);
    final sections = <SummarySection>[];

    sections.add(
      SummarySection(t.s5PdfSectionQuestions, [
        if (draft.questions.isEmpty) notRecorded,
        for (final q in draft.questions) _free(q.text, q.language),
      ]),
    );

    if (draft.includeSymptoms) {
      final lines = <SummaryLine>[];
      if (bundle.symptoms.isEmpty) {
        lines.add(notRecorded);
      } else {
        lines.add(SummaryLine(t.s5PdfSymptomDays(s.symptomDays, s.range.days)));
        for (final e in s.symptomDaysByCode.entries) {
          lines.add(
            SummaryLine(
              t.s5PdfSymptomCodeDays(s5SymptomLabel(t, e.key), e.value),
            ),
          );
        }
        if (s.symptomOtherDays > 0) {
          lines.add(SummaryLine(t.s5PdfSymptomOtherDays(s.symptomOtherDays)));
        }
        if (s.noSymptomDays > 0) {
          lines.add(SummaryLine(t.s5NoSymptomDays(s.noSymptomDays)));
        }
        final logged = bundle.symptoms.map((e) => e.localDate).toSet().length;
        lines.add(SummaryLine(t.s5PdfDaysNotRecorded(s.range.days - logged)));
      }
      sections.add(SummarySection(t.s5PdfSectionSymptoms, lines));
    }

    if (draft.includeInhaler) {
      final lines = <SummaryLine>[];
      if (bundle.inhaler.isEmpty) {
        lines.add(notRecorded);
      } else {
        lines.add(SummaryLine(t.s5PdfInhalerUses(s.inhalerUses, s.inhalerDays)));
        for (final e in s.inhalerByMedication.entries) {
          lines.add(SummaryLine(t.s5PdfInhalerByMed(e.key, e.value)));
        }
        if (s.inhalerUnknownMedication > 0) {
          lines.add(
            SummaryLine(t.s5PdfInhalerUnknown(s.inhalerUnknownMedication)),
          );
        }
        final noMed = bundle.inhaler
            .where((e) => e.medicationStatus == null)
            .length;
        if (noMed > 0) {
          lines.add(SummaryLine(t.s5PdfInhalerMedNotRecorded(noMed)));
        }
        final reasons = <String, int>{};
        for (final e in bundle.inhaler) {
          if (e.useReason != null) {
            reasons[e.useReason!] = (reasons[e.useReason!] ?? 0) + 1;
          }
        }
        for (final r in InhalerRecord.reasons) {
          if (reasons[r] != null) {
            lines.add(
              SummaryLine(
                t.s5PdfReasonCount(s5UseReasonLabel(t, r), reasons[r]!),
              ),
            );
          }
        }
        lines.add(SummaryLine(t.s5PdfMedNamesAsEntered));
      }
      sections.add(SummarySection(t.s5PdfSectionInhaler, lines));
    }

    if (draft.includeMedChecks) {
      final lines = <SummaryLine>[];
      if (s.medAnsweredDays == 0) {
        lines.add(notRecorded);
      } else {
        lines.add(
          SummaryLine(
            t.s5MedCheckCounts(
              s.medUsedDays,
              s.medNotUsedDays,
              s.medNotSureDays,
              s.medNotRecordedDays,
            ),
          ),
        );
        if (s.medNotApplicableDays > 0) {
          lines.add(
            SummaryLine(t.s5MedNotApplicableDays(s.medNotApplicableDays)),
          );
        }
        for (final r in MedCheckRecord.reasons) {
          final n = s.medNotUsedReasons[r];
          if (n != null) {
            lines.add(
              SummaryLine(t.s5PdfNotUsedReason(s5MedReasonLabel(t, r), n)),
            );
          }
        }
      }
      sections.add(SummarySection(t.s5PdfSectionMedChecks, lines));
    }

    final barriers = <SummaryLine>[];
    for (final code in VisitPrepDraft.barrierCodes) {
      if (draft.barriers.contains(code)) {
        barriers.add(SummaryLine(s5BarrierLabel(t, code)));
      }
    }
    final otherBarrier = draft.barrierOther?.trim();
    if (otherBarrier != null && otherBarrier.isNotEmpty) {
      barriers.add(_free(otherBarrier, draft.sourceLanguage));
    }
    sections.add(
      SummarySection(t.s5PdfSectionBarriers, barriers.isEmpty
          ? [notRecorded]
          : barriers),
    );

    final insurance = <SummaryLine>[];
    for (final key in VisitPrepDraft.insuranceKeys) {
      final v = draft.insuranceNotes[key]?.trim();
      if (v == null || v.isEmpty) continue;
      final line = _free(v, draft.sourceLanguage);
      insurance.add(
        SummaryLine(
          '${s5InsuranceLabel(t, key)}: ${line.text}',
          original: line.original,
          originalLang: line.originalLang,
        ),
      );
    }
    if (insurance.isNotEmpty) {
      sections.add(SummarySection(t.s5PdfSectionInsurance, insurance));
    }

    if (draft.includeEnvironment) {
      final env = environment;
      sections.add(
        SummarySection(t.s5PdfSectionEnvironment, [
          if (env == null)
            SummaryLine(t.s5EnvNotAvailable)
          else ...[
            SummaryLine(
              '${t.s5EnvAirQuality}: ${EnvLabels.airQualityValue(t, env)}',
            ),
            SummaryLine('${t.s5EnvPollen}: ${EnvLabels.pollenValue(t, env)}'),
            SummaryLine('${t.s5EnvFlood}: ${EnvLabels.floodValue(t, env)}'),
            if (env.fetchedAt != null)
              SummaryLine(t.s5UpdatedAt(_dt(env.fetchedAt!.toLocal()))),
            SummaryLine(t.s5PdfEnvNote),
          ],
        ]),
      );
    }

    if (environmentLines.isNotEmpty) {
      sections.add(
        SummarySection(t.s6PdfEnvTitle, [
          for (final line in environmentLines) SummaryLine(line),
          SummaryLine(t.s6PdfEnvLimit),
        ]),
      );
    }

    sections.add(
      SummarySection(t.s5PdfSectionAboutData, [
        SummaryLine(t.s5PdfAboutPatientReported),
        SummaryLine(t.s5PdfAboutMedCheck),
        SummaryLine(t.s5PdfAboutNoScore),
      ]),
    );

    final appendix = <SummaryLine>[];
    for (final e in bundle.inhaler) {
      final note = e.note?.trim();
      if (note == null || note.isEmpty) continue;
      final line = _free(note, e.sourceLanguage);
      appendix.add(
        SummaryLine(
          '${_dt(e.localTime)} · ${t.s5InhalerEntry}: ${line.text}',
          original: line.original,
          originalLang: line.originalLang,
        ),
      );
    }
    for (final e in bundle.symptoms) {
      for (final text in [e.otherText, e.note]) {
        final v = text?.trim();
        if (v == null || v.isEmpty) continue;
        final line = _free(v, e.sourceLanguage);
        appendix.add(
          SummaryLine(
            '${_dt(e.localTime)} · ${t.s5SymptomEntry}: ${line.text}',
            original: line.original,
            originalLang: line.originalLang,
          ),
        );
      }
    }

    return VisitSummaryDoc(
      title: t.s5PdfTitle,
      meta: [
        t.s5PdfPeriod(_d(s.range.start), _d(s.range.end), s.range.days),
        t.s5PdfRecordedDays(s.recordedDays),
        t.s5PdfGeneratedAt(_dt(generatedAt.toLocal())),
      ],
      sections: sections,
      appendix: appendix,
      appendixTitle: t.s5PdfAppendix,
      disclaimer: t.s5PdfDisclaimer,
    );
  }
}

String s5BarrierLabel(AppLocalizations t, String code) => switch (code) {
  'cost' => t.s5BarrierCost,
  'hard_to_get' => t.s5BarrierHardToGet,
  'hard_to_understand' => t.s5BarrierHardToUnderstand,
  'how_to_use' => t.s5BarrierHowToUse,
  'other' => t.s5ReasonOther,
  'none' => t.s5BarrierNone,
  _ => t.s5NoAnswer,
};

String s5InsuranceLabel(AppLocalizations t, String key) => switch (key) {
  'medication_history' => t.s5InsMedHistory,
  'cost' => t.s5InsCost,
  _ => t.s5InsDenial,
};

/// Changes when any record in range or any draft field changes, so an older
/// PDF is never presented as current.
String visitFingerprint(VisitPrepDraft draft, RecordBundle bundle) {
  final row = draft.toRow()
    ..remove('last_generated_at')
    ..remove('last_generated_fingerprint');
  final bytes = utf8.encode(jsonEncode(row));
  var h = 0x811c9dc5;
  for (final b in bytes) {
    h ^= b;
    h = (h * 0x01000193) & 0xffffffff;
  }
  return '${bundle.fingerprint}#${h.toRadixString(16)}';
}
