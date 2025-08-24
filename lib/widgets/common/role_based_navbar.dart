import 'package:flutter/material.dart';
import '/widgets/navbar/resident_navbar.dart';
import '/widgets/navbar/admin_navbar.dart';
import '/widgets/navbar/guard_navbar.dart';

class RoleBasedNavbar extends StatelessWidget {
  final String role; // Pass user role: 'resident', 'admin', 'guard'

  RoleBasedNavbar({required this.role});

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case 'resident':
        return ResidentNavbar();
      case 'admin':
        return AdminNavbar();
      case 'guard':
        return GuardNavbar();
      default:
        return SizedBox.shrink(); // Fallback for unknown roles
    }
  }
}
