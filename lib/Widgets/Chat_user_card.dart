import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minorproject/Constants/Colors_.dart';
import 'package:minorproject/main.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({Key? key}) : super(key: key);

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
            onTap: () {},
            child: const Center(
              child: ListTile(
                leading: Padding(
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
                title: Text(
                  'Demo user',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  'Last user message',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                trailing: Text(
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
