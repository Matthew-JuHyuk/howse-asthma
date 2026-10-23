// Sprint 9 shared types. Meanings stay separate: document job, artifact,
// lifecycle, delivery, and consent are not one status field.

enum CaseLifecycle { active, completed, archived }

enum TreatmentContext { asthma, other, unknown }

enum DeliveryRecipient { clinic, insurer, self, other }

enum DeliveryMethod {
  email,
  message,
  portal,
  fax,
  mail,
  inPerson,
  other,
  unknown,
}

enum ConsentPurpose { letter, label, translate, treatment }

enum RecordQueryState {
  loading,
  available,
  genuinelyEmpty,
  filteredOut,
  syncPending,
  fetchError,
  permissionError,
}

enum UseKind { scheduled, asNeeded, unspecified }

enum EnvAttachState { pending, ready, unavailable, failed }

class DeliveryEvent {
  const DeliveryEvent({
    required this.id,
    required this.caseId,
    required this.recipient,
    required this.method,
    required this.sentAt,
    this.artifactId,
    this.artifactRevision,
    this.note,
    this.revokedAt,
  });

  final String id;
  final String caseId;
  final DeliveryRecipient recipient;
  final DeliveryMethod method;
  final DateTime sentAt;
  final String? artifactId;
  final int? artifactRevision;
  final String? note;
  final DateTime? revokedAt;

  bool get active => revokedAt == null;
  bool get countsAsDelivery => active && recipient != DeliveryRecipient.self;

  factory DeliveryEvent.fromRow(Map row) => DeliveryEvent(
    id: row['id'] as String,
    caseId: row['case_id'] as String,
    recipient: parseRecipient(row['recipient_type'] as String?),
    method: parseMethod(row['method'] as String?),
    sentAt:
        DateTime.tryParse(row['sent_at'] as String? ?? '')?.toUtc() ??
        DateTime.now().toUtc(),
    artifactId: row['artifact_id'] as String?,
    artifactRevision: (row['artifact_revision'] as num?)?.toInt(),
    note: row['note'] as String?,
    revokedAt: row['revoked_at'] is String
        ? DateTime.tryParse(row['revoked_at'] as String)
        : null,
  );
}

class MedicationUseEvent {
  const MedicationUseEvent({
    required this.id,
    required this.useKind,
    required this.occurredAt,
    required this.localDate,
    this.medicationId,
    this.medicationName,
    this.quantity,
    this.unit,
    this.scheduledInstanceId,
    this.inputPath,
    this.syncStatus = 'synced',
    this.envStatus,
    this.sourceTable,
    this.sourceId,
    this.clientRequestId,
    this.undone = false,
  });

  final String id;
  final UseKind useKind;
  final DateTime occurredAt;
  final DateTime localDate;
  final String? medicationId;
  final String? medicationName;
  final double? quantity;
  final String? unit;
  final String? scheduledInstanceId;
  final String? inputPath;
  final String syncStatus;
  final String? envStatus;
  final String? sourceTable;
  final String? sourceId;
  final String? clientRequestId;
  final bool undone;

  factory MedicationUseEvent.fromRow(Map row) => MedicationUseEvent(
    id: row['id'] as String,
    useKind: parseUseKind(row['use_kind'] as String?),
    occurredAt:
        DateTime.tryParse(row['occurred_at'] as String? ?? '')?.toUtc() ??
        DateTime.now().toUtc(),
    localDate: DateTime.parse(row['local_date'] as String),
    medicationId: row['medication_id'] as String?,
    medicationName: row['medication_name'] as String?,
    quantity: (row['quantity'] as num?)?.toDouble(),
    unit: row['unit'] as String?,
    scheduledInstanceId: row['scheduled_instance_id'] as String?,
    inputPath: row['input_path'] as String?,
    syncStatus: row['sync_status'] as String? ?? 'synced',
    envStatus: row['env_status'] as String?,
    sourceTable: row['source_table'] as String?,
    sourceId: row['source_id'] as String?,
    clientRequestId: row['client_request_id'] as String?,
    undone: row['undone_at'] != null,
  );
}

class PageTranslation {
  const PageTranslation({
    required this.pageNumber,
    required this.status,
    this.text,
  });

  final int pageNumber;

  /// pending / ready / failed / hard_to_read
  final String status;
  final String? text;
}

class LabelExtract {
  const LabelExtract({
    this.name,
    this.strength,
    this.form,
    this.directions,
    this.unclear = const [],
    this.needsLabelPhoto = false,
  });

  final String? name;
  final String? strength;
  final String? form;
  final String? directions;
  final List<String> unclear;
  final bool needsLabelPhoto;
}

class EnvironmentReading {
  const EnvironmentReading({
    required this.metric,
    this.value,
    this.unit,
    this.provider,
    this.observedAt,
    this.fetchedAt,
    this.locationLabel,
    this.locationPrecision,
    this.sourceKind,
    this.detail,
    this.status = 'ready',
  });

