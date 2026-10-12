/// General visit/insurance packet checklist. Not an insurer requirement list.
enum PrepStatus { recorded, needInfo, clinicianNeeded }

class PrepItem {
  const PrepItem(this.id, this.status);
  final String id;
  final PrepStatus status;
}

class EvidencePrep {
  const EvidencePrep._();

  static const ids = [
    'medication',
    'use',
    'symptoms',
    'visits',
    'environment',
    'clinician',
  ];

  static List<PrepItem> assess({
    required bool hasPrescription,
    required int confirmedUseResponses,
    required bool hasSymptoms,
    required int careReports,
    required int clinicianConfirmedVisits,
    required int attachments,
    required int linkedEnvironment,
  }) {
    PrepStatus visits;
    if (careReports == 0) {
      visits = PrepStatus.needInfo;
    } else if (clinicianConfirmedVisits < careReports) {
      visits = PrepStatus.clinicianNeeded;
    } else {
      visits = PrepStatus.recorded;
    }

    // A file is not clinician confirmation.
    PrepStatus clinician;
    if (clinicianConfirmedVisits > 0) {
      clinician = PrepStatus.recorded;
    } else if (careReports > 0 || attachments > 0) {
      clinician = PrepStatus.clinicianNeeded;
    } else {
      clinician = PrepStatus.needInfo;
    }

    return [
      PrepItem(
        'medication',
        hasPrescription ? PrepStatus.recorded : PrepStatus.needInfo,
      ),
      PrepItem(
        'use',
        confirmedUseResponses > 0 ? PrepStatus.recorded : PrepStatus.needInfo,
      ),
      PrepItem(
        'symptoms',
        hasSymptoms ? PrepStatus.recorded : PrepStatus.needInfo,
      ),
      PrepItem('visits', visits),
      PrepItem(
        'environment',
        linkedEnvironment > 0 ? PrepStatus.recorded : PrepStatus.needInfo,
      ),
      PrepItem('clinician', clinician),
    ];
  }
}
