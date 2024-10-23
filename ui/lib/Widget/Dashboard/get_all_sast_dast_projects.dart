import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import this for clipboard functionality
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';
import 'package:harper/Services/get_all_sast_dast_projects_service.dart';
import 'package:harper/Pages/projectdetails.dart';

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
      final projects =
      await GetAllSastDastProjectsServive().fetchSavedProjects(); // Fixed the typo
      setState(() {
        _projects = projects;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(
          'Error fetching projects for get all_projects in Application and Project Screen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _projects.isEmpty
          ? const Center(child: Text('No projects found'))
          : AllProjectTableScreen(projects: _projects),
    );
  }
}

class AllProjectTableScreen extends StatelessWidget {
  final List<GetAllSastDastProjectsModel> projects;

  const AllProjectTableScreen({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  headingTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
                  border: TableBorder.all(
                    color: Colors.grey[300]!,
                    width: 1,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Preset')),
                    DataColumn(label: Text('Config')),
                    DataColumn(label: Text('Source')),
                    DataColumn(label: Text('Actions')),
                    DataColumn(label: Text('Random')),
                  ],
                  rows: projects.map((project) {
                    return _buildDataRow(
                      context,
                      project.id,
                      project.projectName ?? 'Unnamed',
                      project.config ?? 'Unknown',
                      project.team ?? 'Unknown',
                      project.status,
                      project.preset.isNotEmpty ? 'Has Preset' : 'No Preset',
                      project.random, // Assuming this is a string
                      project,
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  DataRow _buildDataRow(
      BuildContext context,
      String id,
      String name,
      String source,
      String lastScan,
      String tags,
      String status,
      String? random,
      GetAllSastDastProjectsModel project,
      ) {
    final randomValue = (random != null && random.isNotEmpty)
        ? random
        : _generateRandomValue();

    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  id.length > 8 ? id.substring(0, 8) : id, // Display first 4 characters
                  style: const TextStyle(
                    fontSize: 12, // Small font size
                    color: Colors.blue,
                    // decoration: TextDecoration.underline, // Underlined
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.copy),
                onPressed: () {
                  _copyToClipboard(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('ID copied to clipboard!')),
                  );
                },
              ),
            ],
          ),
        ),
        DataCell(
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectDetailScreen(project: project),
                ),
              );
            },
            child: Text(
              name, // Remove underline from name
              style: const TextStyle(
                color: Colors.brown,
                // decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        DataCell(Text(source)),
        DataCell(Text(lastScan)),
        DataCell(Text(tags)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _getStatusColor(status),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(Text(randomValue)),
      ],
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  String _generateRandomValue() {
    return 'RandomValue-${DateTime.now().millisecondsSinceEpoch}';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Inactive':
        return Colors.grey;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
}
