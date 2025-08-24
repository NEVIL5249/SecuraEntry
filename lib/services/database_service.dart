import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Add basic guest entry
  Future<void> addGuest(String name, String phone, String residentId) async {
    await _firestore.collection('guests').add({
      'name': name,
      'phone': phone,
      'residentId': residentId,
      'timestamp': DateTime.now(),
    });
  }

  // Save full guest info with optional photo and encrypted QR data
  Future<void> saveGuestInfo({
    required String name,
    required String mobile,
    required String email,
    required String numberOfGuests,
    required String numberOfDays,
    required String date,
    required String guestType,
    required String encryptedQrData,
    File? visitorPhoto,
  }) async {
    try {
      String? photoUrl;

      if (visitorPhoto != null) {
        final photoId = Uuid().v4();
        final ref = _storage.ref().child('visitor_photos/$photoId.jpg');
        await ref.putFile(visitorPhoto);
        photoUrl = await ref.getDownloadURL();
      }

      await _firestore.collection('guest_passes').add({
        'name': name,
        'mobile': mobile,
        'email': email,
        'numberOfGuests': numberOfGuests,
        'numberOfDays': numberOfDays,
        'date': date,
        'guestType': guestType,
        'encryptedQrData': encryptedQrData,
        'photoUrl': photoUrl ?? '',
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('❌ Error saving guest info: $e');
      rethrow;
    }
  }

  // Save bulk guest pass
  Future<void> saveBulkGuestPass({
    required String wing,
    required String flatNo,
    required int noOfGuests,
    required int noOfDays,
    required String eventDetails,
    required DateTime date,
    required String qrData,
  }) async {
    try {
      await _firestore.collection('bulk_guest_passes').add({
        'wing': wing,
        'flatNo': flatNo,
        'noOfGuests': noOfGuests,
        'noOfDays': noOfDays,
        'eventDetails': eventDetails,
        'arrivalDate': date,
        'qrData': qrData,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Error saving bulk guest pass: $e");
      rethrow;
    }
  }

  // Save manual guest entry by guard
  Future<void> saveManualGuestEntry({
    required String guestName,
    required String mobile,
    required String purpose,
    required String wing,
    required String flatNo,
    required String entryBy, // Guard name or ID
  }) async {
    try {
      await _firestore.collection('manual_guest_entries').add({
        'guestName': guestName,
        'mobile': mobile,
        'purpose': purpose,
        'wing': wing,
        'flatNo': flatNo,
        'entryBy': entryBy,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("❌ Error saving manual guest entry: $e");
      rethrow;
    }
  }

  // Fetch Guest Logs
  Stream<QuerySnapshot> getGuestLogs() {
    return _firestore
        .collection('guest_passes')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
