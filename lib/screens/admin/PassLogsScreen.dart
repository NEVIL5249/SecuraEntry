import 'package:flutter/material.dart';
import '/widgets/common/role_based_navbar.dart';

class PassLogsScreen extends StatefulWidget {
  @override
  _PassLogsScreenState createState() => _PassLogsScreenState();
}

class _PassLogsScreenState extends State<PassLogsScreen> {
  int _selectedIndex = 0; // 0 for Active Logs, 1 for Past Logs

  // Sample Data for Active Logs and Past Logs
  List<String> activeLogs = ["Active Log 1", "Active Log 2", "Active Log 3"];
  List<String> pastLogs = ["Past Log 1", "Past Log 2", "Past Log 3"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pass Logs"),
        centerTitle: true, // Center the title text
        backgroundColor: Color(0xFF41C1BA),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      // Adding RoleBasedNavbar in bottomNavigationBar
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: RoleBasedNavbar(role: 'admin'), // Add navbar here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Center the toggle buttons in the screen
            Center(
              child: ToggleButtons(
                isSelected: [ _selectedIndex == 0, _selectedIndex == 1 ],
                onPressed: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Active Logs", style: TextStyle(fontSize: 16)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text("Past Logs", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Display Logs based on selected toggle button
            Expanded(
              child: ListView.builder(
                itemCount: _selectedIndex == 0 ? activeLogs.length : pastLogs.length,
                itemBuilder: (context, index) {
                  // Use the appropriate list based on selected index
                  String log = _selectedIndex == 0 ? activeLogs[index] : pastLogs[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Icon(Icons.receipt),
                      title: Text(log),
                      subtitle: Text(
                        _selectedIndex == 0 ? "Active Pass" : "Past Pass",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit Button
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              // Add logic for Edit action
                              _editLog(index);
                            },
                          ),
                          // Delete Button
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Add logic for Delete action
                              _deleteLog(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Edit Log function
  void _editLog(int index) {
    // Here you can implement the logic for editing the log.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Log"),
          content: TextField(
            controller: TextEditingController(text: _selectedIndex == 0 ? activeLogs[index] : pastLogs[index]),
            decoration: InputDecoration(hintText: "Edit log entry"),
            onChanged: (value) {
              // Update the log entry here
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Logic to save the edited log entry
                setState(() {
                  if (_selectedIndex == 0) {
                    activeLogs[index] = "Edited Log: ${activeLogs[index]}"; // Update the active log
                  } else {
                    pastLogs[index] = "Edited Log: ${pastLogs[index]}"; // Update the past log
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // Delete Log function
  void _deleteLog(int index) {
    setState(() {
      if (_selectedIndex == 0) {
        activeLogs.removeAt(index); // Remove from active logs
      } else {
        pastLogs.removeAt(index); // Remove from past logs
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Log deleted")),
    );
  }
}