import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'test.dart';
import 'package:bouldering_app_testing1/comments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'progress.dart';
//import 'package:bouldering_app_testing1/new_post.dart';

String title;
String caps;
String loca;

class Posts2 extends StatefulWidget {
  final String postIds;
  final String ownerId;
  final String location;
  final String description;
  final String title;
  final dynamic likes;

  Posts2({
    this.postIds,
    this.ownerId,
    this.location,
    this.description,
    this.title,
    this.likes,
  });

  factory Posts2.fromDocument(DocumentSnapshot doc) {
    return Posts2(
      postIds: doc['postId'],
      ownerId: doc['ownerId'],
      location: doc['location'],
      description: doc['description'],
      title: doc['title'],
      likes: doc['likes'],
    );
  }

//  int getLikeCount(likes) {
//    if (likes == null) {
//      return 0;
//    }
//    int count = 0;
//    likes.value.forEach((val) {
//      if (val) {
//        count++;
//      }
//    });
//    return count;
//  }

  @override
  _Posts2State createState() => _Posts2State(
        postIds: this.postIds,
        ownerId: this.ownerId,
        location: this.location,
        description: this.description,
        title: this.title,
//        likeCount: getLikeCount(likes),
      );
}

class _Posts2State extends State<Posts2> {
  final String currentUserId = currentUser?.ownerId;

  final String postIds;
  final String ownerId;
  final String location;
  final String description;
  final String title;
  int likeCount;
  Map likes;
  bool isLiked;

  _Posts2State({
    this.postIds,
    this.ownerId,
    this.location,
    this.description,
    this.title,
    this.likes,
    this.likeCount,
  });

  buildPost() {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('posts')
          .document(currentUserId)
          .collection('userPosts')
          .document(postIds)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }

//        postName = snapshot.data["ownerId"];
//        postTitle = snapshot.data["title"];
//        postCap = snapshot.data["description"];
//        postLoca = snapshot.data["location"];
//        postTime = snapshot.data["timestamp"];

//        var userDocument = snapshot.data;
//        postName = userDocument["ownerId"];
//        postTitle = userDocument["title"];
//        postCap = userDocument["description"];
//        postLoca = userDocument["location"];
//        postTime = userDocument["timestamp"];

        return Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            bottom: 4.0,
            left: 8.0,
            right: 8.0,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        snapshot.data["photo"],
                      ),
                      backgroundColor: Colors.grey,
                    ),
                    title: Text(
                      snapshot.data["ownerId"],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
//                      userDocument["location"],
                      snapshot.data["location"],
                    ),
                    trailing: Text(
                      postTime.toDate().toString().substring(11, 16) +
                          "   " +
                          postTime.toDate().toString().substring(0, 11),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 5.0,
                          bottom: 12.0,
                        ),
                        child: SizedBox(
                          child: Text(
//                            userDocument["title"],
                            snapshot.data["title"],

                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 3.0,
                          bottom: 5.0,
                        ),
                        child: SizedBox(
                          child: Text(
//                            userDocument["description"], // get description some how
                            snapshot.data["description"],
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 40.0, left: 16.0)),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            print('commnets nowwww');
                            showComments(
                              context,
                              postId: postIds,
                              ownerId: ownerId,
                              imageUrl: imageUrl,
                            );
                          },
                          child: Icon(
                            Icons.landscape,
                            size: 20.0,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
//    isLiked = (likes[name] == true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPost(),
      ],
    );
  }
}

showComments(BuildContext context,
    {String postId, String ownerId, String imageUrl}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return Comments(
      postId: postId,
      postOwnerId: ownerId,
      postMediaUrl: imageUrl,
    );
  }));
}