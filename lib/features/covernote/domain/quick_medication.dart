class QuickMedication {
  const QuickMedication({
    required this.id,
    required this.name,
    this.role,
    this.puffs,
    this.regimenId,
  });
  final String id, name;
  final String? role, regimenId;
  final int? puffs;

  bool supports(String kind) =>
      role == 'both' || role == (kind == 'scheduled' ? 'controller' : 'rescue');
}
