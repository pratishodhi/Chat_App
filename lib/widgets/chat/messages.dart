import 'package:chat_app/widgets/chat/message_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('chat')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              final chatDoc = chatSnapshot.data.documents;

              return ListView.builder(
                reverse: true,
                itemCount: chatDoc.length,
                itemBuilder: (ctx, index) => MessageBackground(
                  chatDoc[index]['text'],
                  chatDoc[index]['userId'] == futureSnapshot.data.uid,
                  chatDoc[index]['username'],
                  chatDoc[index]['userImage'],
                  key: ValueKey(chatDoc[index].documentID),
                ),
              );
            });
      },
    );
  }
}
