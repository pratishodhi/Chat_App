import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STFU',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.deepPurpleAccent,
        backgroundColor: Colors.pink,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(buttonColor: Colors.pink, textTheme: ButtonTextTheme.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged, builder: (ctx, userSnapshot){
        if(userSnapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}