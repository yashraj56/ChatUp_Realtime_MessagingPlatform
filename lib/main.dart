import 'package:flutter/material.dart';
import 'package:minorproject/Screens/Authentication_/LoginScreen_.dart';
import 'package:minorproject/Screens/HomeScreen_.dart';
import 'package:minorproject/Screens/Splash_.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// yash gandu
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginScreen(),
    );
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}


