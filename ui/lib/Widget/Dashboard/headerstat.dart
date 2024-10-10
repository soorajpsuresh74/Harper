import 'package:flutter/material.dart';

import 'package:harper/Widget/Dashboard/statcard.dart';

class HeaderStats extends StatelessWidget {
  const HeaderStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatCard('Managed Projects', '11'),
        StatCard('High Risk Projects', '10', color: Colors.red),
        StatCard('Medium Risk Projects', '1', color: Colors.orange),
        StatCard('Low Risk Projects', 'None', color: Colors.green),
      ],
    );
  }
}