//splash screen
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minorproject/API/_Apis.dart';
import 'package:minorproject/Screens/Authentication_/LoginScreen_.dart';
import 'package:minorproject/Screens/HomeScreen_.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    /* Pre Calling (initstate) while running SplashScreen class */
    Future.delayed(const Duration(milliseconds: 1500), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));
      /* Wait and check conditions */
      if (APIs.auth.currentUser != null) {
        /* User already exist (=!null) */
        // Navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MyHomePage()));
      } else {
        /* New user (APIs.auth.currentUser==null) */
        // Navigate to login screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    var mq = MediaQuery.of(context).size;

    return Scaffold(
        //body
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 450),
              child: const Image(
                image: AssetImage('Assets/Images/AppIcon.png'),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Image(
                    image: AssetImage('Assets/Images/Logo_Text.png'))),
            Container(
                width: 300,
                margin: const EdgeInsets.only(top: 420),
                child: const Image(
                    image: AssetImage('Assets/Images/Base_Text.png'))),
            Container(
                width: 110,
                margin: const EdgeInsets.only(top: 10),
                child: const Image(
                    image: AssetImage('Assets/Images/Base_Icons.png'))),
          ],
        ),
      ),
    ));
  }
}
