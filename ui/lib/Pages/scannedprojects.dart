import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:harper/Widget/Dashboard/headerstat.dart';
import 'package:harper/Widget/Dashboard/projectlist.dart';
import 'package:harper/Widget/Dashboard/sidebar.dart';
import '../Widget/Createproject/createproject.dart';

class Scannedprojects extends StatefulWidget {
  const Scannedprojects({super.key});

  @override
  _Scannedprojects createState() => _Scannedprojects();
}

class _Scannedprojects extends State<Scannedprojects> {
  late final SidebarXController _controller;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(selectedIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for CreateProject dialog
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          Sidebar(controller: _controller),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Header
                  const HeaderStats(),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Padding around Create Project button
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0), // Add right padding
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Create New Project',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  content: Container(
                                    constraints: BoxConstraints(
                                      minWidth: screenWidth * 0.8,
                                      minHeight: screenHeight * 0.7,
                                    ),
                                    child: const CreateProjectWidget(),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Create Project',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // Padding around Search Bar
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0), // Add left padding
                        child: SizedBox(
                          width: 250, // Set a smaller width for the search bar
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onSubmitted: (query) {
                              print('Search query: $query');
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Project List
                  const Expanded(child: ProjectListScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
