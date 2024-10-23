import 'package:flutter/material.dart';

class SastReportScreen extends StatelessWidget {
  const SastReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SAST Demonstration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with project name and branch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'cx-matts/EquityTradingApp',
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text('Branch: master',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: const Text(
                    'High Risk',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Scan details row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Scan: 7c5fd1f1-5466-436e-5bcb-8025f7a13b11',
                  style: TextStyle(color: Colors.grey),
                ),
                Text('Last Scan: 3 Hours ago',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),

            // Vulnerability cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildVulnerabilityCard('Total Vulnerabilities', '133',
                    {'High': 48, 'Medium': 20, 'Low': 65}),
                _buildVulnerabilityCard('Vulnerabilities by Scan Type', 'SAST',
                    {'SAST': 133, 'KICS': 0, 'SCA': 0}),
              ],
            ),
            const SizedBox(height: 20),

            // Severity over time chart
            _buildChartPlaceholder('Severity Over Time'),

            const SizedBox(height: 20),

            // Aging Summary and Technology Results Row
            Row(
              children: [
                Expanded(child: _buildChartPlaceholder('Aging Summary')),
                const SizedBox(width: 16),
                Expanded(
                    child: _buildChartPlaceholder('Results by Technologies')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // A reusable card widget for vulnerability details
  static Widget _buildVulnerabilityCard(
      String title, String mainValue, Map<String, int> breakdown) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                mainValue,
                style:
                const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              for (var entry in breakdown.entries)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(entry.key),
                      Text(entry.value.toString()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // A placeholder for charts (Severity Over Time, Aging Summary, Technology Results)
  static Widget _buildChartPlaceholder(String title) {
    return Card(
      elevation: 4,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Center(
                child: Text('Chart goes here',
                    style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SastReportScreen(),
  ));
}
