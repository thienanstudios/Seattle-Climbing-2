import 'package:bouldering_app_testing1/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bouldering_app_testing1/message_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'progress.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageBox> boxs;


//  @override
//  void initState() {
//    super.initState();
//    getTimeline();
//  }

//  getTimeline() async {
//    QuerySnapshot snapshot =
//    await Firestore.instance.collection('test messages').document('andy ha(name)').collection('who').getDocuments();
//
//    List<ChatMessageBox> boxs =
//    snapshot.documents.map((doc) => ChatMessageBox.fromDocument(doc)).toList();
//    setState(() {
//      this.boxs = boxs;
//    });
//  }

  buildChatBoxes() {
    if (boxs == null) {
      return circularProgress();
    } else if (boxs.isEmpty) {
      return Center(
        child: Text(
          'No posts :(',
        ),
      );
    } else {
      return ListView(
        children: <Widget>[
          Column(
            children: boxs,
          )
        ],
      );
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          header(),
//          buildChatBoxes(),
          ChatMessageBox(),

        ],
      ),
    );
  }
}

header() {
  return Container(
    margin: EdgeInsets.only(top: 10, bottom: 10),
    child: Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
          child: Row(
            children: <Widget>[
              Text(
                'Messages',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 15,
          width: 30,
          height: 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 1],
                colors: [
                  Color(0xFF8C68EC),
                  Color(0xFF3E8DF3),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -16,
          right: 10,
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 15),
            child: Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    print('create group');
                  },
                  child: Text(
                    'create group',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
