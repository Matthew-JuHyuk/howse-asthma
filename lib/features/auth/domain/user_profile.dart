/// App role stored on `profiles.role`.
enum UserRole {
  patient,
  provider;

  String get dbValue => switch (this) {
        UserRole.patient => 'PATIENT',
        UserRole.provider => 'PROVIDER',
      };

  static UserRole? fromDb(String? value) {
    switch (value) {
      case 'PATIENT':
        return UserRole.patient;
      case 'PROVIDER':
        return UserRole.provider;
      default:
        return null;
    }
  }
}

/// Row from `public.profiles`.
class UserProfile {
  const UserProfile({
    required this.id,
    required this.role,
    required this.fullName,
    required this.languageCode,
  });

  final String id;
  final UserRole role;
  final String fullName;
  final String languageCode;

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    final role = UserRole.fromDb(map['role'] as String?);
    if (role == null) {
      throw FormatException('Unknown role: ${map['role']}');
    }
    return UserProfile(
      id: map['id'] as String,
      role: role,
      fullName: map['full_name'] as String,
      languageCode: (map['language_code'] as String?) ?? 'en',
    );
  }
}
