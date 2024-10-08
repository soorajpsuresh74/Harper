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
        future: fetchService.fetchSavedProjects(), // Call your service method here
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

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final project = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(project.name ?? 'Unnamed Project'),
                  subtitle: Text(project.id ?? 'No ID'),
                  onTap: () {
                    // Navigate to project details or perform another action
                    // Navigator.push(...);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
