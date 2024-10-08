import 'package:flutter/material.dart';
import 'package:harper/Models/Sast/savedprojects.dart';
import 'package:harper/Services/Sast/fetchsaved.dart';

class SavedProjectsWidget extends StatelessWidget {
  final FetchSavedServiceAPI fetchService = FetchSavedServiceAPI();

  SavedProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Projects'),
      ),
      body: FutureBuilder<List<FetchSavedProjectModel>>(
        future: fetchService.fetchSavedProjects(), // Fetch the saved projects
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
                    onPressed: () {
                      // Retry fetching the data
                      fetchService.fetchSavedProjects();
                    },
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // To allow horizontal scrolling for wide tables
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
                    DataCell(Text(project.config ?? 'No Date')),
                    DataCell(Text(project.team ?? 'Unknown Status')),
                    DataCell(Text(project.preset ?? 'Unknown Status')),
                    DataCell(bool(project.status ?? 'Unknown Status') as Widget)

                  ]);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
