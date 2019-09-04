import 'package:flutter/material.dart';
import 'package:bouldering_app_testing1/welcome_screen.dart';
import 'package:bouldering_app_testing1/posts2.dart';
import 'progress.dart';
import 'user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Timeline extends StatefulWidget {
  final User currentUser;

  Timeline({this.currentUser});

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Posts2> posts;

  @override
  void initState() {
    super.initState();
    getTimeline();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .document('allPosts')
        .collection('allPosts')
        .orderBy('timestamp', descending: true)
        .getDocuments();

    setState(() {
      List<Posts2> posts =
          snapshot.documents.map((doc) => Posts2.fromDocument(doc)).toList();

      this.posts = posts;
    });
  }

  buildTimeline() {
    if (posts == null) {
      return circularProgress();
    } else
    if (posts.isEmpty) {
      return Text('no posts');
    } else {
      return ListView(
        children: <Widget>[
          Column(
            children: posts,
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: RefreshIndicator(
        child: buildTimeline(),
        onRefresh: () => getTimeline(),
      ),
    );
  }
}
