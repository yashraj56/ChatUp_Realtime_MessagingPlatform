// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
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
  String? _image;

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
                      _image != null
                          // local image
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(_image!),
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                            )
                          // server image
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                                imageUrl: widget.user.image,
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: CircleAvatar(
                                      child: Icon(CupertinoIcons.home)),
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
                          onPressed: () {
                            _showBottomSheet();
                          },
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

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 20),
            children: [
              //pick profile picture label
              const Text('Pick Profile Picture',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),

              //for adding some space
              const SizedBox(height: 50),

              //buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //pick from gallery button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: const Size(150, 75)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery, imageQuality: 80);
                        if (image != null) {
                          setState(() {
                            _image = image.path;
                          });
                          APIs.updateProfilePicture(File(_image!));
                          // For hiding bottom sheet
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('Assets/Images/add_image.png')),

                  //take picture from camera button
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          fixedSize: const Size(150, 75)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image
                        final XFile? image = await picker.pickImage(
                            source: ImageSource.camera, imageQuality: 80);
                        if (image != null) {
                          setState(() {
                            _image = image.path;
                          });
                          APIs.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.asset('Assets/Images/camera.png')),
                ],
              )
            ],
          );
        });
  }
}
