import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> getUserProfile() async {
    String userId = _auth.currentUser!.uid;
    DocumentSnapshot<Map<String, dynamic>> snapshot = 
        await _firestore.collection('Profiles').doc(userId).get();
    
    if (snapshot.exists) {
      return snapshot.data();
    } else {
      return null;
    }
  }
}
