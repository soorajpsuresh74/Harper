class GetAllSastDastProjectsModel {
  final int id;
  final String projectName;
  final String projectSource;
  final String lastScan;
  final List tags;
  final int high;
  final int medium;
  final int low;

  GetAllSastDastProjectsModel({
    required this.id,
    required this.projectName,
    required this.projectSource,
    required this.lastScan,
    required this.tags,
    required this.high,
    required this.medium,
    required this.low,
  });

  factory GetAllSastDastProjectsModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception('ID cannot be null');
    }
    return GetAllSastDastProjectsModel(
        id: json['id'],
        projectName: json['projectName'],
        projectSource: json['projectSource'],
        lastScan: json['lastScan'],
        tags: json['tags'],
        high: json['high'],
        medium: json['medium'],
        low: json['low']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projectName': projectName,
      'projectSource': projectSource,
      'lastScan': lastScan,
      'tags': tags,
      'high': high,
      'medium': medium,
      'low': low,
    };
  }
}
