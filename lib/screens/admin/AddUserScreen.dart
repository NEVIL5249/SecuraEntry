import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/services/auth_service.dart'; // Update path if needed

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _mobileNoController = TextEditingController();
  final TextEditingController _alternateMobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedWing;
  String? _selectedFlatNo;

  final List<String> _wings = ['A', 'B', 'C'];
  final List<String> _flatNos = ['101', '102', '201', '202'];

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> _addUser() async {
    String ownerName = _ownerNameController.text.trim();
    String mobileNo = _mobileNoController.text.trim();
    String alternateMobile = _alternateMobileController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (ownerName.isEmpty ||
        mobileNo.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        _selectedWing == null ||
        _selectedFlatNo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    String? result = await _authService.addResidentUser(
      ownerName: ownerName,
      wing: _selectedWing!,
      flatNo: _selectedFlatNo!,
      mobileNo: mobileNo,
      alternateMobile: alternateMobile,
      email: email,
      password: password,
    );

    if (result == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User added successfully!")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $result")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Resident"),
        backgroundColor: Color(0xFF41C1BA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Resident Information:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              TextField(
                controller: _ownerNameController,
                decoration: InputDecoration(labelText: "Owner Name", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _selectedWing,
                decoration: InputDecoration(labelText: "Wing", border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWing = newValue;
                  });
                },
                items: _wings.map((wing) => DropdownMenuItem(value: wing, child: Text(wing))).toList(),
              ),
              SizedBox(height: 10),

              DropdownButtonFormField<String>(
                value: _selectedFlatNo,
                decoration: InputDecoration(labelText: "Flat No.", border: OutlineInputBorder()),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFlatNo = newValue;
                  });
                },
                items: _flatNos.map((flatNo) => DropdownMenuItem(value: flatNo, child: Text(flatNo))).toList(),
              ),
              SizedBox(height: 10),

              TextField(
                controller: _mobileNoController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Mobile No.", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              TextField(
                controller: _alternateMobileController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Alternate Mobile No.", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: _addUser,
                  child: Text("Add User"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF41C1BA),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
