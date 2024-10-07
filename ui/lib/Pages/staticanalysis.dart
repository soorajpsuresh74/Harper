import 'package:flutter/material.dart';
import 'package:harper/Widget/Createproject/createproject.dart';

class StaticAnalysisPage extends StatelessWidget {
  const StaticAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static Analysis'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Change app bar color
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, // Button color
            padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 12), // Padding for button
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
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

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
                        foregroundColor:
                            Colors.deepPurple, // Change button text color
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text('Close'), // Close button text
                    ),
                  ],
                );
              },
            );
          },
          child: const Text(
            'Create Project',
            style: TextStyle(color: Colors.white),
          ), // Button text
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your action here, if needed
        },
        child: const Icon(Icons.info), // Example icon
        backgroundColor: Colors.deepPurple, // Button color
      ),
    );
  }
}
