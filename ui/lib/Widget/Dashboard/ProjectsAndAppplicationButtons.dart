import 'package:flutter/material.dart';

class ProjectsAndAppplicationButtons extends StatelessWidget {
  const ProjectsAndAppplicationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add padding to the container
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlinedButton(
            onPressed: () {
              // Handle search action
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              side: const BorderSide(color: Colors.grey),
              textStyle: const TextStyle(
                fontSize: 15, // Increase font size for a larger text
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search, size: 15),
                SizedBox(width: 10),
                Text('Search'),
              ],
            ),
          ),

          const SizedBox(width: 10),

          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              side: const BorderSide(color: Colors.grey),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.all_inbox, size: 15),
                SizedBox(width: 10),
                Text('All Findings'),
              ],
            ),
          ),
          const SizedBox(width: 10),

          OutlinedButton(
            onPressed: () {
              // Handle search action
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              side: const BorderSide(color: Colors.grey),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.filter, size: 15),
                SizedBox(width: 10),
                Text('Refined'),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // All types button
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70,
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8),
              side: const BorderSide(color: Colors.grey),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.type_specimen, size: 15),
                SizedBox(width: 10),
                Text('All types'),
              ],
            ),
          ),

          const SizedBox(width: 30),

          DropdownButton<String>(
            value: 'Action 1',
            items: <String>['Action 1', 'Action 2', 'Action 3']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {},
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
            underline: Container(
              height: 2,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
