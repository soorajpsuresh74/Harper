import 'package:flutter/material.dart';
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';
import 'package:harper/Services/get_all_sast_dast_projects_service.dart';
import 'all_project.dart'; // Use this model instead

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
      print('Error fetching projects for get all_projects in Application and Project Screen: $e'); // Debugging info for errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAST & DAST Projects'),
      ),
      body: _isLoading
          ? const Center(
          child: CircularProgressIndicator()) // Show loading spinner
          : _projects.isEmpty
          ? const Center(
          child: Text('No projects found')) // Show message if no projects
          : ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return AllProjectCard(
            project: _convertToAllProject(_projects[index]),
          );
        },
      ),
    );
  }

  // Helper method to convert GetAllSastDastProjectsModel to AllProject
  AllProject _convertToAllProject(GetAllSastDastProjectsModel projectMain) {
    return AllProject(
      projectMain.projectName ?? 'Unnamed Project', // Default to 'Unnamed Project' if null
      projectMain.config ?? 'Unknown Source', // Default to 'Unknown Source' if null
      projectMain.team ?? 'Unknown Time', // Default to 'Unknown Time' if null
      projectMain.preset.isNotEmpty ? 'Has Preset' : 'No Preset', // Adjusting preset field
      projectMain.status as String // Handle status safely as String
    );
  }
}
