import 'package:flutter/material.dart';

class UserWidgets extends StatelessWidget {
  const UserWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Reduced padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align to the start for profile
        children: [
          // User image with smaller size
          const CircleAvatar(
            radius: 24, // Smaller radius for the image
            backgroundImage: NetworkImage(
              'https://www.example.com/path/to/user_image.jpg', // Replace with actual image URL
            ),
          ),
          const SizedBox(width: 8), // Reduced spacing

          // User details
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe', // Replace with dynamic user name
                style: TextStyle(
                  fontSize: 16, // Slightly smaller font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'johndoe@example.com', // Replace with dynamic user email
                style: TextStyle(
                  fontSize: 12, // Smaller font size
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          const Spacer(), // To push buttons to the right

          // Buttons section
          Row(
            children: [
              // Search button
              OutlinedButton(
                onPressed: () {
                  // Handle search action
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Reduced padding
                  side: const BorderSide(color: Colors.grey),
                  textStyle: const TextStyle(
                    fontSize: 14, // Smaller font size
                    fontWeight: FontWeight.normal,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.search, size: 14), // Smaller icon size
                  ],
                ),
              ),
              const SizedBox(width: 8), // Reduced spacing

              // 'All Findings' button
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Reduced padding
                  side: const BorderSide(color: Colors.grey),
                  textStyle: const TextStyle(
                    fontSize: 14, // Smaller font size
                    fontWeight: FontWeight.normal,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.all_inbox, size: 14), // Smaller icon size
                    SizedBox(width: 8),
                    Text('Alert'),
                  ],
                ),
              ),
              const SizedBox(width: 8), // Reduced spacing

              // 'Refined' button
              OutlinedButton(
                onPressed: () {
                  // Handle search action
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Reduced padding
                  side: const BorderSide(color: Colors.grey),
                  textStyle: const TextStyle(
                    fontSize: 14, // Smaller font size
                    fontWeight: FontWeight.normal,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.filter, size: 14), // Smaller icon size
                    SizedBox(width: 8),
                    Text('Issues'),
                  ],
                ),
              ),
              const SizedBox(width: 8), // Reduced spacing

              // 'All Types' button
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6), // Reduced padding
                  side: const BorderSide(color: Colors.grey),
                  textStyle: const TextStyle(
                    fontSize: 14, // Smaller font size
                    fontWeight: FontWeight.normal,
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.type_specimen, size: 14), // Smaller icon size
                    SizedBox(width: 8),
                    Text('JUMP'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(width: 20), // Adjust spacing for better layout

          // Dropdown button
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
            style: const TextStyle(color: Colors.grey, fontSize: 14), // Smaller font size
            underline: Container(
              height: 1,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
