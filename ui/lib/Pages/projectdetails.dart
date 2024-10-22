import 'package:flutter/material.dart';
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';

class ProjectDetailScreen extends StatelessWidget {
  final GetAllSastDastProjectsModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.projectName ?? 'Unnamed Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Name: ${project.projectName ?? 'Unnamed Project'}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Source: ${project.config ?? 'Unknown Source'}'),
            const SizedBox(height: 10),
            Text('Last Scan: ${project.team ?? 'Unknown Time'}'),
            const SizedBox(height: 10),
            Text('Tags: ${project.preset.isNotEmpty ? 'Has Preset' : 'No Preset'}'),
            const SizedBox(height: 10),
            Text('Status: ${project.status}'),
            const SizedBox(height: 10),
            Text('Random Value: ${project.random ?? 'No Random Value'}'),
          ],
        ),
      ),
    );
  }
}
