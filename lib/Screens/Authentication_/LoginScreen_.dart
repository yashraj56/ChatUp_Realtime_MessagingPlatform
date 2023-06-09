import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minorproject/API/_Apis.dart';
import 'package:minorproject/Helper/Dialogs_.dart';
import 'package:minorproject/Screens/HomeScreen_.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// SubClass
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Google Authentication
    // ignore: no_leading_underscores_for_local_identifiers
    Future<UserCredential?> _signInWithGoogle() async {
      try {
        //Wait and try to take errors
        await InternetAddress.lookup('Google.com');
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
        return await APIs.auth.signInWithCredential(credential);
      } catch (e) {
        // log('\n_signInWithGoogle: $e' as num);
        Dialogs.showSnackbar(context, 'Check Internet!, or Slow connectivity');
        return null;
      }
    }

    // handles google login button click
    // ignore: no_leading_underscores_for_local_identifiers
    _handleGoogleBtnClick() {
      // For showing progress bar
      Dialogs.showProgressBar(context);
      /*---------------------------------------*/
      _signInWithGoogle().then((user) async {
        // For hiding progress bar
        Navigator.pop(context);
        if (user != null) {
          /* If user is available */
          if ((await APIs.userExist())) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MyHomePage()));
          } else {
            /* If user is not available */
            await APIs.createUser().then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MyHomePage()));
            });
          }
        }
      });
    }

    return Scaffold(
      // Main Body
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 400),
                child:
                    const Image(image: AssetImage('Assets/Images/AppIcon.png')),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Image(
                    image: AssetImage('Assets/Images/Logo_Text.png')),
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
                child:
                    const Image(image: AssetImage('Assets/Images/3dot_.png')),
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
      ),
    );
  }
}
