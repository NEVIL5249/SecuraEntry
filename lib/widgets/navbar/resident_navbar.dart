import 'package:flutter/material.dart';
import '/widgets/common/floating_navbar.dart';

class ResidentNavbar extends StatefulWidget {
  @override
  _ResidentNavbarState createState() => _ResidentNavbarState();
}

class _ResidentNavbarState extends State<ResidentNavbar> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navigate to appropriate screen
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/add-guest');
        break;
      case 2:
        Navigator.pushNamed(context, '/guest-logs');
        break;
      case 3:
        Navigator.pushNamed(context, '/settings');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
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
        NavbarItem(icon: Icons.add, label: "Add Guest"),
        NavbarItem(icon: Icons.list, label: "Guest Log"),
        NavbarItem(icon: Icons.settings, label: "Settings"),
        NavbarItem(icon: Icons.person, label: "Profile"),
      ],
    );
  }
}
