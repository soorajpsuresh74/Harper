import 'package:flutter/material.dart';

// The new widget to be displayed after creating a project
class ProjectDetailsPage extends StatelessWidget {
  const ProjectDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
      ),
      body: const Center(
        child: Text(
          'This is the Project Details page!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

// The CreateProjectWidget widget
class CreateProjectWidget extends StatefulWidget {
  const CreateProjectWidget({super.key});

  @override
  _CreateProjectWidgetState createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends State<CreateProjectWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Project'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'General'),
            Tab(text: 'Source'),
            Tab(text: 'Scheduling'),
            Tab(text: 'Pre/Post Scan'),
          ],
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildGeneralPage(),
              _buildSourcePage(),
              _buildSchedulingPage(),
              _buildPrePostScanPage(),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the General page
  Widget _buildGeneralPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'General Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Project Name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  // Method to build the Source page
  Widget _buildSourcePage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Source Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Source Path',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  // Method to build the Scheduling page
  Widget _buildSchedulingPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Scheduling Options',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Schedule Date',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  // Method to build the Pre/Post Scan Actions page
  Widget _buildPrePostScanPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Pre/Post Scan Actions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Post Scan Action',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
