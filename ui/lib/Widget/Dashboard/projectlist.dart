import 'package:flutter/material.dart';
import 'package:harper/Models/Sast/projectsmain.dart';
import 'package:harper/Services/Sast/projectmanagermain.dart';
import 'package:harper/Widget/Dashboard/project.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  _ProjectListScreenState createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  List<ProjectManagerMain> _projects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      final projects = await ProjectManagerMainService().fetchSavedProjects();
      setState(() {
        _projects = projects;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error here if necessary
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading spinner
          : _projects.isEmpty
              ? const Center(
                  child:
                      Text('No projects found')) // Show message if no projects
              : ListView.builder(
                  itemCount: _projects.length,
                  itemBuilder: (context, index) {
                    return ProjectCard(
                        project: _convertToProject(_projects[index]));
                  },
                ),
    );
  }

  // Helper function to convert ProjectManagerMain to Project
  Project _convertToProject(ProjectManagerMain projectMain) {
    return Project(
      projectMain.id.toString() ?? 'Unknown ID',
      projectMain.projectName ?? 'Unnamed Project',
      projectMain.projectSource ?? 'Unknown Source',
      projectMain.lastScan ?? 'Unknown Time',
      projectMain.tags.join(', ') ?? 'No Tags',
      projectMain.high ?? 0,
      projectMain.medium ?? 0,
      projectMain.low ?? 0,
    );
  }
}
