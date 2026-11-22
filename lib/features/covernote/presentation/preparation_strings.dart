import 'package:flutter/widgets.dart';

String s10(BuildContext c, String key) {
  final lang = Localizations.localeOf(c).languageCode;
  final v = _words[key] ?? _words['details']!;
  return v[lang == 'ko'
      ? 1
      : lang == 'es'
      ? 2
      : 0];
}

const _words = <String, List<String>>{
  'envUnavailable': [
    'No interpretable reading available',
    '해석할 수 있는 관측값이 없어요',
    'No hay una lectura interpretable',
  ],
  'envAirGood': [
    'Air quality was good',
    '공기질이 좋았어요',
    'La calidad del aire era buena',
  ],
  'envAirModerate': [
    'Air quality was moderate',
    '공기질이 보통이었어요',
    'La calidad del aire era moderada',
  ],
  'envAirSensitive': [
    'Air quality was unhealthy for sensitive groups',
    '민감한 사람에게 좋지 않은 공기였어요',
    'El aire era insalubre para grupos sensibles',
  ],
  'envAirUnhealthy': [
    'Air quality was unhealthy',
    '공기질이 나빴어요',
    'La calidad del aire era insalubre',
  ],
  'envAirVeryUnhealthy': [
    'Air quality was very unhealthy',
    '공기질이 매우 나빴어요',
    'La calidad del aire era muy insalubre',
  ],
  'envAirHazardous': [
    'Air quality was hazardous',
    '공기질이 위험 수준이었어요',
    'La calidad del aire era peligrosa',
  ],
  'envDry': [
    'Outdoor air was relatively dry',
    '바깥 공기가 비교적 건조했어요',
    'El aire exterior era relativamente seco',
  ],
  'envHumidityMid': [
    'Outdoor humidity was in the middle range',
    '바깥 습도가 중간 범위였어요',
    'La humedad exterior estaba en el rango medio',
  ],
  'envHumid': [
    'Outdoor air was humid',
    '바깥 공기가 습했어요',
    'El aire exterior era húmedo',
  ],
  'envPollenNone': [
    'Pollen level: none',
    '꽃가루 지수: 없음',
    'Nivel de polen: ninguno',
  ],
  'envPollenVeryLow': [
    'Pollen level: very low',
    '꽃가루 지수: 매우 낮음',
    'Nivel de polen: muy bajo',
  ],
  'envPollenLow': ['Pollen level: low', '꽃가루 지수: 낮음', 'Nivel de polen: bajo'],
  'envPollenModerate': [
    'Pollen level: moderate',
    '꽃가루 지수: 보통',
    'Nivel de polen: moderado',
  ],
  'envPollenHigh': ['Pollen level: high', '꽃가루 지수: 높음', 'Nivel de polen: alto'],
  'envPollenVeryHigh': [
    'Pollen level: very high',
    '꽃가루 지수: 매우 높음',
    'Nivel de polen: muy alto',
  ],
  'envFloodWarning': [
    'A regional flash-flood warning was reported',
    '지역 돌발홍수 경보가 있었어요',
    'Se informó una alerta regional de inundación repentina',
  ],
  'envNoFloodWarning': [
    'No regional flash-flood warning was reported',
    '조회된 지역 돌발홍수 경보가 없었어요',
    'No se informó una alerta regional de inundación repentina',
  ],
  'envForecast': ['Forecast', '예보', 'Pronóstico'],
  'envSample': ['Demo example', '데모 예시', 'Ejemplo de demostración'],
  'envReading': ['Saved reading', '저장된 수치', 'Lectura guardada'],
  'envSource': ['Source', '출처', 'Fuente'],
  'envArea': ['Area', '지역', 'Zona'],
  'envTime': ['Observation time', '관측 시각', 'Hora de observación'],
  'envFetched': ['Retrieved at', '조회 시각', 'Hora de consulta'],
  'envContext': [
    'Regional information, not a measurement of personal exposure. Missing readings stay unknown.',
    '지역 정보이며 개인의 실제 노출량을 측정한 값은 아니에요. 없는 자료는 추정하지 않아요.',
    'Información regional, no una medición de exposición personal. Los datos faltantes quedan desconocidos.',
  ],
  'envHumidityBands': [
    'Humidity wording: below 40% relatively dry, 40–69% middle range, 70% or more humid. Descriptive ranges, not medical risk levels or evidence of flooding or indoor mold.',
    '습도 표현: 40% 미만은 비교적 건조, 40~69%는 중간, 70% 이상은 습함. 설명용 구간이며 의료 위험도나 침수·실내 곰팡이를 뜻하지 않아요.',
    'Humedad: menos del 40% relativamente seco, 40–69% rango medio, 70% o más húmedo. Rangos descriptivos, no riesgo médico ni evidencia de inundación o moho interior.',
  ],
  'puffUnit': ['puffs', '회 흡입', 'inhalaciones'],
  'notUsed': ['Not used', '사용하지 않음', 'No utilizado'],
  'recordSaved': ['Record saved', '기록을 남겼어요', 'Registro guardado'],
  'humidity': ['Humidity', '습도', 'Humedad'],
  'chooseMedicine': [
    'Which medicine did you use?',
    '사용한 약을 선택해 주세요',
    '¿Qué medicamento usó?',
  ],
  'registerMedicine': ['Add my medicine', '내 약 등록', 'Añadir medicamento'],
  'registerMedicineHint': [
    'Add your medicine to record it with one tap.',
    '약을 등록하면 버튼 한 번으로 기록할 수 있어요.',
    'Añada su medicamento para registrarlo con un toque.',
  ],
  'patientLogPdf': [
    '30-day patient log PDF',
    '최근 30일 기록 PDF',
    'PDF del registro de 30 días',
  ],
  'autoRecordQuestion': [
    'How are you feeling? What medicine did you use?',
    '몸 상태나 사용한 약을 알려주세요',
    '¿Cómo se siente? ¿Qué medicamento usó?',
  ],
  'autoRecordExample': [
    'Example: I used my inhaler this morning. I coughed last night.\nAI sorts symptoms and medicine use for you.',
    '예: 아침에 흡입기를 썼어요. 어젯밤에는 기침이 났어요.\nAI가 증상과 약 사용을 나누어 정리해요.',
    'Ejemplo: Usé mi inhalador esta mañana. Anoche tuve tos.\nLa IA organiza los síntomas y el uso de medicamentos.',
  ],
  'voicePermission': [
    'Allow microphone access in app settings, then try again. You can also type below.',
    '앱 설정에서 마이크 권한을 허용한 뒤 다시 시도해 주세요. 아래에 직접 입력해도 돼요.',
    'Permita el acceso al micrófono en ajustes y vuelva a intentarlo. También puede escribir abajo.',
  ],
  'voiceNetwork': [
    'Voice recognition could not connect. Check your connection or type below.',
    '음성 서비스에 연결하지 못했어요. 인터넷 연결을 확인하거나 아래에 직접 입력해 주세요.',
    'No se pudo conectar al servicio de voz. Revise la conexión o escriba abajo.',
  ],
  'voiceUnavailable': [
    'Voice recognition is unavailable on this device. Check your phone’s voice input service or type below.',
    '휴대폰의 음성 서비스를 사용할 수 없어요. 휴대폰 음성 입력 설정을 확인하거나 아래에 직접 입력해 주세요.',
    'El servicio de voz no está disponible. Revise la entrada de voz del teléfono o escriba abajo.',
  ],
  'openSettings': ['Open app settings', '앱 설정 열기', 'Abrir ajustes'],
  'quickToday': [
    'Record today’s medicine use',
    '오늘 약 사용 기록',
    'Registrar el uso de hoy',
  ],
  'quickUseHint': [
    'Check the medicine and amount shown, then tap after use. Use voice or typing if you used a different amount.',
    '표시된 약과 양을 확인하고 사용 후 눌러 주세요. 다른 양을 사용했다면 말하거나 직접 입력해 주세요.',
    'Revise el medicamento y la cantidad antes de registrar su uso. Si usó otra cantidad, hable o escriba.',
  ],
  'scheduledReport': [
    'I used my scheduled medicine. Name and dose not specified.',
    '정기적으로 사용하는 약을 사용했어요. 이름과 용량은 입력하지 않았어요.',
    'Usé mi medicamento habitual. No indiqué nombre ni dosis.',
  ],
  'rescueReport': [
    'I used my as-needed medicine or inhaler. Name and dose not specified.',
    '필요할 때 쓰는 약이나 흡입기를 사용했어요. 이름과 용량은 입력하지 않았어요.',
    'Usé mi medicamento o inhalador de alivio. No indiqué nombre ni dosis.',
  ],
  'linkedHistory': ['Connected records', '연결한 기록', 'Registros vinculados'],
  'linkedHistoryHelp': [
    'Only records connected to this case appear here. Add daily records in Records.',
    '이 케이스에 연결한 기록만 보여요. 매일의 기록은 하단 기록 메뉴에서 남겨 주세요.',
    'Aquí solo aparecen registros vinculados a este caso. Añada sus registros diarios en Registros.',
  ],
  "recordEntry": ["Record", "기록하기", "Registrar"],
  "recordWelcome": [
    "A few words are enough",
    "짧게 남겨도 괜찮아요",
    "Bastan unas pocas palabras",
  ],
  "recordWelcomeBody": [
    "Speak naturally, or type. You can check and change everything before saving.",
    "편하게 말하거나 직접 입력하세요. 저장 전에 내용을 확인하고 고칠 수 있어요.",
    "Hable con naturalidad o escriba. Podrá revisar y cambiar todo antes de guardar.",
  ],
  "feelPrompt": ["Symptoms", "증상", "Síntomas"],
  "medicinePrompt": ["Medicine", "약 사용", "Medicamentos"],
  "dayPrompt": ["My day", "하루 상태", "Mi día"],
  "feelPromptQuestion": [
    "How did you feel? When did it happen?",
    "어떤 증상이 있었나요? 언제였나요?",
    "¿Cómo se sintió? ¿Cuándo ocurrió?",
  ],
  "feelPromptExample": [
    "Example: Last night I coughed and woke up twice.",
    "예: 어젯밤 기침 때문에 두 번 깼어요.",
    "Ejemplo: Anoche tuve tos y me desperté dos veces.",
  ],
  "medicinePromptQuestion": [
    "What medicine did you use, and when?",
    "어떤 약을 언제 사용했나요?",
    "¿Qué medicamento usó y cuándo?",
  ],
  "medicinePromptExample": [
    "Example: I used my morning inhaler. I do not remember the name.",
    "예: 아침에 흡입기를 썼어요. 이름은 기억나지 않아요.",
    "Ejemplo: Usé mi inhalador por la mañana. No recuerdo el nombre.",
  ],
  "dayPromptQuestion": [
    "Did anything make sleep or activity difficult?",
    "잠을 자거나 움직일 때 불편했나요?",
    "¿Algo le dificultó dormir o realizar actividades?",
  ],
  "dayPromptExample": [
    "Example: Today I felt short of breath while walking.",
    "예: 오늘 걸을 때 숨이 조금 찼어요.",
    "Ejemplo: Hoy me faltó el aire al caminar.",
  ],
  "startSpeaking": ["Start speaking", "말하기 시작", "Empezar a hablar"],
  "voiceAnyLanguage": [
    "Listens in the language selected in the app. A supported phone may detect another language.",
    "앱에서 고른 언어로 듣습니다. 기기가 지원하면 다른 언어도 알아듣습니다.",
    "Escucha el idioma elegido en la app. Si el teléfono lo permite, detecta otro.",
  ],
  "preferTyping": ["I prefer to type", "직접 입력할게요", "Prefiero escribir"],
  "yourWords": ["Your record", "내가 남길 내용", "Su registro"],
  "recordHint": [
    "Use your own words. It is okay not to know a medicine name or amount.",
    "평소 쓰는 말로 적어 주세요. 약 이름이나 양은 몰라도 괜찮아요.",
    "Use sus propias palabras. No pasa nada si no sabe el nombre o la cantidad.",
  ],
  "reviewRecord": [
    "Review before saving",
    "내용 확인하기",
    "Revisar antes de guardar",
  ],
  "listening": [
    "Listening… Tap Stop when you are done.",
    "듣고 있어요. 다 말했으면 중지를 눌러 주세요.",
    "Escuchando… Pulse Detener al terminar.",
  ],
  "voiceFallback": [
    "I could not hear that. Try again, or type below.",
    "말소리를 확인하지 못했어요. 다시 말하거나 직접 입력해 주세요.",
    "No pude escucharle. Inténtelo de nuevo o escriba.",
  ],
  "nothingToRecord": [
    "Add a symptom or medicine you used, and when it happened.",
    "증상이나 사용한 약, 언제 있었던 일인지 조금 더 적어 주세요.",
    "Añada un síntoma o medicamento y cuándo ocurrió.",
  ],
  "recordRetry": [
    "Your words are still here. Check your connection and try again.",
    "입력한 내용은 그대로 있어요. 연결 상태를 확인한 뒤 다시 시도해 주세요.",
    "Su texto sigue aquí. Revise la conexión e inténtelo de nuevo.",
  ],
  "centerHint": [
    "Use the microphone below to speak or type a record.",
    "하단 마이크를 눌러 말하거나 직접 입력할 수 있어요.",
    "Use el micrófono de abajo para hablar o escribir un registro.",
  ],
  "privacySettings": [
    "Privacy and AI permissions",
    "개인정보·AI 사용 동의",
    "Privacidad y permisos de IA",
  ],
  "advancedSettings": [
    "Service and account management",
    "서비스·계정 관리",
    "Servicio y gestión de cuenta",
  ],

  'recordCount': ['Records', '기록', 'Registros'],
  'symptomRecord': ['Symptoms', '증상 기록', 'Síntomas'],
  'chooseRecords': [
    'Choose the records you want to include.',
    '포함할 기록을 선택해 주세요.',
    'Elija los registros que desea incluir.',
  ],

  "purpose": [
    "Prepare your insurance paperwork",
    "보험 서류 준비를 도와드려요",
    "Prepare sus documentos del seguro",
  ],
  "purposeBody": [
    "Understand the letter, gather records, and prepare a summary for your care team.",
    "받은 서류를 이해하고, 필요한 기록을 모아 의료진과 검토할 자료를 만들어요.",
    "Comprenda la carta, reúna registros y prepare un resumen para su equipo médico.",
  ],
  "nextStep": ["Your next step", "다음 할 일", "Su próximo paso"],
  "gatherStep": ["Gather your documents", "필요한 자료 모으기", "Reunir documentos"],
  "reviewStep": ["Review and share", "확인하고 전달하기", "Revisar y compartir"],
  "connectRecords": [
    "Connect these records",
    "이 기록 연결하기",
    "Vincular estos registros",
  ],
  "reviewSuggested": [
    "Matching records are selected for review. Check the summary, then connect them together. You can change the selection.",
    "관련 기록을 모아두었어요. 내용을 확인한 뒤 한 번에 연결하세요. 필요하면 선택을 바꿀 수 있어요.",
    "Los registros relacionados están seleccionados. Revise el resumen y vincúlelos juntos. Puede cambiar la selección.",
  ],
  "changeSelection": ["Change selection", "선택 바꾸기", "Cambiar selección"],
  "clearSelection": ["Clear selection", "선택 해제", "Quitar selección"],
  "selectAll": ["Select all", "모두 선택", "Seleccionar todo"],
  "noMatchingRecords": [
    "No matching records yet. Add a document or record first.",
    "연결할 기록이 아직 없어요. 문서나 하루 기록을 먼저 추가해 주세요.",
    "Aún no hay registros relacionados. Añada un documento o registro primero.",
  ],
  "recentMonth": ["Last 30 days", "최근 30일", "Últimos 30 días"],
  "recentYear": ["Last 12 months", "최근 12개월", "Últimos 12 meses"],
  "recordedDays": ["Days recorded", "기록한 날", "Días registrados"],
  "visit": ["Care visit", "진료 기록", "Consulta médica"],
  "document": ["Document", "문서", "Documento"],
  "otherCase": [
    "Start another request",
    "다른 요청 준비하기",
    "Preparar otra solicitud",
  ],
  "dailySupport": [
    "Keep a brief daily record",
    "오늘의 기록 남기기",
    "Lleve un registro diario",
  ],
  "dailySupportBody": [
    "Your medicine and symptom records can support the documents you prepare.",
    "약 사용과 증상을 기록하면 서류 준비에 함께 활용할 수 있어요.",
    "Sus registros de medicamentos y síntomas pueden apoyar sus documentos.",
  ],
  "linkedHelp": [
    "Connected records are ready for your review. Missing documents can be added later.",
    "연결한 자료를 확인하세요. 부족한 문서는 나중에 더할 수 있어요.",
    "Revise los registros vinculados. Puede añadir documentos faltantes después.",
  ],
  "checkPatient": [
    "I confirm these records are for this person.",
    "이 사람의 기록이 맞습니다.",
    "Confirmo que estos registros son de esta persona.",
  ],
  "information_response": [
    "Additional information due",
    "추가 자료 제출 기한",
    "Fecha para información adicional",
  ],
  "review_request": [
    "Review request due",
    "재검토 요청 기한",
    "Fecha para solicitar revisión",
  ],
  "processing": [
    "Preparing… Please keep this screen open.",
    "정리하고 있어요. 잠시만 기다려 주세요.",
    "Preparando… Mantenga esta pantalla abierta.",
  ],

  'translateRecord': [
    'Translate into my language',
    '내 언어로 번역',
    'Traducir a mi idioma',
  ],
  'dashboard': [
    'Your next step for care',
    '진료 준비, 다음 할 일을 확인하세요',
    'Su próximo paso para la atención',
  ],
  'newHelp': [
    'Prepare documents before asking for coverage.',
    '보험에 요청하기 전, 필요한 자료를 준비해요.',
    'Prepare documentos antes de solicitar cobertura.',
  ],
  'denialHelp': [
    'Understand the letter and collect what is missing.',
    '거절 사유를 확인하고 빠진 자료를 모아요.',
    'Revise la carta y reúna lo que falta.',
  ],
  'progress': ['Documents connected', '연결된 자료', 'Documentos vinculados'],
  'recordWindow': [
    'Days recorded in the last 30 days. This is not a required minimum.',
    '최근 30일 중 기록한 날입니다. 필수 기록 기간은 아닙니다.',
    'Días registrados en los últimos 30 días. No es un mínimo obligatorio.',
  ],
  'voiceGuide': [
    'What medicine did you use? How did you feel? When?',
    '어떤 약을 쓰셨나요? 불편한 증상은요? 언제였나요?',
    '¿Qué medicamento usó? ¿Cómo se sintió? ¿Cuándo?',
  ],
  'voiceExample': [
    'Example: Yesterday I coughed at night. I do not know the medicine name.',
    '예: 어젯밤에 기침했어요. 약 이름은 모르겠어요.',
    'Ejemplo: Anoche tuve tos. No sé el nombre del medicamento.',
  ],
  'medPhoto': [
    'My medicines · add a photo',
    '내 약 관리 · 사진으로 등록',
    'Mis medicamentos · añadir foto',
  ],
  'originalWords': ['Original words', '입력한 원문', 'Texto original'],
  'treatmentDocs': ['Medicine history', '약을 쓴 기록', 'Historial de medicamentos'],
  'burdenDocs': ['Symptoms and visits', '증상과 진료 기록', 'Síntomas y consultas'],
  'testDocs': ['Test results', '검사 결과', 'Resultados de pruebas'],
  'environmentDay': [
    'Air and weather that day',
    '이날의 공기와 날씨',
    'Aire y clima de ese día',
  ],
  'traffic_air': [
    'Hazy air near traffic',
    '교통량이 많은 곳의 탁한 공기',
    'Aire brumoso cerca del tráfico',
  ],
  'humid_after_rain': [
    'Humid conditions after rain',
    '비가 온 뒤 습한 환경',
    'Condiciones húmedas después de la lluvia',
  ],
  'pollen': [
    'Pollen noted that day',
    '이날 꽃가루가 있었다는 기록',
    'Polen registrado ese día',
  ],
  'calm': ['Mild outdoor conditions', '비교적 편안한 날씨', 'Condiciones suaves'],
  'details': ['See details', '자세히 보기', 'Ver detalles'],
  'tapInstead': ['Or tap to record', '버튼으로 기록하기', 'O registra con un botón'],
  'careRecords': [
    'Records by care profile',
    '누구의 기록인가요?',
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
    '진료 자료 준비하기',
    'Preparar un nuevo tratamiento',
  ],
  'denied': [
    'Start with a denial letter',
    '거절 편지로 시작',
    'Empezar con una carta de denegación',
  ],
  'intro': ['How are you today?', '오늘은 어떠셨나요?', '¿Cómo se siente hoy?'],
  'visitAsk': [
    'What should we prepare for your clinician?',
    '진료에서 무엇을 준비할까요?',
    '¿Qué preparamos para su médico?',
  ],
  'visitBody': [
    'These are already selected. Turn one off if it does not fit, then continue.',
    '기본으로 선택해 두었습니다. 해당하지 않으면 끄고, 맞으면 바로 다음으로 가세요.',
    'Ya están seleccionados. Desactive uno si no aplica y continúe.',
  ],
  'optBetterMed': [
    'I want my clinician to consider a medicine that controls symptoms better.',
    '증상이 더 잘 조절되는 약을 의료진이 검토해 주었으면 합니다.',
    'Quiero que mi médico valore un medicamento que controle mejor los síntomas.',
  ],
  'optLog': [
    'Include the symptom and medicine log already in this account.',
    '이 계정에 있는 증상과 약 사용 기록을 포함합니다.',
    'Incluir el registro de síntomas y medicamentos de esta cuenta.',
  ],
  'optReview': [
    'I will check the summary before it is shared.',
    '공유하기 전에 요약을 확인하겠습니다.',
    'Revisaré el resumen antes de compartirlo.',
  ],
  'overview': ['Overview', '개요', 'Resumen'],
  'evidence': ['Your documents', '내 자료', 'Sus documentos'],
  'timeline': ['Daily records', '하루 기록', 'Registro diario'],
  'share': ['For your care team', '의료진에게 전달', 'Para su equipo médico'],
  'patient': [
    'Selected patient in this account',
    '누구의 기록인가요?',
    'Paciente seleccionado en esta cuenta',
  ],
  'concern': [
    'What would you like to discuss?',
    '무엇이 걱정되세요?',
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
  'night': ['Woke up at night', '밤에 잠에서 깸', 'Se despertó por la noche'],
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
