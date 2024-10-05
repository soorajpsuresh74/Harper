import 'package:flutter/material.dart';
import 'package:harper/Widget/createproject.dart';

class StaticAnalysisPage extends StatelessWidget {
  const StaticAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static Analysis'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // Use MediaQuery to get the width and height of the screen
                final screenWidth = MediaQuery.of(context).size.width;
                final screenHeight = MediaQuery.of(context).size.height;

                return AlertDialog(
                  title: const Text('Create New...'),
                  content: Container(
                    // Use MediaQuery for a responsive design
                    constraints: BoxConstraints(
                      minWidth: screenWidth * 0.8,
                      minHeight: screenHeight * 0.7,
                    ),
                    child: const CreateProjectWidget(), // Call your CreateProjectWidget here
                  ),
                  actions: [
                    TextButton(
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
          child: const Text('Create Project'), // Button text
        ),
      ),
    );
  }
}
