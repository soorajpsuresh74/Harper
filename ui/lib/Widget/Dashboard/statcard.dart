import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final IconData icon;

  const StatCard(
      this.title,
      this.count, {
        super.key,
        this.color = Colors.blue,
        this.icon = Icons.info,
      });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon on the left
            Icon(
              icon,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(width: 25), // Space between the icon and the text

            // Column for title and count
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to start within the column
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically within the column
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4), // Adds small space between title and count

                // Count
                Text(
                  count,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
