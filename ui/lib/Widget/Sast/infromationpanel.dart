import 'package:flutter/material.dart';
import 'package:harper/Widget/Sast/Informationpanel/coverage.dart';
import 'package:harper/Widget/Sast/Informationpanel/duplication.dart';
import 'package:harper/Widget/Sast/Informationpanel/maintainability.dart';
import 'package:harper/Widget/Sast/Informationpanel/security.dart';
import 'Informationpanel/reliability.dart';

class InformationPanel extends StatelessWidget {
  const InformationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const Expanded(
                child: Text(
                  'This shows a table with reliability chart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Reliability(), // Reliability chart appears after the text
            ],
          ),
          const SizedBox(height: 10), // Separation between rows
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const Expanded(
                child: Text(
                  'This shows a table with security chart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Security(), // Security chart appears after the text
            ],
          ),
          const SizedBox(height: 10), // Separation between rows
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const Expanded(
                child: Text(
                  'This shows a table with maintainability chart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Maintainability(), // Maintainability chart appears after the text
            ],
          ),
          const SizedBox(height: 10), // Separation between rows
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const Expanded(
                child: Text(
                  'This shows a table with duplication chart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Duplication(), // Duplication chart appears after the text
            ],
          ),
          const SizedBox(height: 10), // Separation between rows
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const Expanded(
                child: Text(
                  'This shows a table with coverage chart',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Coverage(), // Coverage chart appears after the text
            ],
          ),

          const SizedBox(height: 20),
          const Text(
            'You can customize the content and style as needed.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
