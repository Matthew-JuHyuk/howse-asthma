/// One account is one patient. The demo caregiver name is shown as the patient.
String patientLabel(String? raw, {String fallback = 'Diego'}) {
  final name = (raw ?? '').replaceAll(RegExp(r'\s+'), ' ').trim();
  if (name.isEmpty) return fallback;
  if (RegExp(r'rosa', caseSensitive: false).hasMatch(name)) return 'Diego';
  return name;
}

/// Removes the demo caregiver name from text the patient sees.
String patientText(String raw) => raw.replaceAll(
  RegExp(r'Rosa(?:\s+Martinez)?(?:\s*\(DEMO\))?', caseSensitive: false),
  'Diego',
);

bool sameAccount(String patientKey, String accountId) =>
    patientKey == accountId || patientKey.startsWith('$accountId/');
