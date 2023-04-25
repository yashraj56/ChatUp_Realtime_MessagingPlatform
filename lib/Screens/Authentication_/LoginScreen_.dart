import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minorproject/Screens/HomeScreen_.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // handles google login button click
    // ignore: no_leading_underscores_for_local_identifiers
    _handleGoogleBtnClick() {
      _signInWithGoogle().then((user) {
        log('\nUser: ${user.user}' as num);
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}' as num);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MyHomePage()));
      });
    }
    return Scaffold(
      // Main Body
       body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 400),
              child:
              const Image(image: AssetImage('Assets/Images/AppIcon.png')),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child:
              const Image(image: AssetImage('Assets/Images/Logo_Text.png')),
            ),
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Column(
                children: const [
                  Text(
                    '“Designed with security in mind, using the latest',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'encryption technology to protect your ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'messages from prying eyes.”',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Image(image: AssetImage('Assets/Images/3dot_.png')),
            ),
            GestureDetector(
              onTap: () {
                _handleGoogleBtnClick();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                width: 350,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 55,
                      child: const Image(
                          image: AssetImage('Assets/Images/google.png')),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future<UserCredential> _signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
  await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
