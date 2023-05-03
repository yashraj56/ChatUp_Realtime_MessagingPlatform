import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minorproject/API/_Apis.dart';
import 'package:minorproject/Screens/Authentication_/LoginScreen_.dart';

import 'Constants/Colors_.dart';
import 'Helper/Dialogs_.dart';
import 'Models/Chat_user.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future _signOut() async {
  await FirebaseAuth.instance.signOut();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstants.mainAppColour,
        onPressed: () async {
          Dialogs.showProgressBar(context);
          await APIs.auth.signOut().then((value) async {
            await GoogleSignIn().signOut().then((value) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()));
            });
          });
        },
        icon: const Icon(Icons.add),
        label: const Text('Logout'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          width: 170,
                          height: 170,
                          fit: BoxFit.fill,
                          imageUrl: widget.user.image,
                          // placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                                child: Icon(CupertinoIcons.person_alt)),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: MaterialButton(
                          color: Colors.white,
                          elevation: 1,
                          shape: const CircleBorder(),
                          onPressed: () {},
                          child: Icon(
                            Icons.edit,
                            color: ColorConstants.mainAppColour,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.user.email,
                  style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_2_outlined),
                      label: const Text('Name'),
                      hintText: 'eg. Happy Singh',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  initialValue: widget.user.about,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.info_outline),
                      label: const Text('About'),
                      hintText: 'Feeling Happy',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.mainAppColour,
                      shape: const StadiumBorder(),
                      minimumSize: const Size(200, 45)),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit,
                    size: 22,
                  ),
                  label: const Text(
                    'Update',
                    style: TextStyle(fontSize: 17),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
