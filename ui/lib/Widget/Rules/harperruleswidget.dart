import 'package:flutter/material.dart';

class HarperRulesWidget extends StatelessWidget {
  const HarperRulesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white, // Set background to white
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Harper Rules',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Change text color to black
            ),
          ),
          SizedBox(height: 20),
          Text(
            'This section contains the rules for static analysis.',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
