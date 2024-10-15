import 'package:flutter/material.dart';
import 'package:harper/Models/get_all_sast_dast_projects_model.dart';
import 'package:harper/Services/get_all_sast_dast_projects_service.dart';
import 'all_project.dart'; // Use this model for AllProject

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
      print('Error fetching projects for get all_projects in Application and Project Screen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : _projects.isEmpty
          ? const Center(
        child: Text('No projects found'),
      )
          : AllProjectTableScreen(projects: _projects),
    );
  }

  AllProject _convertToAllProject(GetAllSastDastProjectsModel projectMain) {
    return AllProject(
      projectMain.projectName ?? 'Unnamed Project', // Default to 'Unnamed Project' if null
      projectMain.config ?? 'Unknown Source', // Default to 'Unknown Source' if null
      projectMain.team ?? 'Unknown Time', // Default to 'Unknown Time' if null
      projectMain.preset.isNotEmpty ? 'Has Preset' : 'No Preset', // Adjusting preset field
      projectMain.status, // Handle status safely as String
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Enable horizontal scrolling
        child: DataTable(
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
          border: TableBorder.all(
            color: Colors.grey[300]!,
            width: 1,
            borderRadius: BorderRadius.circular(8), // Rounded corners for the whole table
          ),
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Source')),
            DataColumn(label: Text('Last Scan')),
            DataColumn(label: Text('Tags')),
            DataColumn(label: Text('Status')),
          ],
          rows: projects.map((project) {
            return _buildDataRow(
              project.projectName ?? 'Unnamed Project',
              project.config ?? 'Unknown Source',
              project.team ?? 'Unknown Time',
              project.preset.isNotEmpty ? 'Has Preset' : 'No Preset',
              project.status,
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildDataRow(String name, String source, String lastScan, String tags, String status) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(source)),
        DataCell(Text(lastScan)),
        DataCell(Text(tags)),
        DataCell(Container(
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
        )),
      ],
    );
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
