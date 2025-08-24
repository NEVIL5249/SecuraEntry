import 'package:flutter/material.dart';
import '/widgets/navbar/admin_navbar.dart';

class AdminDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 200, // Placeholder for analytics graph
              color: Colors.grey[300],
              child: Center(child: Text('Analytics Graph Placeholder')),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.people),
                      title: Text('Total Visitors'),
                      subtitle: Text('1234'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Active Users'),
                      subtitle: Text('56'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.receipt_long),
                      title: Text('Pass Logs'),
                      subtitle: Text('789'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminNavbar(),
    );
  }
}
