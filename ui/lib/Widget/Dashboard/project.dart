import 'package:flutter/material.dart';

class Project {
  final String name;
  final String source;
  final String lastScan;
  final String tags;
  final String risk;
  final int high, medium, low;

  Project(this.name, this.source, this.lastScan, this.tags, this.risk,
      this.high, this.medium, this.low);
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

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
                RiskLevelBadge(risk: project.risk),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                RiskStat('High', project.high, Colors.red),
                RiskStat('Medium', project.medium, Colors.orange),
                RiskStat('Low', project.low, Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RiskLevelBadge extends StatelessWidget {
  final String risk;

  const RiskLevelBadge({super.key, required this.risk});

  @override
  Widget build(BuildContext context) {
    Color badgeColor;
    switch (risk) {
      case 'High':
        badgeColor = Colors.red;
        break;
      case 'Medium':
        badgeColor = Colors.orange;
        break;
      case 'Low':
        badgeColor = Colors.green;
        break;
      default:
        badgeColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(risk, style: const TextStyle(color: Colors.white)),
    );
  }
}

class RiskStat extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const RiskStat(this.label, this.count, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(count.toString(), style: TextStyle(color: color, fontSize: 20)),
        ],
      ),
    );
  }
}
