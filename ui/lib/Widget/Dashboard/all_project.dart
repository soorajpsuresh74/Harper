import 'package:flutter/cupertino.dart';
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
      this.status, // Replacing risk
      );
}


class AllProjectCard extends StatelessWidget {
  final AllProject project;

  const AllProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text('Source: ${project.source} | Last Scan: ${project.lastScan}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tags: ${project.tags}'),
                StatusBadge(status: project.status), // New badge for status
              ],
            ),
          ],
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
    switch (status) {
      case 'Active':
        badgeColor = Colors.green;
        break;
      case 'Inactive':
        badgeColor = Colors.grey;
        break;
      default:
        badgeColor = Colors.red;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status, style: const TextStyle(color: Colors.white)),
    );
  }
}
