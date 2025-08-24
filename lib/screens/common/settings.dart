// // import 'package:flutter/material.dart';
// // import '/widgets/common/role_based_navbar.dart';
// //
// // class SettingsScreen extends StatelessWidget {
// //   const SettingsScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Settings'),
// //         centerTitle: true,
// //       ),
// //       bottomNavigationBar: SizedBox(
// //         width: double.infinity, // Ensures it doesn't overflow
// //         height: 70, // Adjust as needed
// //         child: RoleBasedNavbar(role: 'resident',),
// //       ),
// //       body: ListView(
// //         padding: const EdgeInsets.all(16.0),
// //         children: [
// //           ListTile(
// //             leading: const Icon(Icons.language, color: Color(0xFF41C1BA)),
// //             title: const Text(
// //               'Language',
// //               style: TextStyle(color:Color(0xFF256765) ),
// //             ),
// //             onTap: () {
// //               // Navigate to Language settings
// //             },
// //           ),
// //           const Divider(color: Colors.grey),
// //           ListTile(
// //             leading: const Icon(Icons.notifications, color: Color(0xFF41C1BA)),
// //             title: const Text(
// //               'Notifications',
// //               style: TextStyle(color:Color(0xFF256765)),
// //             ),
// //             onTap: () {
// //               // Navigate to Notifications settings
// //             },
// //           ),
// //           const Divider(color: Colors.grey),
// //           ListTile(
// //             leading: const Icon(Icons.security, color: Color(0xFF41C1BA)),
// //             title: const Text(
// //               'Privacy & Security',
// //               style: TextStyle(color:Color(0xFF256765)),
// //             ),
// //             onTap: () {
// //               // Navigate to Privacy settings
// //             },
// //           ),
// //           const Divider(color: Colors.grey),
// //           ListTile(
// //             leading: const Icon(Icons.help_outline, color: Color(0xFF41C1BA)),
// //             title: const Text(
// //               'Help & Support',
// //               style: TextStyle(color:Color(0xFF256765)),
// //             ),
// //             onTap: () {
// //               // Navigate to Help & Support
// //             },
// //           ),
// //           const Divider(color: Colors.grey),
// //           ListTile(
// //             leading: const Icon(Icons.logout, color: Color(0xFFFF0000)),
// //             title: const Text(
// //               'Logout',
// //               style: TextStyle(color:Color(0xFFFF0000)),
// //             ),
// //             onTap: () {
// //               // Handle Logout
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '/widgets/common/role_based_navbar.dart';
// import 'package:secura_entry/screens/common/localization_service.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
//
//   void _logout(BuildContext context) async {
//     bool confirmLogout = await _showLogoutDialog(context);
//     if (confirmLogout) {
//       await FirebaseAuth.instance.signOut();
//       Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
//     }
//   }
//
//   Future<bool> _showLogoutDialog(BuildContext context) async {
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Logout'),
//           content: const Text('Are you sure you want to logout?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: const Text('Logout', style: TextStyle(color: Colors.red)),
//             ),
//           ],
//         );
//       },
//     ) ?? false;
//   }
//
//   void _navigateTo(BuildContext context, String route) {
//     Navigator.pushNamed(context, route);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final localization = Provider.of<LocalizationService>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(localization.translate('Settings')),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: SizedBox(
//         width: double.infinity,
//         height: 70,
//         child: RoleBasedNavbar(role: 'resident'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           ListTile(
//             leading: const Icon(Icons.language, color: Color(0xFF41C1BA)),
//             title: const Text('Language', style: TextStyle(color: Color(0xFF256765))),
//             onTap: () => _navigateTo(context, '/language'),
//           ),
//           const Divider(color: Colors.grey),
//           ListTile(
//             leading: const Icon(Icons.notifications, color: Color(0xFF41C1BA)),
//             title: const Text('Notifications', style: TextStyle(color: Color(0xFF256765))),
//             onTap: () => _navigateTo(context, '/notifications'),
//           ),
//           const Divider(color: Colors.grey),
//           ListTile(
//             leading: const Icon(Icons.security, color: Color(0xFF41C1BA)),
//             title: const Text('Privacy & Security', style: TextStyle(color: Color(0xFF256765))),
//             onTap: () => _navigateTo(context, '/privacy'),
//           ),
//           const Divider(color: Colors.grey),
//           ListTile(
//             leading: const Icon(Icons.help_outline, color: Color(0xFF41C1BA)),
//             title: const Text('Help & Support', style: TextStyle(color: Color(0xFF256765))),
//             onTap: () => _navigateTo(context, '/help'),
//           ),
//           const Divider(color: Colors.grey),
//           ListTile(
//             leading: const Icon(Icons.logout, color: Color(0xFFFF0000)),
//             title: const Text('Logout', style: TextStyle(color: Color(0xFFFF0000))),
//             onTap: () => _logout(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '/widgets/common/role_based_navbar.dart';
import 'package:secura_entry/screens/common/localization_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  void _logout(BuildContext context) async {
    bool confirmLogout = await _showLogoutDialog(context);
    if (confirmLogout) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    final localization = Provider.of<LocalizationService>(context, listen: false);
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization.translate('logout_title')),
          content: Text(localization.translate('logout_message')),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(localization.translate('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                localization.translate('logout'),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  void _navigateTo(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final localization = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.translate('settings')),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: RoleBasedNavbar(role: 'resident'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.language, color: Color(0xFF41C1BA)),
            title: Text(localization.translate('Language'), style: const TextStyle(color: Color(0xFF256765))),
            onTap: () => _navigateTo(context, '/language'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.notifications, color: Color(0xFF41C1BA)),
            title: Text(localization.translate('Notifications'), style: const TextStyle(color: Color(0xFF256765))),
            onTap: () => _navigateTo(context, '/notifications'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.security, color: Color(0xFF41C1BA)),
            title: Text(localization.translate('Privacy Security'), style: const TextStyle(color: Color(0xFF256765))),
            onTap: () => _navigateTo(context, '/privacy'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.help_outline, color: Color(0xFF41C1BA)),
            title: Text(localization.translate('Help Support'), style: const TextStyle(color: Color(0xFF256765))),
            onTap: () => _navigateTo(context, '/help'),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFFFF0000)),
            title: Text(localization.translate('Logout'), style: const TextStyle(color: Color(0xFFFF0000))),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
