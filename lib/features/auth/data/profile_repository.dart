import '../../../core/locale/app_languages.dart';
import '../../../core/supabase/supabase_service.dart';
import '../domain/npi_validator.dart';
import '../domain/user_profile.dart';

/// Reads and writes `profiles` (+ role-specific detail tables).
class ProfileRepository {
  ProfileRepository();

  Future<UserProfile?> fetchCurrent() async {
    final user = SupabaseService.currentUser;
    if (user == null) return null;

    final row = await SupabaseService.client
        .from('profiles')
        .select('id, role, full_name, language_code')
        .eq('id', user.id)
        .maybeSingle();

    if (row == null) return null;
    return UserProfile.fromMap(row);
  }

  /// Creates profile and role-specific rows for the signed-in user.
  /// Rolls back the profile row if the detail insert fails.
  Future<UserProfile> createProfile({
    required UserRole role,
    required String fullName,
    required String languageCode,
    String? npi,
  }) async {
    final user = SupabaseService.currentUser;
    if (user == null) {
      throw StateError('Not signed in');
    }

    final name = fullName.trim();
    if (name.isEmpty) {
      throw ArgumentError('fullName is required');
    }

    if (role == UserRole.provider) {
      final value = (npi ?? '').trim();
      if (!NpiValidator.isValid(value)) {
        throw ArgumentError('Invalid NPI');
      }
    }

    // Stored as the BCP-47 tag of an offered language (`ko`, `zh-Hans`, ...).
    // The set of allowed values is mirrored by a CHECK on profiles.language_code.
    final lang = appLanguageForTag(languageCode)?.tag ?? defaultAppLanguage.tag;

    await SupabaseService.client.from('profiles').insert({
      'id': user.id,
      'role': role.dbValue,
      'full_name': name,
      'language_code': lang,
    });

    try {
      if (role == UserRole.patient) {
        await SupabaseService.client.from('patient_details').insert({
          'patient_id': user.id,
        });
      } else {
        await SupabaseService.client.from('provider_credentials').insert({
          'provider_id': user.id,
          'npi': npi!.trim(),
        });
      }
    } catch (e) {
      try {
        await SupabaseService.client
            .from('profiles')
            .delete()
            .eq('id', user.id);
      } catch (_) {
        // Best-effort compensation; surface the original failure.
      }
      rethrow;
    }

    return UserProfile(
      id: user.id,
      role: role,
      fullName: name,
      languageCode: lang,
    );
  }
}
