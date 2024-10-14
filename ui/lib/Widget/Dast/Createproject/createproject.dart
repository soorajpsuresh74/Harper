import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:harper/Services/Dast/createproject.dart';
import 'package:harper/Models/Dast/createprojectdast.dart';

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

class MultiSelectChip extends StatefulWidget {
  final List<String> options;
  final ValueChanged<List<String>> onSelectionChanged;

  const MultiSelectChip(
      {super.key, required this.options, required this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.options.map((item) {
        return ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selected
                  ? selectedChoices.add(item)
                  : selectedChoices.remove(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        );
      }).toList(),
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
  String? _sourcePath;
  String? _excludedFolders;
  String? _excludedFiles;

  String _selectedSchedule = 'now'; // Default value for scheduling
  String? _scheduleDate;
  String? _scheduleTime;
  List<String> _selectedDays = [];

  String? _preScanMail;
  String? _postScanMail;
  String? _failureScanMail;

  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController sourcePathController = TextEditingController();
  final TextEditingController excludedFoldersController =
      TextEditingController();
  final TextEditingController excludedFilesController = TextEditingController();
  final TextEditingController preScanMailController = TextEditingController();
  final TextEditingController postScanMailController = TextEditingController();
  final TextEditingController failureScanMailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    projectNameController.dispose();
    sourcePathController.dispose();
    excludedFoldersController.dispose();
    excludedFilesController.dispose();
    preScanMailController.dispose();
    postScanMailController.dispose();
    failureScanMailController.dispose();
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
        TextField(
          controller: projectNameController,
          decoration: const InputDecoration(
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
          controller: sourcePathController,
          decoration: const InputDecoration(
            labelText: 'Source Path (VCS Link)',
            hintText: 'Enter Git/SVN repository URL',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.url,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: excludedFoldersController,
          decoration: const InputDecoration(
            labelText: 'Excluded Folders',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: excludedFilesController,
          decoration: const InputDecoration(
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
          'Scheduling Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ListTile(
          title: const Text('Schedule Scan'),
          trailing: DropdownButton<String>(
            value: _selectedSchedule,
            items: <String>['now', 'later'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSchedule = newValue!;
                if (_selectedSchedule == 'later') {
                  _scheduleDate = null; // Reset date if now is selected
                  _scheduleTime = null; // Reset time if now is selected
                }
              });
            },
          ),
        ),
        if (_selectedSchedule == 'later') ...[
          const SizedBox(height: 20),
          TextField(
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              setState(() {
                _scheduleDate = date?.toIso8601String();
              });
            },
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Schedule Date',
              hintText: _scheduleDate ?? 'Select a date',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: TextEditingController(text: _scheduleTime),
            decoration: const InputDecoration(
              labelText: 'Schedule Time',
              hintText: 'HH:MM',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.datetime,
            onChanged: (value) {
              setState(() {
                _scheduleTime = value;
              });
            },
          ),
          const SizedBox(height: 20),
          MultiSelectChip(
            options: [
              'Sunday',
              'Monday',
              'Tuesday',
              'Wednesday',
              'Thursday',
              'Friday',
              'Saturday'
            ],
            onSelectionChanged: (selectedDays) {
              setState(() {
                _selectedDays = selectedDays; // Save selected days
              });
            },
          ),
        ],
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
          'Pre/Post Scan Information',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: preScanMailController,
          decoration: const InputDecoration(
            labelText: 'Pre Scan Email',
            hintText: 'Enter email to notify before scan',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: postScanMailController,
          decoration: const InputDecoration(
            labelText: 'Post Scan Email',
            hintText: 'Enter email to notify after scan',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: failureScanMailController,
          decoration: const InputDecoration(
            labelText: 'Failure Scan Email',
            hintText: 'Enter email to notify on failure',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _submitProject, // Submit project on press
          child: const Text('Submit Project'),
        ),
      ],
    );
  }

  Future<void> _submitProject() async {
    final project = CreateProjectModelDAST(
        projectName: projectNameController.text,
        localPath: _localPath ?? '',
        sourcePath: sourcePathController.text,
        excludedFolder: excludedFoldersController.text,
        excludedFile: excludedFilesController.text,
        schedule: _selectedSchedule,
        scheduleDate: _scheduleDate ?? '',
        scheduleTime: _scheduleTime ?? '',
        scheduleDays: _selectedDays,
        preScanMail: preScanMailController.text,
        postScanMail: postScanMailController.text,
        failureScanMail: failureScanMailController.text,
        preset: _selectedPreset,
        config: _selectedConfig,
        team: _selectedTeam,
        status: false);

    CreateProjectAPI api = CreateProjectAPI();
    await api.sendProjectData(project);
    print('Project Submitted: ${project.toJson()}');

    // Optionally, navigate to a different screen or show a success message
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Project added')));
  }
}
