import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:harper/Models/Dast/projectsmain.dart';
import 'package:harper/Services/get_all_sast_dast_projects_service.dart';
import 'package:harper/Widget/Dashboard/project.dart';
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';

class GetAllSastDastProjects extends StatefulWidget {
  const GetAllSastDastProjects({super.key});

  @override
  _GetAllSastDastProjectsState createState() => _GetAllSastDastProjectsState();
}

class _GetAllSastDastProjectsState extends State<GetAllSastDastProjects> {
  List<GetAllSastDastProjectsModel> _projects = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      final projects = await GetAllSastDastProjectsServive().fetchSavedProjects();
      setState(() {
        _projects = projects;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Optionally handle the error, maybe show a message or retry
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator()) // Show loading spinner
        : _projects.isEmpty
        ? const Center(child: Text('No projects found')) // Show message if no projects
        : ListView.builder(
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return ProjectCard(
          project: _convertToProject(_projects[index]),
        );
      },
    );
  }

  // Helper method to convert ProjectManagerMain to Project
  Project _convertToProject(GetAllSastDastProjectsModel projectMain) {
    return Project(
      projectMain.id.toString(), // Convert to string safely
      projectMain.projectName ?? 'Unnamed Project', // Default to 'Unnamed Project' if null
      projectMain.projectSource ?? 'Unknown Source', // Default to 'Unknown Source' if null
      projectMain.lastScan ?? 'Unknown Time', // Default to 'Unknown Time' if null
      projectMain.tags.isNotEmpty ? projectMain.tags.join(', ') : 'No Tags', // Join tags or default
      projectMain.high ?? 0, // Default to 0 if null
      projectMain.medium ?? 0, // Default to 0 if null
      projectMain.low ?? 0, // Default to 0 if null
    );
  }
}
