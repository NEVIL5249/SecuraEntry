import 'package:flutter/material.dart';
import '/widgets/common/floating_navbar.dart';

class GuardNavbar extends StatefulWidget {
  @override
  _GuardNavbarState createState() => _GuardNavbarState();
}

class _GuardNavbarState extends State<GuardNavbar> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/guard-dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/scan-qr');
        break;
      case 2:
        Navigator.pushNamed(context, '/manual-entry');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingNavbar(
      currentIndex: _currentIndex,
      onTabTapped: _onTabTapped,
      items: [
        NavbarItem(icon: Icons.dashboard, label: "Dashboard"),
        NavbarItem(icon: Icons.qr_code_scanner, label: "Scan QR"),
        NavbarItem(icon: Icons.edit, label: "Manual Entry"),
      ],
    );
  }
}
