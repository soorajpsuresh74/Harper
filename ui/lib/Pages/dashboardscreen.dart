import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:harper/Widget/Dashboard/headerstat.dart';
import 'package:harper/Widget/Dashboard/sidebar.dart';
import 'package:harper/Widget/Dashboard/get_all_sast_dast_projects.dart';
import 'package:harper/Widget/Dashboard/ProjectsAndAppplicationButtons.dart';

class ProjectsAndAppplication extends StatefulWidget {
  const ProjectsAndAppplication({super.key});

  @override
  _ProjectsAndAppplication createState() => _ProjectsAndAppplication();
}

class _ProjectsAndAppplication extends State<ProjectsAndAppplication> {
  late final SidebarXController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(selectedIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(controller: _controller),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 0,
                    child: HeaderStats(),
                  ),
                  Expanded(
                    flex: 0,
                    child: ProjectsAndAppplicationButtons(),
                  ),
                  Expanded(
                    flex: 2,
                    child: GetAllSastDastProjects(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
