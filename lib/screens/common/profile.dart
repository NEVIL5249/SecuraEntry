// import 'package:flutter/material.dart';
// import '/widgets/common/role_based_navbar.dart';
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         centerTitle: true,
//       ),
//       bottomNavigationBar: SizedBox(
//         width: double.infinity, // Ensures it doesn't overflow
//         height: 70, // Adjust as needed
//         child: RoleBasedNavbar(role: 'resident',),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundColor: Color(0xFF41C1BA),
//                 child: Icon(
//                   Icons.person,
//                   size: 50,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Name: Taher M Travadi',
//               style: TextStyle(fontSize: 18, color:Color(0xFF256765)),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Email: Badridevelopersandsales@gmail.com',
//               style: TextStyle(fontSize: 18, color:Color(0xFF41C1BA)),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               'Phone: +91 8140279469',
//               style: TextStyle(fontSize: 18, color:Color(0xFF41C1BA)),
//             ),
//             const SizedBox(height: 20),
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Logout or action
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF41C1BA),
//                   padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 ),
//                 child: const Text(
//                   'Logout',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '/widgets/common/role_based_navbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Color(0xFF41C1BA),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: RoleBasedNavbar(role: 'resident'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color:  Color(0xFF41C1BA),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 45,
                  backgroundColor: Color(0xFF41C1BA),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildInfoTile('Name', 'Taher M Travadi', const Color(0xFF41C1BA)),
            _buildInfoTile('Email', 'Badridevelopersandsales@gmail.com', const Color(0xFF41C1BA)),
            _buildInfoTile('Phone', '+91 8140279469', const Color(0xFF41C1BA)),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Logout or action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF0000),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(color: color, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
