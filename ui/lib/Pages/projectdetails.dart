import 'package:flutter/material.dart';
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';
import 'package:harper/Widget/Dashboard/sidebar.dart';
import 'package:harper/Widget/Dashboard/userwidgets.dart';
import 'package:sidebarx/sidebarx.dart';

class ProjectDetailScreen extends StatefulWidget {
  final GetAllSastDastProjectsModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  late final SidebarXController _controller;

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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UserWidgets(),
                  const SizedBox(height: 25),

                  // Split the details into two sections
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Project Name: ${widget.project.projectName ?? 'Unnamed Project'}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Text('Branch: master',
                                style: TextStyle(color: Colors.grey)),
                            const SizedBox(height: 10),
                            Text('Source: ${widget.project.config ?? 'Unknown Source'}'),
                            const SizedBox(height: 10),
                            Text('Last Scan: ${widget.project.team ?? 'Unknown Time'}'),
                            const SizedBox(height: 10),
                            Text('Tags: ${widget.project.preset.isNotEmpty ? 'Has Preset' : 'No Preset'}'),
                            const SizedBox(height: 10),
                            Text('Status: ${widget.project.status}'),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16), // Space between two sections

                      // Right section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: const Text(
                                'High Risk',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text('Random Value: ${widget.project.random ?? 'No Random Value'}'),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Scan: 7c5fd1f1-5466-436e-5bcb-8025f7a13b11',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text('Last Scan: 3 Hours ago',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Vulnerability cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildVulnerabilityCard('Total Vulnerabilities', '133',
                          {'High': 48, 'Medium': 20, 'Low': 65}),
                      _buildVulnerabilityCard('Vulnerabilities by Scan Type',
                          'SAST', {'SAST': 133, 'KICS': 0, 'SCA': 0}),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Severity over time chart
                  _buildChartPlaceholder('Severity Over Time'),

                  const SizedBox(height: 20),

                  // Aging Summary and Technology Results Row
                  Row(
                    children: [
                      Expanded(child: _buildChartPlaceholder('Aging Summary')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildChartPlaceholder('Results by Technologies')),
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

  // A reusable card widget for vulnerability details
  Widget _buildVulnerabilityCard(
      String title, String mainValue, Map<String, int> breakdown) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                mainValue,
                style:
                const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (var entry in breakdown.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text(entry.value.toString()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // A placeholder for charts (Severity Over Time, Aging Summary, Technology Results)
  Widget _buildChartPlaceholder(String title) {
    return Card(
      elevation: 4,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Center(
                child: Text('Chart goes here',
                    style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}