  final String metric;
  final double? value;
  final String? unit;
  final String? provider;
  final DateTime? observedAt;
  final DateTime? fetchedAt;
  final String? locationLabel;
  final String? locationPrecision;
  final String? sourceKind;

  /// Category text such as a TRAP level or pollen type. Not a measurement
  /// the phone took.
  final String? detail;
  final String status;

  Map<String, Object?> toJson() => {
    'metric': metric,
    'value': value,
    'unit': unit,
    'provider': provider,
    'observed_at': observedAt?.toUtc().toIso8601String(),
    'fetched_at': fetchedAt?.toUtc().toIso8601String(),
    'detail': detail,
    'status': status,
    'location_label': locationLabel,
    'location_precision': locationPrecision,
    'source_kind': sourceKind,
  };

  factory EnvironmentReading.fromJson(Map raw) => EnvironmentReading(
    metric: raw['metric'] as String? ?? '',
    value: (raw['value'] as num?)?.toDouble(),
    unit: raw['unit'] as String?,
    provider: raw['provider'] as String?,
    observedAt: raw['observed_at'] is String
        ? DateTime.tryParse(raw['observed_at'] as String)
        : null,
    fetchedAt: raw['fetched_at'] is String
        ? DateTime.tryParse(raw['fetched_at'] as String)
        : null,
    detail: raw['detail'] as String?,
    status: raw['status'] as String? ?? 'ready',
    locationLabel: raw['location_label'] as String?,
    locationPrecision: raw['location_precision'] as String?,
    sourceKind: raw['source_kind'] as String?,
  );
}

DeliveryRecipient parseRecipient(String? s) => switch (s) {
  'clinic' => DeliveryRecipient.clinic,
  'insurer' => DeliveryRecipient.insurer,
  'self' => DeliveryRecipient.self,
  _ => DeliveryRecipient.other,
};

String recipientSql(DeliveryRecipient r) => switch (r) {
  DeliveryRecipient.clinic => 'clinic',
  DeliveryRecipient.insurer => 'insurer',
  DeliveryRecipient.self => 'self',
  DeliveryRecipient.other => 'other',
};

DeliveryMethod parseMethod(String? s) => switch (s) {
  'email' => DeliveryMethod.email,
  'message' => DeliveryMethod.message,
  'portal' => DeliveryMethod.portal,
  'fax' => DeliveryMethod.fax,
  'mail' => DeliveryMethod.mail,
  'in_person' => DeliveryMethod.inPerson,
  'unknown' => DeliveryMethod.unknown,
  _ => DeliveryMethod.other,
};

String methodSql(DeliveryMethod m) => switch (m) {
  DeliveryMethod.email => 'email',
  DeliveryMethod.message => 'message',
  DeliveryMethod.portal => 'portal',
  DeliveryMethod.fax => 'fax',
  DeliveryMethod.mail => 'mail',
  DeliveryMethod.inPerson => 'in_person',
  DeliveryMethod.other => 'other',
  DeliveryMethod.unknown => 'unknown',
};

UseKind parseUseKind(String? s) => switch (s) {
  'scheduled' => UseKind.scheduled,
  'as_needed' => UseKind.asNeeded,
  _ => UseKind.unspecified,
};

String useKindSql(UseKind k) => switch (k) {
  UseKind.scheduled => 'scheduled',
  UseKind.asNeeded => 'as_needed',
  UseKind.unspecified => 'unspecified',
};

CaseLifecycle parseLifecycle(String? s) => switch (s) {
  'completed' => CaseLifecycle.completed,
  'archived' => CaseLifecycle.archived,
  _ => CaseLifecycle.active,
};

String lifecycleSql(CaseLifecycle l) => switch (l) {
  CaseLifecycle.active => 'active',
  CaseLifecycle.completed => 'completed',
  CaseLifecycle.archived => 'archived',
};

TreatmentContext? parseTreatment(String? s) => switch (s) {
  'asthma' => TreatmentContext.asthma,
  'other' => TreatmentContext.other,
  'unknown' => TreatmentContext.unknown,
  _ => null,
};

String? treatmentSql(TreatmentContext? t) => switch (t) {
  TreatmentContext.asthma => 'asthma',
  TreatmentContext.other => 'other',
  TreatmentContext.unknown => 'unknown',
  null => null,
};

String consentPurposeSql(ConsentPurpose p) => switch (p) {
  ConsentPurpose.letter => 'letter_processing',
  ConsentPurpose.label => 'medication_label',
  ConsentPurpose.translate => 'document_translation',
  ConsentPurpose.treatment => 'treatment_processing',
};

/// Letter consent written by Sprint 8 still counts.
const letterConsentVersions = {
  'covernote-letter-2026-10',
  'covernote-letter-2026-10-s9',
};

const labelConsentVersion = 'covernote-label-2026-10';
const translateConsentVersion = 'covernote-translate-2026-10';
