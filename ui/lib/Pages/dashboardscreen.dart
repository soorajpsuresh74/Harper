import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import '../Widget/Dashboard/sidebar.dart';

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
          const Expanded(
            child: Center(
              child: Text(
                'Welcome to the Dashboard!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
