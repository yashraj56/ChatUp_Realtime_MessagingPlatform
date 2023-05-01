import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs{
  // Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;
  // Accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}