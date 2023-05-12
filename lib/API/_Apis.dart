import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minorproject/Models/Chat_user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class APIs {
  // Getter method (To get user details)
  static User get user => auth.currentUser!;

  // Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Accessing cloud firebase Storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // For checking if user exist or not?
  static Future<bool> userExist() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // For storing self user info
  static late ChatUser me;

// For getting current user info
  static Future<void> getSelfinfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .get()
        .then((user) async => {
              if (user.exists)
                {me = ChatUser.fromJson(user.data()!)}
              else
                {await createUser().then((value) => getSelfinfo())}
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

// Update profile picture
  static Future<void> updateProfilePicture(File file) async {
    // Getting image file extension
    final ext = file.path.split('.').last;
    // Storage file reference with path
    final ref = storage.ref().child('profile_pictures/${user.uid}.$ext');
    // Uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {});
    // Updating image in firestore storage
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.name});
  }

// ********** User messages related APIs **********
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages() {
    return firestore.collection('messages').snapshots();
  }
}
