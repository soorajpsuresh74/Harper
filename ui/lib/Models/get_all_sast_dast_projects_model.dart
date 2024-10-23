class GetAllSastDastProjectsModel {
  final String id;
  final String projectName;
  final String config;
  final String team;
  final String preset;
  final String status;

  GetAllSastDastProjectsModel({
    required this.id,
    required this.projectName,
    required this.config,
    required this.team,
    required this.preset,
    required this.status,
  });

  factory GetAllSastDastProjectsModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception('ID cannot be null');
    }
    return GetAllSastDastProjectsModel(
        id: json['id'],
        projectName: json['projectName'],
        config: json['config'],
        team: json['team'],
        preset: json['preset'],
        status: json['status']);
  }

  String? get random => null;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectName': projectName,
      'config': config,
      'team': team,
      'preset': preset,
      'status': status,
    };
  }
}
