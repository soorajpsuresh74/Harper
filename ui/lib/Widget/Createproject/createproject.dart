import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CreateProjectWidget(),
    );
  }
}

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
  final List<String> _presets = [
    'Preset 1',
    'Preset 2',
    'Preset 3',
    'Preset 4'
  ];

  String _selectedConfig = 'Config 1'; // Default value
  final List<String> _config = ['Config 1', 'Config 2', 'Config 3'];

  String _selectedTeam = 'Team 1';
  final List<String> _teams = ['Team 1', 'Team 2', 'Team 3'];

  String? _localPath;

  String _selectedSchedule = 'now'; // Default value for scheduling
  String? _scheduleDate;
  String? _scheduleTime;
  List<String> _selectedDays = []; // Changed to List to allow multiple selections

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

  Future<void> _pickLocalPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['*'], // Allow all file types
      dialogTitle: 'Select Local Path',
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _localPath = result.files.first.path; // Use safe access
      });
    }
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
          value: _selectedPreset,
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
          value: _selectedConfig,
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
          value: _selectedTeam,
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
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _tabController.animateTo(1); // Move to the next tab (index 1)
          },
          child: const Text('Next'),
        ),
      ],
    );
  }

  Widget _buildSourcePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Source Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: _localPath),
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Local Path',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.folder_open),
              onPressed: _pickLocalPath,
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Source Path (VCS Link)',
            hintText: 'Enter Git/SVN repository URL',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.url,
          onChanged: (String value) {},
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Excluded Folders',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Excluded Files',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _tabController.animateTo(2); // Move to the next tab (index 2)
          },
          child: const Text('Next'),
        ),
      ],
    );
  }

  Widget _buildSchedulingPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Scheduling Options',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Column(
            children: [
              ListTile(
                title: const Text('Run Now'),
                leading: Radio<String>(
                  value: 'now',
                  groupValue: _selectedSchedule,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSchedule = value!;
                      _selectedDays.clear();
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Schedule Later'),
                leading: Radio<String>(
                  value: 'later',
                  groupValue: _selectedSchedule,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedSchedule = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (_selectedSchedule == 'later') ...[
          const TextField(
            decoration: InputDecoration(
              labelText: 'Schedule Date',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Schedule Time',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
        ],
        const Text('Schedule Run On'),
        const SizedBox(height: 10),
        MultiSelectChip(
          options: const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
          onSelectionChanged: (selectedList) {
            setState(() {
              _selectedDays = selectedList;
            });
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            _tabController.animateTo(3); // Move to the next tab (index 3)
          },
          child: const Text('Next'),
        ),
      ],
    );
  }

  Widget _buildPrePostScanPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Pre/Post Scan Options',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Pre Scan Mail',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Post Scan Mail',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Failure Scan Mail',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle the final submit action
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectDetailsPage()),
            );
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

// MultiSelectChip widget for selecting multiple days
class MultiSelectChip extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;

  const MultiSelectChip({
    super.key,
    required this.options,
    required this.onSelectionChanged,
  });

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.options.map((option) {
        return ChoiceChip(
          label: Text(option),
          selected: _selectedOptions.contains(option),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedOptions.add(option);
              } else {
                _selectedOptions.remove(option);
              }
              widget.onSelectionChanged(_selectedOptions);
            });
          },
        );
      }).toList(),
    );
  }
}
