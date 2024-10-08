import 'package:flutter/material.dart';
import 'package:harper/Widget/Createproject/createproject.dart';
import 'package:harper/Widget/Sast/Informationpanel/infromationpanel.dart';
import 'package:harper/Widget/Sast/Projectpanel/savedprojectfetch.dart';

class StaticAnalysisPage extends StatelessWidget {
  const StaticAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Static Analysis'),
        centerTitle: true,
        backgroundColor: Colors.blue, // Change to a color of your choice
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First column - Information panel
            Expanded(
              flex: 1,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: screenHeight, // Use the full height of the screen
                ),
                color: Colors.white, // Change to white background
                child: const SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Information Panel',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black, // Change text color to black
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      InformationPanel(),
                    ],
                  ),
                ),
              ),
            ),

            // Second column - Button, Saved Projects, and Table
            Expanded(
              flex: 3,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: screenHeight, // Use the full height of the screen
                ),
                color: Colors.grey[200], // Change to a lighter background
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Button container
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Search Button
                          ElevatedButton(
                            onPressed: () {
                              showAboutDialog(
                                context: context,
                                applicationName: 'Search Function',
                                applicationVersion: '1.0',
                                children: [
                                  const Text(
                                      'This will allow searching through the Manager_Projects data.'),
                                ],
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue, // Change to a color of your choice
                            ),
                            child: const Text('Search'),
                          ),

                          const SizedBox(width: 10),

                          // Create Project Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue, // Change to a color of your choice
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
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Saved Projects Header
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Saved Projects',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black, // Change text color to black
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Adjust the size of the SavedProjectsWidget based on screen height
                    SizedBox(
                      height: screenHeight * 0.4, // Adjust height as needed
                      child: SavedProjectsWidget(), // Display the saved projects
                    ),

                    const SizedBox(height: 20),

                    // Table container
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Table(
                            border: const TableBorder(
                              verticalInside: BorderSide(
                                width: 1,
                                color: Colors.black, // Change border color to black
                                style: BorderStyle.solid,
                              ),
                              horizontalInside: BorderSide(
                                width: 1,
                                color: Colors.black, // Change border color to black
                                style: BorderStyle.solid,
                              ),
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(3),
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue, // Change to a color of your choice
        child: const Icon(Icons.info, color: Colors.white),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black, // Change text color to black
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: const TextStyle(color: Colors.black)), // Change text color to black
        ),
      ],
    );
  }
}
