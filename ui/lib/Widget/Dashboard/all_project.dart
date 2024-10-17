import 'package:flutter/material.dart';

class AllProject {
  final String name;
  final String source;
  final String lastScan;
  final String tags;
  final String status;  // New parameter replacing risk and risk-level counts

  AllProject(
      this.name,
      this.source,
      this.lastScan,
      this.tags,
      this.status,
      );
}

class AllProjectCard extends StatelessWidget {
  final AllProject project;

  const AllProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), // Rounded corners
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87, // Dark text color
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Source: ${project.source}',
                style: const TextStyle(
                  color: Colors.black54, // Slightly faded text
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Last Scan: ${project.lastScan}',
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tags: ${project.tags}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blueAccent, // Tags color
                    ),
                  ),
                  StatusBadge(status: project.status),
                ],
              ),
              const SizedBox(height: 12),
              Divider(
                color: Colors.grey[300], // Divider line between content and footer
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    TextStyle badgeTextStyle;

    // Set badge color and text style based on status
    switch (status) {
      case 'Active':
        badgeColor = Colors.green;
        badgeTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
        break;
      case 'Inactive':
        badgeColor = Colors.grey;
        badgeTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
        break;
      default:
        badgeColor = Colors.red;
        badgeTextStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: badgeTextStyle,
      ),
    );
  }
}
