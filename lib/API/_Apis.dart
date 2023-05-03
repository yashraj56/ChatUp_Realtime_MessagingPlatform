import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorproject/Models/Chat_user.dart';

class APIs {
  // Getter method
  static User get user => auth.currentUser!;

  // Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

// For checking if user exist or not?
  static Future<bool> userExist() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // For storing self user info
  static late ChatUser me;

// For getting current user info
  static Future<void> getSelfinfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async => {
          if (user.exists) {me = ChatUser.fromJson(user.data()!)} else {
            await createUser().then((value) => getSelfinfo())
          }
        });
  }

// For creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        id: user.uid,
        name: user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey, I'm using ChatUp",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllusers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
}
