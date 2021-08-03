import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBackground extends StatelessWidget {
  MessageBackground(this.message, this.isMe, this.username, this.userImage,
      {this.key});
  final String message;
  final bool isMe;
  final String userImage;
  final Key key;
  final String username;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                    isMe ? Colors.blueGrey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    topRight: Radius.circular(13),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(13),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(13)),
              ),
              width: 160,
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: isMe ? Colors.deepPurple : Colors.black,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.black : Colors.white,
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 140,
          right: isMe ? 140 : null,
          child: CircleAvatar(
            backgroundImage:  NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
