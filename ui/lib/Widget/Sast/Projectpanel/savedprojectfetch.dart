import 'package:flutter/material.dart';
import 'package:harper/Models/Sast/savedprojects.dart';
import 'package:harper/Services/Sast/fetchsaved.dart';

class SavedProjectsWidget extends StatefulWidget {
  const SavedProjectsWidget({Key? key}) : super(key: key);

  @override
  _SavedProjectsWidgetState createState() => _SavedProjectsWidgetState();
}

class _SavedProjectsWidgetState extends State<SavedProjectsWidget> {
  final FetchSavedServiceAPI fetchService = FetchSavedServiceAPI();
  late Future<List<FetchSavedProjectModel>> futureProjects;

  @override
  void initState() {
    super.initState();
    futureProjects = fetchService.fetchSavedProjects();
  }

  void _refreshProjects() {
    setState(() {
      futureProjects = fetchService.fetchSavedProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Projects'),
      ),
      body: FutureBuilder<List<FetchSavedProjectModel>>(
        future: futureProjects,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshProjects,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No saved projects found.'));
          }

          // Display data in DataTable
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Project Name')),
                DataColumn(label: Text('Project ID')),
                DataColumn(label: Text('Configuration')),
                DataColumn(label: Text('Team')),
                DataColumn(label: Text('Preset')),
                DataColumn(label: Text('Status')),
              ],
              rows: snapshot.data!.map((project) {
                return DataRow(cells: [
                  DataCell(Text(project.name ?? 'Unnamed Project')),
                  DataCell(Text(project.id ?? 'No ID')),
                  DataCell(Text(project.config ?? 'No Configuration')),
                  DataCell(Text(project.team ?? 'Unknown Team')),
                  DataCell(Text(project.preset ?? 'Unknown Preset')),
                  DataCell(
                    Text(project.status == 1 ? 'Active' : 'Inactive'),
                  ),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
