import 'package:flutter/material.dart';
import 'package:harper/Widget/Dashboard/statcard.dart';

class HeaderStats extends StatelessWidget {
  const HeaderStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: StatCard('Managed Projects', '11', icon: Icons.manage_accounts_rounded,)),
        Expanded(child: StatCard('High Risk Projects', '10', color: Colors.red, icon: Icons.priority_high,)),
        Expanded(child: StatCard('Medium Risk Projects', '1', color: Colors.orange, icon: Icons.indeterminate_check_box)),
        Expanded(child: StatCard('Low Risk Projects', 'None', color: Colors.green, icon: Icons.low_priority,)),
      ],
    );
  }
}
