import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '/widgets/common/role_based_navbar.dart';
import '/services/database_service.dart';

class AddGuestScreen extends StatefulWidget {
  @override
  _AddGuestScreenState createState() => _AddGuestScreenState();
}

class _AddGuestScreenState extends State<AddGuestScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final numberOfGuestsController = TextEditingController();
  final numberOfDaysController = TextEditingController();
  final dateController = TextEditingController();

  String? guestType;
  String? qrData;

  final List<String> guestTypes = ['Servant', 'Relatives or Friends', 'Service Man'];
  final String encryptionKey = "SecuraEntry@2025";

  String encryptData(String plainText) {
    final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, '0'));
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64Encode(iv.bytes) + ":" + encrypted.base64;
  }

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

  void generateQrCode() async {
    if (_formKey.currentState!.validate()) {
      String data =
          'Name: ${nameController.text}\n'
          'Mobile: ${mobileController.text}\n'
          'Email: ${emailController.text}\n'
          'Guests: ${numberOfGuestsController.text}\n'
          'Days: ${numberOfDaysController.text}\n'
          'Date: ${dateController.text}\n'
          'Type: ${guestType ?? "Not Selected"}';

      String encrypted = encryptData(data);

      // ✅ Save to Firestore
      await DatabaseService().saveGuestInfo(
        name: nameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        numberOfGuests: numberOfGuestsController.text,
        numberOfDays: numberOfDaysController.text,
        date: dateController.text,
        guestType: guestType ?? "Not Selected",
        encryptedQrData: encrypted,
      );

      setState(() {
        qrData = encrypted;
      });

      await Future.delayed(Duration(milliseconds: 300));
      shareQrOnWhatsApp();
    }
  }

  Future<void> shareQrCode() async {
    if (qrData == null) return;

    try {
      final directory = await getTemporaryDirectory();
      final imagePath = '${directory.path}/qr_code.png';

      final qrImage = await QrPainter(
        data: qrData!,
        version: QrVersions.auto,
        gapless: false,
      ).toImageData(200);

      if (qrImage != null) {
        final buffer = qrImage.buffer.asUint8List();
        final file = File(imagePath);
        await file.writeAsBytes(buffer);

        await Share.shareXFiles([XFile(imagePath)], text: 'Scan this QR Code');
      }
    } catch (e) {
      print("Error sharing QR Code: $e");
    }
  }

  Future<void> shareQrOnWhatsApp() async {
    if (qrData == null) return;
    String message = "Scan this QR Code: $qrData";
    String url = "https://wa.me/?text=${Uri.encodeComponent(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not launch WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Guest'),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
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
              buildTextField(mobileController, 'Mobile Number',
                  type: TextInputType.phone, isNumeric: true),
              buildTextField(emailController, 'Email Address',
                  type: TextInputType.emailAddress),
              buildTextField(numberOfGuestsController, 'Number of Guests',
                  type: TextInputType.number, isNumeric: true),
              buildTextField(numberOfDaysController, 'Number of Days',
                  type: TextInputType.number, isNumeric: true),
              buildDatePicker(),
              buildDropdown(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: generateQrCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF41C1BA),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Generate QR Pass'),
              ),
              const SizedBox(height: 24),
              if (qrData != null)
                QrImageView(
                  data: qrData!,
                  version: QrVersions.auto,
                  size: 200.0,
                  backgroundColor: Colors.white,
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: shareQrCode,
                icon: Icon(Icons.share),
                label: Text('Share QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      TextEditingController controller,
      String label, {
        TextInputType type = TextInputType.text,
        bool isNumeric = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        inputFormatters: isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  Widget buildDatePicker() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
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
        validator: (value) => value == null || value.isEmpty ? 'Please select date' : null,
      ),
    );
  }

  Widget buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Type of Guest',
        border: OutlineInputBorder(),
      ),
      value: guestType,
      items: guestTypes.map((type) {
        return DropdownMenuItem(
          value: type,
          child: Text(type),
        );
      }).toList(),
      onChanged: (value) => setState(() => guestType = value),
      validator: (value) => value == null ? 'Please select a guest type' : null,
    );
  }
}
