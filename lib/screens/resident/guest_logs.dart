import 'package:flutter/material.dart';
import '/widgets/common/role_based_navbar.dart';

class GuestLogsScreen extends StatelessWidget {
  final List<Map<String, String>> guestLogs = [
    {
      'name': 'NEVIL GADHIA',
      'phone': '1234567800',
      'purpose': 'Meeting',
      'date': '12-04_2025',
    },
    {
      'name': 'TAHER TRAVADI',
      'phone': '1234567800',
      'purpose': 'Meeting',
      'date': '12-04_2025',
    },

  ];

  void deleteLog(BuildContext context, int index) {
    // Add delete logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted log for ${guestLogs[index]['name']}'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void editLog(BuildContext context, int index) {
    // Add edit logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing log for ${guestLogs[index]['name']}'),
        backgroundColor: Color(0xFF41C1BA),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Logs'),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity, // Ensures it doesn't overflow
        height: 70, // Adjust as needed
        child: RoleBasedNavbar(role: 'resident',),
      ),

      body: guestLogs.isEmpty
          ? Center(
        child: Text(
          'No Guests Logged Yet!',
          style: TextStyle(fontSize: 18, color: Color(0xFF41C1BA)),
        ),
      )
          : ListView.builder(
        itemCount: guestLogs.length,
        itemBuilder: (context, index) {
          final guest = guestLogs[index];
          return Card(
            elevation: 4,
            shadowColor: Color(0xFF41C1BA),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Color(0xFFFFFFFF),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF41C1BA),
                child: Icon(
                  Icons.person,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              title: Text(
                guest['name']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:Color(0xFF256765),
                ),
              ),
              subtitle: Text(
                'Phone: ${guest['phone']}\nPurpose: ${guest['purpose']}\nDate: ${guest['date']}',
                style: TextStyle(color: Color(0xFF41C1BA)),
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color:Color(0xFF256765)),
                    onPressed: () => editLog(context, index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteLog(context, index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
