import 'package:flutter/material.dart';
import '/widgets/common/floating_navbar.dart';

class AdminNavbar extends StatefulWidget {
  @override
  _AdminNavbarState createState() => _AdminNavbarState();
}

class _AdminNavbarState extends State<AdminNavbar> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/admin-dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/bulk-add-guest');
        break;
      case 2:
        Navigator.pushNamed(context, '/manage-users');
        break;
      case 3:
        Navigator.pushNamed(context, '/pass-logs');
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
        NavbarItem(icon: Icons.group_add, label: "Bulk Pass"),
        NavbarItem(icon: Icons.supervisor_account, label: "Users"),
        NavbarItem(icon: Icons.receipt, label: "Pass Logs"),
      ],
    );
  }
}
