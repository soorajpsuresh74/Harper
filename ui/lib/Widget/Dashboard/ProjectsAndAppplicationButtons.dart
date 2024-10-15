import 'package:flutter/material.dart';

class ProjectsAndAppplicationButtons extends StatelessWidget {
  const ProjectsAndAppplicationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0), // Add padding to the container
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Search button
          OutlinedButton(
            onPressed: () {
              // Handle search action
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70, // Button background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 8), // Increase padding for a larger button
              side: const BorderSide(
                  color: Colors.grey), // Border color if needed
              textStyle: const TextStyle(
                fontSize: 15, // Increase font size for a larger text
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start, // Left align the text
              children: [
                Icon(Icons.search,
                    size: 15), // Optional search icon to the left of the text
                SizedBox(width: 10), // Space between the icon and the text
                Text('Search'),
              ],
            ),
          ),

          const SizedBox(width: 10), // Add space between buttons

          // All findings button
          OutlinedButton(
            onPressed: () {
              // Handle search action
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70, // Button background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 8), // Increase padding for a larger button
              side: const BorderSide(
                  color: Colors.grey), // Border color if needed
              textStyle: const TextStyle(
                fontSize: 15, // Increase font size for a larger text
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start, // Left align the text
              children: [
                Icon(Icons.all_inbox,
                    size: 15), // Optional search icon to the left of the text
                SizedBox(width: 10), // Space between the icon and the text
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
              backgroundColor: Colors.white70, // Button background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 8), // Increase padding for a larger button
              side: const BorderSide(
                  color: Colors.grey), // Border color if needed
              textStyle: const TextStyle(
                fontSize: 15, // Increase font size for a larger text
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start, // Left align the text
              children: [
                Icon(Icons.filter,
                    size: 15), // Optional search icon to the left of the text
                SizedBox(width: 10), // Space between the icon and the text
                Text('Refined'),
              ],
            ),
          ),
          const SizedBox(width: 10), // Add space between buttons

          // All types button
          OutlinedButton(
            onPressed: () {
              // Handle search action
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white70, // Button background color
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 8), // Increase padding for a larger button
              side: const BorderSide(color: Colors.grey), // Border color if needed
              textStyle: const TextStyle(
                fontSize: 15, // Increase font size for a larger text
                fontWeight: FontWeight.normal,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start, // Left align the text
              children: [
                Icon(Icons.type_specimen, size: 15), // Optional search icon to the left of the text
                SizedBox(width: 10), // Space between the icon and the text
                Text('All types'),
              ],
            ),
          ),

          const SizedBox(width: 30), // Add space between buttons

          // Actions dropdown button
          DropdownButton<String>(
            value:
            'Action 1', // Set the default value to an actual item in the list
            items: <String>['Action 1', 'Action 2', 'Action 3']
                .map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              // Handle dropdown selection change
            },
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style:
            const TextStyle(color: Colors.grey,fontSize: 16), // Customize dropdown text style
            underline: Container(
              height: 2,
              color: Colors.black, // Customize the underline
            ),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Buttons and Dropdown'),
//         backgroundColor: Colors.blue,
//       ),
//       body: ProjectsAndAppplicationButtons(),
//     ),
//   ));
// }
