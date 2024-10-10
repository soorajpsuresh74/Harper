class ProjectManagerMain {
  final String id;
  final String projectName;
  final String projectSource;
  final DateTime lastScan;
  final List tags;
  final String high;
  final String medium;
  final String low;

  ProjectManagerMain({
    required this.id,
    required this.projectName,
    required this.projectSource,
    required this.lastScan,
    required this.tags,
    required this.high,
    required this.medium,
    required this.low,
  });

  factory ProjectManagerMain.fromJson(Map<String, dynamic> json) {
    if (json['id'] == null) {
      throw Exception('ID cannot be null');
    }
    return ProjectManagerMain(
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
