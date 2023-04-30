import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minorproject/API/_Apis.dart';
import 'package:minorproject/Constants/Colors_.dart';
import 'package:minorproject/Screens/Authentication_/LoginScreen_.dart';
import 'package:minorproject/Widgets/Chat_user_card.dart';
import 'package:minorproject/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;

Future _signOut() async {
  await FirebaseAuth.instance.signOut();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.mainAppColour,
        onPressed: () {
          _signOut();
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Row(
                  children: const [
                    Text(
                      "Inbox",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.settings_suggest_rounded,
                      size: 35,
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 55.0,
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search_outlined),
                      filled: true,
                      fillColor: Colors.grey[100],
                      // Change the background color here
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Looking for who?',
                    ),
                  ),
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return const ChatUserCard();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
