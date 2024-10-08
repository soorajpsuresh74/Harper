class FetchSavedProjectModel {
  final String id;
  final String name;
  final String preset;
  final String config;
  final String team;
  final bool status;

  FetchSavedProjectModel({
    required this.id,
    required this.name,
    required this.preset,
    required this.config,
    required this.team,
    required this.status
  });

  factory FetchSavedProjectModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception('ID cannot be null');
    }
    return FetchSavedProjectModel(
      id: json['id'] as String,
      name: json['project_name'] ?? 'Unnamed Project',
      preset: json['preset'] ?? 'Default Preset',
      config: json['config'] ?? 'Default Config',
      team: json['team'] ?? 'Default Team',
      status: json['status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'preset': preset,
      'config': config,
      'team': team,
      'status': status,
    };
  }
}
