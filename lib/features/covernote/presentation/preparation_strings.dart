import 'package:flutter/widgets.dart';

String s10(BuildContext c, String key) {
  final lang = Localizations.localeOf(c).languageCode;
  final v = _words[key];
  if (v == null) return key;
  return v[lang == 'ko'
      ? 1
      : lang == 'es'
      ? 2
      : 0];
}

const _words = <String, List<String>>{
  'careRecords': [
    'Records by care profile',
    '돌봄 대상별 기록',
    'Registros por perfil de cuidado',
  ],
  'quantity': [
    'Quantity (blank = unknown)',
    '사용량 (빈칸 = 모름)',
    'Cantidad (vacío = desconocida)',
  ],
  'nightCount': [
    'Night waking count (blank = unknown)',
    '야간 각성 횟수 (빈칸 = 모름)',
    'Veces que se despertó (vacío = desconocido)',
  ],
  'englishSummary': [
    'English summary for care-team review',
    '의료진 검토용 영어 요약',
    'Resumen en inglés para el equipo médico',
  ],
  'newProfile': [
    'Add a separate care profile',
    '별도의 돌봄 대상 추가',
    'Agregar otro perfil de cuidado',
  ],
  'additional': [
    'A scheduled use is already recorded today. Save a separate additional use?',
    '오늘 정기약 사용이 이미 기록되어 있습니다. 별도의 추가 사용을 저장할까요?',
    'Ya registró un uso programado hoy. ¿Desea guardar un uso adicional separado?',
  ],
  'currentBrief': [
    'Matches current sources',
    '현재 자료와 일치',
    'Coincide con las fuentes actuales',
  ],
  'staleBrief': [
    'Sources changed — regenerate before sharing',
    '자료 변경됨 — 공유 전 다시 생성',
    'Las fuentes cambiaron — vuelva a generar antes de compartir',
  ],
  'start': [
    'Prepare for a new treatment',
    '새 치료 승인 준비',
    'Preparar un nuevo tratamiento',
  ],
  'denied': [
    'Start with a denial letter',
    '거절 편지로 시작',
    'Empezar con una carta de denegación',
  ],
  'intro': [
    'Connect your experience to a clear next step for care.',
    '환자의 경험을 다음 진료를 위한 자료로 연결하세요.',
    'Conecte su experiencia con el próximo paso para su atención.',
  ],
  'overview': ['Overview', '개요', 'Resumen'],
  'evidence': ['Evidence to prepare', '준비할 근거', 'Documentos por preparar'],
  'timeline': ['Treatment history', '치료 경과', 'Historial del tratamiento'],
  'share': ['For your care team', '의료진에게 전달', 'Para su equipo médico'],
  'patient': [
    'Selected patient in this account',
    '이 계정의 대상 환자',
    'Paciente seleccionado en esta cuenta',
  ],
  'concern': [
    'What would you like to discuss?',
    '의료진과 상의할 걱정',
    '¿Qué desea consultar?',
  ],
  'current': [
    'Current prescribed treatment (optional)',
    '현재 처방 치료 (선택)',
    'Tratamiento recetado actual (opcional)',
  ],
  'proposed': [
    'Treatment proposed by your clinician (optional)',
    '의료진이 제안한 치료 (선택)',
    'Tratamiento propuesto por su médico (opcional)',
  ],
  'plan': ['Health plan (optional)', '보험 플랜 (선택)', 'Plan de salud (opcional)'],
  'policy': [
    'I checked that the NJ Aetna Dupixent asthma policy applies to this plan and patient (age 12+).',
    'NJ Aetna Dupixent 천식 정책이 이 플랜과 환자(12세 이상)에 적용됨을 확인했습니다.',
    'Confirmé que la política NJ Aetna de Dupixent para asma corresponde al plan y paciente (12 años o más).',
  ],
  'create': [
    'Prepare with the records I have',
    '현재 자료로 준비 시작',
    'Preparar con los registros disponibles',
  ],
  'review': [
    'For clinician review. Linked records do not establish eligibility or approval.',
    '의료진 검토용입니다. 자료 연결은 자격 충족이나 승인을 의미하지 않습니다.',
    'Para revisión médica. Los registros vinculados no determinan elegibilidad ni aprobación.',
  ],
  'voice': ['Speak a short record', '말로 남기기', 'Registrar con la voz'],
  'text': ['Type instead', '대신 글로 입력', 'Escribir en su lugar'],
  'symptom': ['Log a symptom', '증상 기록', 'Registrar un síntoma'],
  'night': ['Night waking', '야간 각성', 'Despertar nocturno'],
  'cough': ['Cough', '기침', 'Tos'],
  'rescue': [
    'Used as-needed medicine',
    '필요 시 약 사용',
    'Usé medicamento de rescate',
  ],
  'scheduled': [
    'Used scheduled medicine',
    '정기약 사용',
    'Usé medicamento programado',
  ],
  'confirm': ['Confirm and save', '확인 후 저장', 'Confirmar y guardar'],
  'cancel': ['Cancel', '취소', 'Cancelar'],
  'save': ['Save', '저장', 'Guardar'],
  'source': ['Source', '출처', 'Fuente'],
  'missing': [
    'Still needed — ask your care team',
    '미확보 — 의료진에게 요청',
    'Falta — solicítelo a su equipo médico',
  ],
  'linked': [
    'Linked · clinical review pending',
    '연결됨 · 의료진 검토 대기',
    'Vinculado · pendiente de revisión médica',
  ],
  'candidate': [
    'Choose existing records',
    '기존 자료 선택',
    'Elegir registros existentes',
  ],
  'upload': [
    'Add a clinical document or notice',
    '진료자료 또는 통지서 추가',
    'Agregar documento clínico o aviso',
  ],
  'original': [
    'Include original files in PDF',
    'PDF에 실제 원본 첨부',
    'Incluir archivos originales en el PDF',
  ],
  'pdf': ['Generate English brief', '의료진용 영어 요약 생성', 'Crear resumen en inglés'],
  'delivery': [
    'Record a handoff I made',
    '직접 전달한 내역 기록',
    'Registrar una entrega realizada',
  ],
  'undo': ['Undo', '되돌리기', 'Deshacer'],
  'saved': [
    'Saved. Your treatment summary has been updated.',
    '저장했습니다. 치료 요약이 갱신되었습니다.',
    'Guardado. Se actualizó el resumen del tratamiento.',
  ],
  'pending': [
    'Saved on this device · sync pending',
    '기기에 저장됨 · 동기화 대기',
    'Guardado en este dispositivo · pendiente de sincronización',
  ],
  'retry': ['Retry sync', '동기화 재시도', 'Reintentar sincronización'],
  'error': [
    'Could not finish. Check your connection and retry. A newer edit may require reopening this case.',
    '완료하지 못했습니다. 연결을 확인하고 다시 시도하세요. 다른 곳의 최신 수정이 있으면 케이스를 다시 여세요.',
    'No se pudo completar. Revise la conexión y reintente. Si hubo otra edición, vuelva a abrir el caso.',
  ],
  'demo': [
    'Synthetic patient example',
    '합성 환자 예시',
    'Ejemplo de paciente sintético',
  ],
  'demoA': [
    'Example A · before the first request',
    '예시 A · 최초 신청 전',
    'Ejemplo A · antes de solicitar',
  ],
  'demoB': [
    'Example B · already denied',
    '예시 B · 이미 거절된 경우',
    'Ejemplo B · ya denegado',
  ],
  'consent': [
    'To process this record, the transcript or selected document is sent to the configured AI service. Audio recognition may use your device provider’s servers. CoverNote does not save raw audio. You will review the result before saving.',
    '기록 처리를 위해 원문 텍스트 또는 선택 문서를 설정된 AI 서비스로 보냅니다. 음성 인식은 기기 제공자의 서버를 사용할 수 있습니다. CoverNote는 원음을 저장하지 않습니다. 결과를 확인한 뒤 저장합니다.',
    'Para procesar el registro, el texto o documento se envía al servicio de IA configurado. El reconocimiento puede usar los servidores del proveedor del dispositivo. CoverNote no guarda audio. Revise el resultado antes de guardar.',
  ],
  'allow': [
    'Allow processing this time',
    '이번 처리 허용',
    'Permitir este procesamiento',
  ],
  'unknown': [
    'Unknown — please confirm',
    '모름 — 확인 필요',
    'Desconocido — confirme',
  ],
  'date': [
    'Record date (YYYY-MM-DD)',
    '기록 날짜 (YYYY-MM-DD)',
    'Fecha del registro (AAAA-MM-DD)',
  ],
  'notification': [
    'Enable one direct record action',
    '앱 밖 기록 버튼 켜기',
    'Activar una acción de registro directo',
  ],
  'notificationHint': [
    'An unlocked notification action will save the explicitly selected scheduled use on this device. It syncs when CoverNote resumes. Pause it at any time.',
    '잠금 해제된 알림 버튼에서 선택한 정기약 사용을 기기에 저장합니다. 앱 재개 시 동기화됩니다. 언제든 중지할 수 있습니다.',
    'La acción de notificación desbloqueada guarda el uso programado seleccionado en el dispositivo. Se sincroniza al volver a CoverNote. Puede pausarla.',
  ],
  'pause': ['Pause direct recording', '앱 밖 기록 중지', 'Pausar registro directo'],
  'receipt': [
    'This is your report of a handoff, not confirmation of receipt or an insurance submission.',
    '본인의 전달 보고입니다. 수신 확인 또는 보험 신청 접수가 아닙니다.',
    'Es su registro de entrega; no confirma recepción ni envío al seguro.',
  ],
  'empty': [
    'No records in this period. Missing days do not mean no symptoms or no medicine use.',
    '이 기간의 기록이 없습니다. 미기록일은 무증상이나 미복약을 뜻하지 않습니다.',
    'No hay registros en este período. Un día sin registrar no indica ausencia de síntomas ni de uso.',
  ],
  'stop': ['Stop recording', '녹음 중지', 'Detener grabación'],
};
