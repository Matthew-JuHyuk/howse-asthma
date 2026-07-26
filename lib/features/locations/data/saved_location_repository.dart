import '../../../core/supabase/supabase_service.dart';

class SavedLocation {
  const SavedLocation({
    required this.id,
    required this.label,
    required this.latitude,
    required this.longitude,
    required this.monitoringEnabled,
    required this.isPrimary,
  });

  final String id;
  final String label;
  final double latitude;
  final double longitude;
  final bool monitoringEnabled;
  final bool isPrimary;

  factory SavedLocation.fromJson(Map<String, dynamic> json) {
    return SavedLocation(
      id: json['id'] as String,
      label: json['label'] as String? ?? 'OTHER',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      monitoringEnabled: json['monitoring_enabled'] != false,
      isPrimary: json['is_primary'] == true,
    );
  }
}

class SavedLocationRepository {
  SavedLocationRepository();

  Future<List<SavedLocation>> list() async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) return const [];

    final rows = await SupabaseService.client
        .from('saved_locations')
        .select(
          'id, label, latitude, longitude, monitoring_enabled, is_primary, created_at',
        )
        .eq('patient_id', userId)
        .order('is_primary', ascending: false)
        .order('created_at', ascending: true);

    return (rows as List)
        .map((r) => SavedLocation.fromJson(Map<String, dynamic>.from(r as Map)))
        .toList();
  }

  static const maxSavedLocations = 10;

  Future<SavedLocation> upsert({
    String? id,
    required String label,
    required double latitude,
    required double longitude,
    bool monitoringEnabled = true,
    bool isPrimary = false,
  }) async {
    final userId = SupabaseService.currentUser?.id;
    if (userId == null) throw StateError('not_authenticated');

    if (id == null) {
      final existing = await list();
      if (existing.length >= maxSavedLocations) {
        throw StateError('saved_locations_cap');
      }
    }

    if (isPrimary) {
      await SupabaseService.client
          .from('saved_locations')
          .update({'is_primary': false})
          .eq('patient_id', userId);
    }

    final row = <String, dynamic>{
      'id': ?id,
      'patient_id': userId,
      'label': label,
      'latitude': latitude,
      'longitude': longitude,
      'monitoring_enabled': monitoringEnabled,
      'is_primary': isPrimary,
    };

    final inserted = await SupabaseService.client
        .from('saved_locations')
        .upsert(row)
        .select()
        .single();
    return SavedLocation.fromJson(Map<String, dynamic>.from(inserted as Map));
  }

  Future<void> delete(String id) async {
    await SupabaseService.client.from('saved_locations').delete().eq('id', id);
  }

  Future<void> setMonitoring(String id, bool enabled) async {
    await SupabaseService.client
        .from('saved_locations')
        .update({'monitoring_enabled': enabled})
        .eq('id', id);
  }
}
