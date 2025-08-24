import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/widgets/common/role_based_navbar.dart';
import '/services/database_service.dart';

class ManualEntry extends StatefulWidget {
  @override
  _ManualEntryState createState() => _ManualEntryState();
}

class _ManualEntryState extends State<ManualEntry> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberOfGuestsController = TextEditingController();
  final TextEditingController numberOfDaysController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? guestType;
  String? qrData;
  File? visitorPhoto;

  final List<String> guestTypes = [
    'Servant',
    'Relatives or Friends',
    'Service Man'
  ];

  final DatabaseService _dbService = DatabaseService();

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  Future<void> capturePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        visitorPhoto = File(image.path);
      });
    }
  }

  void generateQrCodeAndSave() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        qrData =
        'Name: ${nameController.text}\n'
            'Mobile: ${mobileController.text}\n'
            'Email: ${emailController.text}\n'
            'Guests: ${numberOfGuestsController.text}\n'
            'Days: ${numberOfDaysController.text}\n'
            'Date: ${dateController.text}\n'
            'Flat No.: ${flatNoController.text}\n'
            'Type: ${guestType ?? "Not Selected"}';
      });

      try {
        await _dbService.saveGuestInfo(
          name: nameController.text,
          mobile: mobileController.text,
          email: emailController.text,
          numberOfGuests: numberOfGuestsController.text,
          numberOfDays: numberOfDaysController.text,
          date: dateController.text,
          guestType: guestType ?? "Unknown",
          encryptedQrData: qrData!,
          visitorPhoto: visitorPhoto,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Guest info saved successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving guest info.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manually Add Guest'),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: RoleBasedNavbar(role: 'guard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextField(nameController, 'Name of Guest'),
              buildTextField(mobileController, 'Mobile Number', keyboardType: TextInputType.phone),
              buildTextField(flatNoController, 'Flat No.'),
              buildTextField(emailController, 'Email Address', keyboardType: TextInputType.emailAddress),
              buildTextField(numberOfGuestsController, 'Number of Guests', keyboardType: TextInputType.number),
              buildTextField(numberOfDaysController, 'Number of Days', keyboardType: TextInputType.number),
              SizedBox(height: 16),

              // Date Picker
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date of Arrival (DD-MM-YYYY)',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today, color: Color(0xFF41C1BA)),
                    onPressed: _pickDate,
                  ),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Select date' : null,
              ),
              SizedBox(height: 16),

              // Guest Type Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Type of Guest',
                  border: OutlineInputBorder(),
                ),
                value: guestType,
                items: guestTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) => setState(() => guestType = value),
                validator: (value) => value == null ? 'Select guest type' : null,
              ),
              SizedBox(height: 24),

              ElevatedButton(
                onPressed: capturePhoto,
                child: Text('Capture Visitor Photo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF41C1BA),
                  side: BorderSide(color: Color(0xFF41C1BA)),
                ),
              ),

              SizedBox(height: 10),

              if (visitorPhoto != null)
                Column(
                  children: [
                    Text('Captured Photo:'),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(visitorPhoto!, width: 200, height: 200, fit: BoxFit.cover),
                    ),
                  ],
                ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: generateQrCodeAndSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41C1BA),
                  foregroundColor: Colors.white,
                ),
                child: Text('Create Pass'),
              ),

              if (qrData != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: QrImageView(
                    data: qrData!,
                    version: QrVersions.auto,
                    size: 200.0,
                    backgroundColor: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
        keyboardType: keyboardType,
        validator: (value) => value == null || value.isEmpty ? 'Enter $label' : null,
      ),
    );
  }
}
