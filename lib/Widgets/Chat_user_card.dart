import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minorproject/Constants/Colors_.dart';
import 'package:minorproject/Models/Chat_user.dart';

import '../Screens/ChatScreen_.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          color: ColorConstants.chatUserCardColor,
          margin: const EdgeInsets.only(left: 15, right: 15, top: 0),
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    // Navigating to blank screen
                    user: widget.user,
                  ),
                ),
              );
            },
            child: Center(
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    width: 55,
                    height: 55,
                    fit: BoxFit.fill,
                    imageUrl: widget.user.image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        minRadius: 22,
                        maxRadius: 22,
                        backgroundColor: Color.fromARGB(255, 226, 114, 96),
                        child: Icon(
                          CupertinoIcons.person_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  //Fetching data from database
                  widget.user.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: const Text(
                  'Last user message',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: const Text(
                  '12:30 PM',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
