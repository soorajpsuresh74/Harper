import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class Sidebar extends StatefulWidget {
  final SidebarXController controller;

  const Sidebar({super.key, required this.controller});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: _isHovered ? 200 : 60, // Width based on hover state
        color: Colors.blue,
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.dashboard),
              onPressed: () {
                widget.controller.selectIndex(0);
              },
            ),
            if (_isHovered)
              const Text('Dashboard', style: TextStyle(color: Colors.white)),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                widget.controller.selectIndex(1);
              },
            ),
            if (_isHovered)
              const Text('Settings', style: TextStyle(color: Colors.white)),
            // Add more icons and text as needed
          ],
        ),
      ),
    );
  }
}
