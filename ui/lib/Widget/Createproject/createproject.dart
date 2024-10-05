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

  String _selectedPreset = 'Preset 1'; // Default value
  final List<String> _presets = ['Preset 1', 'Preset 2', 'Preset 3', 'Preset 4']; // List of preset options

  String _selectedConfig = 'Config 1'; // Default value
  final List<String> _config = ['Config 1', 'Config 2', 'Config 3'];

  String _selectedTeam = 'Team 1';
  final List<String> _teams = ['Team 1', 'Team 2', 'Team 3'];

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

  Widget _buildGeneralPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'General Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Project Name',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Preset',
            border: OutlineInputBorder(),
          ),
          value: _selectedPreset, // Currently selected value
          items: _presets.map((String preset) {
            return DropdownMenuItem<String>(
              value: preset,
              child: Text(preset),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedPreset = newValue!;
            });
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Config',
            border: OutlineInputBorder(),
          ),
          value: _selectedConfig, // Currently selected value
          items: _config.map((String config) {
            return DropdownMenuItem<String>(
              value: config,
              child: Text(config),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedConfig = newValue!;
            });
          },
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Team',
            border: OutlineInputBorder(),
          ),
          value: _selectedTeam, // Currently selected value
          items: _teams.map((String team) {
            return DropdownMenuItem<String>(
              value: team,
              child: Text(team),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedTeam = newValue!;
            });
          },
        ),
      ],
    );
  }

  // Method to build the Source page
  Widget _buildSourcePage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Source Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Local Path',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Source Path',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Excluded Folders',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Excluded Files',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // Method to build the Scheduling page
  Widget _buildSchedulingPage() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Scheduling Options',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Schedule Now',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Schedule Date',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Schedule Time',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Schedule Run on',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // Method to build the Pre/Post Scan Actions page
  Widget _buildPrePostScanPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Text(
          'Pre/Post Scan Actions',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Pre Scan Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Post Scan Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            labelText: 'Failed Scan Email',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
