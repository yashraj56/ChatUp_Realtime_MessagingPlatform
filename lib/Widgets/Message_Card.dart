import 'package:flutter/material.dart';
import 'package:minorproject/API/_Apis.dart';
import 'package:minorproject/Models/Message.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message});

  final Message message;

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

// Sender message
  Widget _blueMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //message content
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 245, 255),
                  border: Border.all(color: Colors.lightBlue),
                  //making borders curved
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child:
                  //show text
                  Text(
                widget.message.msg,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              )),
        ),

        //message time
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                '${widget.message.sent} AM',
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),

      ],
    );
  }

// Account holder message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            // Double tick icon
            const Icon(Icons.done_all_rounded, color: Colors.blue, size: 20),
            // Adding some space
            const SizedBox(width: 5),
            //read time
            Text(
              '${widget.message.sent} AM',
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),

        //Message
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 218, 255, 176),
                  border: Border.all(color: Colors.lightGreen),
                  //making borders curved
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Text(
                widget.message.msg,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              )),
        ),
      ],
    );
  }
}
