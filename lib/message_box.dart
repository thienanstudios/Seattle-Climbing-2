import 'package:bouldering_app_testing1/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'posts2.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatMessageBox extends StatefulWidget {
//  final String postIds;
//  final String ownerId;
//  final String location;
//  final String description;
//  final String title;
//  final dynamic likes;
//
//  ChatMessageBox({
//    this.postIds,
//    this.ownerId,
//    this.location,
//    this.description,
//    this.title,
//    this.likes,
//  });
//
//  factory ChatMessageBox.fromDocument(DocumentSnapshot doc) {
//    return ChatMessageBox(
//      postIds: doc['postId'],
//      ownerId: doc['ownerId'],
//      location: doc['location'],
//      description: doc['description'],
//      title: doc['title'],
//      likes: doc['likes'],
//    );
//  }

  @override
  _ChatMessageBoxState createState() => _ChatMessageBoxState(
//    postIds: this.postIds,
//    ownerId: this.ownerId,
//    location: this.location,
//    description: this.description,
//    title: this.title,
  );
}

class _ChatMessageBoxState extends State<ChatMessageBox> {
//  final String postIds;
//  final String ownerId;
//  final String location;
//  final String description;
//  final String title;
//  int likeCount;
//  Map likes;
//  bool isLiked;
//
//  _ChatMessageBoxState({
//    this.postIds,
//    this.ownerId,
//    this.location,
//    this.description,
//    this.title,
//    this.likes,
//    this.likeCount,
//  });


  buildBox() {
//    return StreamBuilder(
//      stream: Firestore.instance
//          .collection('test messages')
//          .document('andy ha(name)') //currentUserId
//          .collection('who')
//          .document('john') //whoever you are talking to, not current user
//          .collection('messages')
//          .document('yNVy6fVc9EBCR5An8ct5')
//          .snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) {
//          return Container(
//            height: .01,
//          );
//        }
//        if (snapshot.data == null || snapshot.data.data == null) {
//          return Container(
//            height: .01,
//          );
//        }
        return Material(
          child: InkWell(
            onTap: () {
              print('not yet');
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
//                            snapshot.data["photo"],
                          imageUrl
                          ),
                          minRadius: 35,
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Anthony',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Text(
                          'Hey! you wanna climb today? !!!!!',
                          style: TextStyle(
                            color: Color(0xff8C68EC),
                            fontSize: 14,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                        ),
                        Text(
                          '11:00 AM',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
//      },
//    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildBox(),
      ],
    );
  }
}
