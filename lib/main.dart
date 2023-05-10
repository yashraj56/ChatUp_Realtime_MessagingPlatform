import 'package:flutter/material.dart';
import 'package:minorproject/Screens/Splash_.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late Size mq;

void main() {
/* Returns an instance of the WidgetsBinding, creating and initializing it if necessary.
If one is created, it will be a WidgetsFlutterBinding. If one was previously initialized,
then it will at least implement WidgetsBinding. */
  WidgetsFlutterBinding.ensureInitialized();
  /* Firebase initialization */
  _initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

/* Initialize firebase connection by main thread */
_initializeFirebase() async /* Making method asynchronous */ {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
