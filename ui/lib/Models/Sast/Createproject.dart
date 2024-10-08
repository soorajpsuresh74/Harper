class CreateProjectModel {
  final String projectName;
  final String preset;
  final String config;
  final String team;
  final String localPath;
  final String sourcePath;
  final String excludedFolder;
  final String excludedFile;
  final String schedule;
  final String scheduleDate;
  final String scheduleTime;
  final List<String> scheduleDays;
  final String preScanMail;
  final String postScanMail;
  final String failureScanMail;
  final bool status;

  CreateProjectModel({
    required this.projectName,
    required this.preset,
    required this.config,
    required this.team,
    required this.localPath,
    required this.sourcePath,
    required this.excludedFolder,
    required this.excludedFile,
    required this.schedule,
    required this.scheduleDate,
    required this.scheduleTime,
    required this.scheduleDays,
    required this.preScanMail,
    required this.postScanMail,
    required this.failureScanMail,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'projectName': projectName,
      'preset': preset,
      'config': config,
      'team': team,
      'localPath': localPath,
      'sourcePath': sourcePath,
      'excludedFolder': excludedFolder,
      'excludedFile': excludedFile,
      'schedule': schedule,
      'scheduleDate': scheduleDate,
      'scheduleTime': scheduleTime,
      'scheduleDays': scheduleDays,
      'preScanMail': preScanMail,
      'postScanMail': postScanMail,
      'failureScanMail': failureScanMail,
      'status': status
    };
  }
}
