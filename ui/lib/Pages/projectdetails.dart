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

class _ProjectDetailScreenState extends State<ProjectDetailScreen>
    with SingleTickerProviderStateMixin {
  late final SidebarXController _controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(selectedIndex: 0);
    _tabController = TabController(length: 4, vsync: this); // 4 tabs
  }

  void _onScanButtonPressed() {
    // Implement your scan logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Scan button pressed!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        Sidebar(controller: _controller),
        Expanded(
          child: Column(
            children: [
              // User Widget at the top
              const UserWidgets(),
              const SizedBox(height: 10),

              // Tabs for different sections with 20 padding
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black,
                      indicatorColor: Colors.blue,
                      indicator: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(color: Colors.blue, width: 0),
                        ),
                      ),
                      isScrollable: false, // Set to false for equal-sized tabs
                      tabs: const [
                        Tab(text: 'Overview'),
                        Tab(text: 'Scan History'),
                        Tab(text: 'Compliance'),
                        Tab(text: 'Settings'),
                      ],
                    ),
                    const SizedBox(height: 10), // Spacing below the button
                  ],
                ),
              ),

              // Tab views for each section
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Overview Tab
                    _buildOverviewTab(),

                    // Scan History Tab
                    _buildScanHistoryTab(),

                    // Compliance Tab
                    _buildComplianceTab(),

                    // Settings Tab
                    _buildSettingsTab(),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }

  // Overview Tab content
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProjectDetailsSection(),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: _buildVulnerabilityCard('Total Vulnerabilities', '133',
                      {'High': 48, 'Medium': 20, 'Low': 65})),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildVulnerabilityCard('Vulnerabilities by Scan Type',
                      'SAST', {'SAST': 133, 'KICS': 0, 'SCA': 0})),
            ],
          ),
          const SizedBox(height: 20),
          _buildChartPlaceholder('Severity Over Time'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildChartPlaceholder('Aging Summary')),
              const SizedBox(width: 16),
              Expanded(
                  child: _buildChartPlaceholder('Results by Technologies')),
            ],
          ),
        ],
      ),
    );
  }

  // Scan History Tab content
  Widget _buildScanHistoryTab() {
    return const Center(child: Text("Scan History details will go here."));
  }

  // Compliance Tab content
  Widget _buildComplianceTab() {
    return const Center(child: Text("Compliance information will go here."));
  }

  // Settings Tab content
  Widget _buildSettingsTab() {
    return const Center(child: Text("Project settings and configurations go here."));
  }

  // Reusable Project Details section
  Widget _buildProjectDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                Text(
                    'Tags: ${widget.project.preset.isNotEmpty ? 'Has Preset' : 'No Preset'}'),
                const SizedBox(height: 10),
                Text('Status: ${widget.project.status}'),
                const SizedBox(height: 10),
                Text(
                    'Random Value: ${widget.project.random ?? 'No Random Value'}'),
              ],
            ),
            // High Risk Label
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Scan Button positioned above the High Risk label
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _onScanButtonPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Match High Risk color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0), // Match shape
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 24.0), // Adjust padding
                      elevation: 0, // Remove shadow
                      textStyle: const TextStyle(color: Colors.white), // White text color
                    ),
                    child: const Text('Scan', style:  TextStyle(fontSize: 18, color: Colors.white,)),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    'High Risk',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10), // Spacing below the High Risk label
        const SizedBox(height: 20),
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
    );
  }

  // A reusable card widget for vulnerability details
  Widget _buildVulnerabilityCard(
      String title, String mainValue, Map<String, int> breakdown) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              mainValue,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
