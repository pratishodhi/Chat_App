import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/newMessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.configure(onMessage: (msg){
      print(msg);
      return;
    },
    onLaunch: (msg){
      print(msg);
      return;
    },
    onResume: (msg){
      print(msg);
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('STFU'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert_rounded,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(

                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app, color: Colors.deepPurple,),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout', style: TextStyle(color: Colors.deepPurple),),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ) /*StreamBuilder(
          stream: Firestore.instance
              .collection('chats/06arwfrv2f1PvlRJhQ4m/messages')
              .snapshots(),
          builder: (ctx, streamSnapshots) {
            if (streamSnapshots.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final documents = streamSnapshots.data.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8.0),
                child: Text(documents[index]['text']),
              ),
            );
          },
        )*/
        /*,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Firestore.instance
                .collection('chats/06arwfrv2f1PvlRJhQ4m/messages')
                .add({'text': 'so button was pressed'});
          },
        ),*/
      ),
    );
  }
}
