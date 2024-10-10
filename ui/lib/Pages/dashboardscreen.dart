import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:harper/Widget/Dashboard/headerstat.dart';
import 'package:harper/Widget/Dashboard/projectlist.dart';
import 'package:harper/Widget/Dashboard/sidebar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final SidebarXController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SidebarXController(selectedIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(controller: _controller),
          Expanded(
            child: Padding(  // Added Padding widget here
              padding: const EdgeInsets.all(16.0),  // Adjust the value as needed
              child: Column(
                children: [
                  const HeaderStats(),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(child: ProjectListScreen()),  // Ensure ProjectListScreen is scrollable
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
