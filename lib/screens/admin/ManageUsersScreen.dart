import 'package:flutter/material.dart';
import '/widgets/common/role_based_navbar.dart';
import '/screens/admin/AddUserScreen.dart';  // Import the AddUserScreen

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  List<String> users = ["A101", "A102", "B101", "B102"];
  List<String> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredUsers = List.from(users);
  }

  void filterUsers(String query) {
    setState(() {
      filteredUsers = users
          .where((user) => user.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter by Wing"),
          content: DropdownButton<String>(
            hint: Text("Select Wing"),
            onChanged: (String? newValue) {
              setState(() {
                // Example of filtering by wing
                filteredUsers = users.where((user) {
                  return user.contains(newValue ?? '');
                }).toList();
              });
              Navigator.pop(context);
            },
            items: ['A Wing', 'B Wing', 'C Wing'].map((wing) {
              return DropdownMenuItem<String>(
                value: wing,
                child: Text(wing),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void addUser() {
    // Navigate to the AddUserScreen when button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddUserScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Users"),
        backgroundColor: Color(0xFF41C1BA),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: RoleBasedNavbar(role: 'admin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onChanged: filterUsers,
                    decoration: InputDecoration(
                      hintText: "Search users...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: showFilterDialog,
                  icon: Icon(Icons.filter_list),
                  label: Text("Filter"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF41C1BA),
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFF41C1BA),
                        child: Text(
                          filteredUsers[index][0], // Display first letter
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      title: Text(
                        filteredUsers[index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF256765),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            users.remove(filteredUsers[index]);
                            filteredUsers.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton.icon(
                onPressed: addUser, // This will navigate to AddUserScreen
                icon: Icon(Icons.add),
                label: Text("Add User"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41C1BA),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}