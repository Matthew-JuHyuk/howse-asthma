import 'appeal_models.dart';

class ExplanationItem {
  const ExplanationItem({required this.text, required this.sourceRefs});

  final String text;
  final List<SourceRef> sourceRefs;
}

class PlainExplanation {
  const PlainExplanation({
    required this.language,
    required this.factRevision,
    required this.reason,
    required this.nextAction,
    required this.deadline,
  });

  final String language;
  final int factRevision;
  final ExplanationItem reason;
  final ExplanationItem nextAction;
  final ExplanationItem deadline;
}

/// Three labeled items. Medication and dose tokens are copied, not translated.
PlainExplanation buildExplanation(
  AppealCase item, {
  required String language,
  required DeadlineOutcome deadline,
}) {
  final lang = switch (language) {
    'es' => 'es',
    'ko' => 'ko',
    _ => 'en',
  };
  final med = item.medicationRaw.rawText;
  final dose = item.doseRaw.rawText;
  final reasonRaw = item.denialReason?.rawText;

  return PlainExplanation(
    language: lang,
    factRevision: item.factRevision,
    reason: ExplanationItem(
      text: _reason(lang, med, dose, reasonRaw),
      sourceRefs: item.denialReason?.sourceRefs ?? const [],
    ),
    nextAction: ExplanationItem(
      text: _next(lang),
      sourceRefs: item.deadline.sourceRefs,
    ),
    deadline: ExplanationItem(
      text: _deadline(lang, item, deadline),
      sourceRefs: item.deadline.sourceRefs,
    ),
  );
}

bool explanationPreservesTokens(AppealCase item, PlainExplanation explanation) {
  final blob =
      '${explanation.reason.text}\n${explanation.nextAction.text}\n${explanation.deadline.text}';
  final med = item.medicationRaw.rawText;
  final dose = item.doseRaw.rawText;
  if (med != null && med.isNotEmpty && !blob.contains(med)) return false;
  if (dose != null && dose.isNotEmpty && !blob.contains(dose)) return false;
  return true;
}

String _reason(String lang, String? med, String? dose, String? reason) {
  final tokens = [
    if (med != null && med.isNotEmpty) med,
    if (dose != null && dose.isNotEmpty) dose,
  ].join(' ');
  if (reason == null || reason.trim().isEmpty) {
    return switch (lang) {
      'es' =>
        tokens.isEmpty
            ? 'No se pudo confirmar el motivo.'
            : 'No se pudo confirmar el motivo. El aviso nombra $tokens.',
      'ko' =>
        tokens.isEmpty
            ? '이유를 확인하지 못했습니다.'
            : '이유를 확인하지 못했습니다. 통지서에 적힌 이름은 $tokens 입니다.',
      _ =>
        tokens.isEmpty
            ? 'The reason could not be confirmed.'
            : 'The reason could not be confirmed. The notice names $tokens.',
    };
  }
  return switch (lang) {
    'es' =>
      'El aviso nombra $tokens y dice que no cubre el pedido porque: $reason',
    'ko' => '통지서는 $tokens 에 대해 비용을 지급하지 않는다고 적었습니다. 이유는 다음과 같습니다. $reason',
    _ =>
      'The notice names $tokens and says the plan will not pay because: $reason',
  };
}

String _next(String lang) {
  return switch (lang) {
    'es' =>
      'Siga los pasos escritos en el aviso y prepare preguntas para su clínico y el plan. Esta aplicación no envía una apelación.',
    'ko' =>
      '통지서에 적힌 절차에 따라 의사와 보험에 물어볼 내용을 준비하세요. 이 앱은 항소 서류를 제출하지 않습니다.',
    _ =>
      'Follow the steps written in the notice and prepare questions for your clinician and the plan. This app does not send an appeal.',
  };
}

String _deadline(String lang, AppealCase item, DeadlineOutcome outcome) {
  final raw = item.deadline.rawText;
  return switch (outcome.display) {
    DeadlineDisplay.documentDate => switch (lang) {
      'es' =>
        'El aviso escribe un plazo: ${raw ?? _ymd(outcome.date)}. Confirme esa fecha. No indica si aceptarían una apelación.',
      'ko' =>
        '통지서에 적힌 기한은 ${raw ?? _ymd(outcome.date)} 입니다. 그 날짜를 확인하세요. 접수가 되는지는 알려 주지 않습니다.',
      _ =>
        'The notice writes this deadline: ${raw ?? _ymd(outcome.date)}. Confirm that date. It does not say whether a filing would be accepted.',
    },
    DeadlineDisplay.calculatedFromReceived => switch (lang) {
      'es' =>
        'Calculado a partir de la fecha de recepción que usted ingresó: ${_ymd(outcome.date)}. No es un plazo legal automático.',
      'ko' =>
        '입력한 수령일 기준으로 계산한 날짜는 ${_ymd(outcome.date)} 입니다. 모든 보험에 같은 기한을 적용한 것은 아닙니다.',
      _ =>
        'Calculated from the received date you entered: ${_ymd(outcome.date)}. This is not a universal legal deadline.',
    },
    DeadlineDisplay.needsReceivedDate => switch (lang) {
      'es' =>
        'El aviso cuenta los días después de recibirlo. Falta la fecha de recepción, así que no hay una fecha calculada.',
      'ko' => '통지서는 받은 날부터 며칠로 적혀 있습니다. 수령일이 없어 날짜를 계산하지 않았습니다.',
      _ =>
        'The notice counts days after you receive it. There is no received date, so no date was calculated.',
    },
    DeadlineDisplay.notCalculable => switch (lang) {
      'es' =>
        'El texto del plazo no es claro. Se muestra el original y no se calculó una fecha.',
      'ko' => '기한 문장이 분명하지 않습니다. 원문을 보여 주며 날짜는 계산하지 않았습니다.',
      _ =>
        'The deadline wording is unclear. The original text is shown and no date was calculated.',
    },
    DeadlineDisplay.notFound => switch (lang) {
      'es' =>
        'No se encontró un plazo en el documento. Consulte al plan.',
      'ko' => '문서에서 기한을 확인하지 못했습니다. 보험사에 확인하세요.',
      _ =>
        'A deadline was not found in the document. Ask the plan.',
    },
  };
}

String _ymd(DateTime? date) {
  if (date == null) return '';
  final m = date.month.toString().padLeft(2, '0');
  final d = date.day.toString().padLeft(2, '0');
  return '${date.year}-$m-$d';
}
