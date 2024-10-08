import 'package:flutter/material.dart';
import 'package:harper/Widget/Createproject/createproject.dart';
import 'package:harper/Widget/Sast/infromationpanel.dart';

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
        backgroundColor: Colors.deepPurple,
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
                  minHeight: screenHeight * 1.0,
                ),
                color: Colors.deepPurple[50],
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Information Panel',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const InformationPanel(),
                  ],
                ),
              ),
            ),

            // Second column - Button and table
            Expanded(
              flex: 3,
              child: Container(
                constraints: BoxConstraints(
                  minHeight: screenHeight * 1.0,
                ),
                color: Colors.deepPurple[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Button in its own container, aligned to the right
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
                        children: [
                          // Search Button
                          ElevatedButton(
                            onPressed: () {
                              showAboutDialog(
                                context: context,
                                applicationName: 'Search Function',
                                applicationVersion: '1.0',
                                children: [
                                  const Text('This will allow searching through the project data.'),
                                ],
                              );
                            },
                            child: const Text('Search'),
                          ),

                          const SizedBox(width: 10), // Space between buttons

                          // Create Project Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
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
                                        color: Colors.deepPurple,
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
                                          foregroundColor: Colors.deepPurple,
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

                    // Space between button and table
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
                                color: Colors.blue,
                                style: BorderStyle.solid,
                              ),
                            ),
                            columnWidths: const {
                              0: FlexColumnWidth(1),
                              1: FlexColumnWidth(3),
                            },
                            children: [
                              _buildTableRow('Project Name', 'Static Analysis Tool'),
                              _buildTableRow('Created Date', '2024-10-08'),
                              _buildTableRow('Owner', 'Sooraj P S'),
                              _buildTableRow('Status', 'In Progress'),
                            ],
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
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.info),
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
              color: Colors.deepPurple,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }
}
