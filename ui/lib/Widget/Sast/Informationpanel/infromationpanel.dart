import 'package:flutter/material.dart';
import 'package:harper/Widget/Sast/Informationpanel/coverage.dart';
import 'package:harper/Widget/Sast/Informationpanel/duplication.dart';
import 'package:harper/Widget/Sast/Informationpanel/maintainability.dart';
import 'package:harper/Widget/Sast/Informationpanel/security.dart';
import 'reliability.dart';

class InformationPanel extends StatelessWidget {
  const InformationPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the whole panel
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black12), // Light border for the panel
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adding a title to the information panel
          const Text(
            'Static Analysis Metrics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20), // Separation before the metrics

          // Adding metrics in separated cards
          _buildMetricCard(
            Icons.check_circle,
            'Reliability Metrics',
            const Reliability(),
          ),
          const SizedBox(height: 10), // Space between cards
          _buildMetricCard(
            Icons.security,
            'Security Metrics',
            const Security(),
          ),
          const SizedBox(height: 10), // Space between cards
          _buildMetricCard(
            Icons.build,
            'Maintainability Metrics',
            const Maintainability(),
          ),
          const SizedBox(height: 10), // Space between cards
          _buildMetricCard(
            Icons.view_list,
            'Duplication Metrics',
            const Duplication(),
          ),
          const SizedBox(height: 10), // Space between cards
          _buildMetricCard(
            Icons.check,
            'Coverage Metrics',
            const Coverage(),
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

  Widget _buildMetricCard(IconData icon, String title, Widget chartWidget) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 300, // Set the minimum width you want for the cards
      ),
      child: Card(
        elevation: 4, // Shadow for a raised effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 30, // Icon size for consistency
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    // Wrap the title with Expanded to prevent overflow
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              chartWidget,
            ],
          ),
        ),
      ),
    );
  }
}
