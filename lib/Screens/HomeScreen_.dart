// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minorproject/API/_Apis.dart';
import 'package:minorproject/Constants/Colors_.dart';
import 'package:minorproject/Models/Chat_user.dart';
import 'package:minorproject/ProfileScreen_.dart';
import 'package:minorproject/Widgets/Chat_user_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

FirebaseAuth auth = FirebaseAuth.instance;

Future _signOut() async {
  await FirebaseAuth.instance.signOut();
}

// Storage Information
// For storing all users
List<ChatUser> list = [];

// For storing searched users
final List<ChatUser> _searchList = [];

// For storing search status
bool _isSearching = false;

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.getSelfinfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      //for hiding keyboard when a tap is detected on screen
      child: WillPopScope(
          //if search is on & back button is pressed then close search
          //or else simple close current screen on back button click
          onWillPop: () {
            if (_isSearching) {
              setState(() {
                _isSearching = !_isSearching;
              });
              return Future.value(false);
            } else {
              return Future.value(true);
            }
          },
          child: Scaffold(
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
                physics: const ScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Row(
                        children: [
                          const Text(
                            "Inbox",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              iconSize: 50,
                              color: Colors.black,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProfileScreen(
                                              user: APIs.me,
                                            )));
                              },
                              icon: const Icon(Icons.settings_suggest_rounded,
                                  size: 35))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 30.0),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        height: 55.0,
                        child: TextField(
                          onTap: () {
                            setState(() {
                              _isSearching = true;
                            });
                          },
                          onChanged: (val) {
                            _searchList.clear();
                            for (var i in list) {
                              if (i.name
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  i.email
                                      .toLowerCase()
                                      .contains(val.toLowerCase())) {
                                _searchList.add(i);
                                setState(() {
                                  _searchList;
                                });
                              }
                            }
                          },
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: StreamBuilder(
                        stream: APIs.getAllusers(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            //if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return const Center(
                                  child: CircularProgressIndicator());

                            //if some or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;

                              list = data
                                      ?.map((e) => ChatUser.fromJson(e.data()))
                                      .toList() ??
                                  [];

                              if (list.isNotEmpty) {
                                return ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _isSearching
                                        ? _searchList.length
                                        : list.length,
                                    itemBuilder: (context, index) {
                                      return ChatUserCard(
                                          user: _isSearching
                                              ? _searchList[index]
                                              : list[index]);
                                    });
                              } else {
                                return const Center(
                                    child: Text('No Connection found'));
                              }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
