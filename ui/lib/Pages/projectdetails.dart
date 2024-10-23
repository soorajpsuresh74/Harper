import 'package:flutter/material.dart';
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';
import 'package:harper/Widget/Dashboard/sidebar.dart';
import 'package:harper/Widget/Dashboard/userwidgets.dart';
import 'package:sidebarx/sidebarx.dart';

class ProjectDetailScreen extends StatefulWidget {
  final GetAllSastDastProjectsModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  _ProjectDetailScreenState createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late final SidebarXController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        SidebarXController(selectedIndex: 0); // Initialize the controller here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(controller: _controller),
          Expanded(
            // Removed the const keyword because widget.project is dynamic
            child: Padding(
              padding: const EdgeInsets.all(16.0), // This can stay const
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserWidgets(), // UserWidgets can stay const if it doesn't depend on dynamic data
                  const SizedBox(height: 25), // This can remain const
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Name: ${widget.project.projectName ?? 'Unnamed Project'}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Source: ${widget.project.config ?? 'Unknown Source'}'),
                      const SizedBox(height: 10),
                      Text(
                          'Last Scan: ${widget.project.team ?? 'Unknown Time'}'),
                      const SizedBox(height: 10),
                      Text(
                          'Tags: ${widget.project.preset.isNotEmpty ? 'Has Preset' : 'No Preset'}'),
                      const SizedBox(height: 10),
                      Text('Status: ${widget.project.status}'),
                      const SizedBox(height: 10),
                      Text(
                          'Random Value: ${widget.project.random ?? 'No Random Value'}'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
