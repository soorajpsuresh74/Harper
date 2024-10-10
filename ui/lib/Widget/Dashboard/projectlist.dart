import 'package:flutter/material.dart';
import 'package:harper/Widget/Dashboard/project.dart';

class ProjectListScreen extends StatelessWidget {
  final List<Project> projects = [
    Project(
        'Project A', 'GitHub', '2 hours ago', 'web, flutter', 'High', 12, 5, 3),
    Project('Project B', 'Bitbucket', '1 day ago', 'mobile, dart', 'Medium', 8,
        2, 6),
    Project(
        'Project C', 'GitLab', '3 days ago', 'python, flask', 'Low', 1, 3, 4),
  ];

  ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: projects[index]);
        },
      ),
    );
  }
}
