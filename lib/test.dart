import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'welcome_screen.dart';
//import 'new_post.dart';

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

String postName;
String postTitle;
String postCap;
String postLoca;
Timestamp postTime;



class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('posts')
          .document(name)
          .collection('userPosts')
          .document("d7f868d4-c400-4416-b60a-6c11749859de")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return new Text("Loading");
        }
        var userDocument = snapshot.data;
        postName = userDocument["ownerId"];
        postTitle = userDocument["title"];
        postCap = userDocument["description"];
        postLoca = userDocument["location"];
        postTime = userDocument["timestamp"];

        return Text("$postName, $postTitle, $postCap, $postLoca, $postTime");
      },
    );
  }
}
