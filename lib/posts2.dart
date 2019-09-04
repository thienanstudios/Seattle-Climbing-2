import 'package:flutter/material.dart';
import 'welcome_screen.dart';
//import 'test.dart';
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
//        if (snapshot.hasData && (snapshot.data != null)) { // over here
//          print('=== data ===: ${snapshot.data.data}');
//        }
        if (!snapshot.hasData) {
//          print(
//            "!snapshot.hasData ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
//          );
          return circularProgress();
        }
//        print('=== data ===: ${snapshot.data.data}');

        if (snapshot.data == null || snapshot.data.data == null) {
          return Container(
            height: .01,
          );
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
            top: 3.0,
            bottom: 3.0,
            left: 3.0,
            right: 3.0,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 150.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
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
                        snapshot.data["timestamp"]
                                .toDate()
                                .toString()
                                .substring(11, 16) +
                            "   " +
                            snapshot.data["timestamp"]
                                .toDate()
                                .toString()
                                .substring(0, 11),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 5.0,
                              bottom: 12.0,
                            ),
                            child: SizedBox(
                              child: Text(
                                snapshot.data["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                              right: 16.0,
                              top: 5.0,
                              bottom: 12.0,
                            ),
                            child: SizedBox(
                              child: Text(
                                snapshot.data["description"],
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 40.0,
                            left: 16.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            bottom: 20.0,
                            top: 10.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              showComments(
                                context,
                                postId: postIds,
                                ownerId: ownerId,
                                imageUrl: imageUrl,
                              );
                            },
                            child: Icon(
                              Icons.message,
                              size: 20.0,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            bottom: 20.0,
                            top: 10.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              print('make new message thingy');
                            },
                            child: Icon(
                              Icons.mail_outline,
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
