import 'package:flutter/material.dart';
import 'package:bouldering_app_testing1/welcome_screen.dart';
//import 'package:bouldering_app_testing1/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'progress.dart';

import 'package:bouldering_app_testing1/posts2.dart';

class Profile extends StatefulWidget {
  final String profileId;

  Profile({this.profileId});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String currentUserId = currentUser?.ownerId;
  bool isLoading = false;
  int postCount = 0;
  List<Posts2> posts = [];

  @override
  void initState() {
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    QuerySnapshot snapshoot = await postsRef
        .document(name)
        .collection("userPosts")
        .orderBy('timestamp', descending: true)
        .getDocuments();

    setState(() {
      posts =
          snapshoot.documents.map((doc) => Posts2.fromDocument(doc)).toList();
    });
  }

  buildProfileHead() {
    return FutureBuilder(
      future: usersRef.document(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(imageUrl),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        );
      },
    );
  }

  buildProfilePosts() {
//    if (isLoading) {
//      return circularProgress();
//    }
    return Column(
      children: posts,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: RefreshIndicator(
        child: ListView(
          children: <Widget>[
            buildProfileHead(),
            buildProfilePosts(),
          ],
        ),
        onRefresh: () => getProfilePosts(),
      ),
    );
  }
}


