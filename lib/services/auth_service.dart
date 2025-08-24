import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user (used in AuthProvider)
  Future<String?> registerUser(String email, String password, String name, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'role': role,
          'createdAt': Timestamp.now(),
        });
        return null; // success
      } else {
        return 'User creation failed';
      }
    } catch (e) {
      return e.toString(); // error message
    }
  }

  // Add resident user (used in AddUserScreen)
  Future<String?> addResidentUser({
    required String ownerName,
    required String wing,
    required String flatNo,
    required String mobileNo,
    String? alternateMobile,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'ownerName': ownerName,
          'wing': wing,
          'flatNo': flatNo,
          'mobileNo': mobileNo,
          'alternateMobile': alternateMobile ?? '',
          'email': email,
          'role': 'resident',
          'createdAt': Timestamp.now(),
        });
        return null; // success
      } else {
        return 'User creation failed';
      }
    } catch (e) {
      return e.toString(); // error message
    }
  }

  // Login user
  Future<String?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
