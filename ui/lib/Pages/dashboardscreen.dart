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
  final TextEditingController _searchController = TextEditingController();

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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Header
                  const HeaderStats(),
                  const SizedBox(height: 20),

                  // Small Search Box aligned to the left
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 250, // Set a smaller width for the search bar
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onSubmitted: (query) {
                          print('Search query: $query');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Project List
                  const Expanded(child: ProjectListScreen()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }
}
