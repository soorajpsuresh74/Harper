// import 'package:flutter/material.dart';
// import 'package:harper/Widget/Dashboard/project.dart';
//
// class ProjectListScreen extends StatelessWidget {
//
//
//   // here deploy a api to get the projects
//
//
//   final List<Project> projects = [
//     Project(
//         'Project A', 'GitHub', '2 hours ago', 'web, flutter', 'High', 12, 5, 3),
//     Project('Project B', 'Bitbucket', '1 day ago', 'mobile, dart', 'Medium', 8,
//         2, 6),
//     Project(
//         'Project C', 'GitLab', '3 days ago', 'python, flask', 'Low', 1, 3, 4),
//   ];
//
//   ProjectListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//         itemCount: projects.length,
//         itemBuilder: (context, index) {
//           return ProjectCard(project: projects[index]);
//         },
//       ),
//     );
//   }
// }

// here deploy a api to get the projects

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
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : _projects.isEmpty
          ? const Center(child: Text('No projects found')) // Show message if no projects
          : ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return ProjectCard(project: _convertToProject(_projects[index]));
        },
      ),
    );
  }

  // Helper function to convert ProjectManagerMain to Project
  Project _convertToProject(ProjectManagerMain projectMain) {
    return Project(
      projectMain.id,
      projectMain.projectName,
      projectMain.projectSource,
      projectMain.lastScan as String,
      projectMain.tags as String,
      projectMain.high as int,
      projectMain.medium as int,
      projectMain.low as int,
    );
  }
}


