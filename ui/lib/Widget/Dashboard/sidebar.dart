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
      child: AnimatedContainer(
        width: _isHovered ? 250 : 60,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.blueAccent.shade700,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            buildMenuItem(
              context,
              icon: Icons.dashboard,
              label: 'Home',
              isHovered: _isHovered,
              onClicked: () => widget.controller.selectIndex(0),
            ),
            buildMenuItem(
              context,
              icon: Icons.settings,
              label: 'Applications & Projects',
              isHovered: _isHovered,
              onClicked: () => widget.controller.selectIndex(1),
            ),
            buildMenuItem(
              context,
              icon: Icons.dynamic_feed,
              label: 'Static Analysis',
              isHovered: _isHovered,
              onClicked: () => widget.controller.selectIndex(2),
            ),
            buildMenuItem(
              context,
              icon: Icons.code,
              label: 'Dynamic Analysis',
              isHovered: _isHovered,
              onClicked: () => widget.controller.selectIndex(3),
            ),
            buildMenuItem(
              context,
              icon: Icons.settings,
              label: 'Settings',
              isHovered: _isHovered,
              onClicked: () => widget.controller.selectIndex(3),
            ),

            const Spacer(),
            if (_isHovered)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isHovered,
    required VoidCallback onClicked,
  }) {
    const color = Colors.white;
    final hoverColor = Colors.white.withOpacity(0.1);

    return ListTile(
      leading: Icon(icon, color: color),
      title: isHovered
          ? Row(
              children: [
                Text(label, style: const TextStyle(color: color, fontSize: 14)),
                const SizedBox(width: 16), // Adjust the gap here
              ],
            )
          : null,
      hoverColor: hoverColor,
      onTap: onClicked,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      // Removed gap parameter
    );
  }
}
