import 'package:flutter/material.dart';
import 'package:secura_entry/screens/common/localization_service.dart';
import '/widgets/common/role_based_navbar.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Map<String, String>> activePasses = [
    {'name': 'TAHER TRAVADI', 'pass': 'Active', 'validUntil': '-Jan-2025'},
    {'name': 'NEVIL GADHIA', 'pass': 'Active', 'validUntil': '25-Jan-2025'},
  ];

  void deletePass(int index) {
    setState(() {
      activePasses.removeAt(index);
    });
  }

  void editPass(int index) {
    print('Editing pass for ${activePasses[index]['name']}');
  }

  @override
  Widget build(BuildContext context) {
    final local = Provider.of<LocalizationService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(local.translate('Dashboard')),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: RoleBasedNavbar(role: 'admin'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF41C1BA).withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      local.translate('Analytics Overview'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF256765),
                      ),
                    ),
                    SizedBox(height: 16),
                    Image.asset(
                      'assets/predictive-analytics-in-finance-fb-1024x538.png',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashboardButton(
                    title: local.translate('Add guest'),
                    icon: Icons.person_add,
                    onTap: () => Navigator.pushNamed(context, '/add-guest'),
                  ),
                  DashboardButton(
                    title: local.translate('Guest logs'),
                    icon: Icons.list_alt,
                    onTap: () => Navigator.pushNamed(context, '/guest-logs'),
                  ),
                  DashboardButton(
                    title: local.translate('settings'),
                    icon: Icons.settings,
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                local.translate('Active passes'),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF41C1BA),
                ),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: activePasses.length,
                itemBuilder: (context, index) {
                  final pass = activePasses[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shadowColor: Color(0xFF41C1BA),
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
                        pass['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF256765),
                        ),
                      ),
                      subtitle: Text(
                        "${local.translate('Pass')}: ${pass['pass']}\n${local.translate('Valid until')}: ${pass['validUntil']}",
                        style: TextStyle(color: Color(0xFF41C1BA)),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Color(0xFF256765)),
                            onPressed: () => editPass(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deletePass(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF41C1BA).withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Color(0xFF41C1BA), size: 30),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF41C1BA),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// do i need to do changes to my scanner page code also for finding the qr data back means to decrypt it