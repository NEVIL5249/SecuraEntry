
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
//import 'dart:convert';

class ScanQRScreen extends StatefulWidget {
  @override
  _ScanQRScreenState createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  String? scannedResult;
  final String encryptionKey = "SecuraEntry@2025";

  // String decryptQRCode(String encryptedText) {
  //   final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, ' '));
  //   final iv = encrypt.IV.fromLength(16); // Using a zeroed IV for simplicity
  //   final encrypter = encrypt.Encrypter(encrypt.AES(key));
  //
  //   try {
  //     final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
  //     return decrypted;
  //   } catch (e) {
  //     return "Decryption Failed";
  //   }
  // }
  String decryptQRCode(String encryptedText) {
    try {
      final key = encrypt.Key.fromUtf8(encryptionKey.padRight(32, '0')); // Ensure 32 bytes
      final parts = encryptedText.split(":"); // Extract IV and encrypted data
      if (parts.length != 2) return "Invalid Data";

      final iv = encrypt.IV.fromBase64(parts[0]);
      final encryptedData = parts[1];

      final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
      final decrypted = encrypter.decrypt64(encryptedData, iv: iv);

      return decrypted;
    } catch (e) {
      return "Decryption Failed: $e";
    }
  }
  void _onQRViewCreated(BarcodeCapture barcodeCapture) {
    final barcode = barcodeCapture.barcodes.first;
    if (barcode.rawValue != null) {
      setState(() {
        scannedResult = decryptQRCode(barcode.rawValue!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: MobileScanner(
              onDetect: (BarcodeCapture barcodeCapture) {
                _onQRViewCreated(barcodeCapture);
              },
            ),
          ),
          if (scannedResult != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Pass Details: $scannedResult',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
