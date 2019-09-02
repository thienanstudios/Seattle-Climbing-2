import 'package:flutter/material.dart';
import 'package:bouldering_app_testing1/welcome_screen.dart';
import 'package:bouldering_app_testing1/new_post.dart';
import 'package:bouldering_app_testing1/profile.dart';
//import 'package:bouldering_app_testing1/posts2.dart';
//import 'comments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'search_page.dart';
import 'package:bouldering_app_testing1/timeline.dart';
//import 'test.dart';

class FeedPage extends StatefulWidget {
  static const String id = 'feed_page';

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent[700],
          title: Center(
            child: Text(
              'Seattle Climbing',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              googleSignIn.signOut();
              Navigator.pushNamed(
                context,
                WelcomeScreen.idP,
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.mode_edit),
              color: Colors.white,
              onPressed: () {
                // post a new post
                //Upload(currentUser: currentUser);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Upload(
                          currentUser: currentUser,
                        ),
                  ),
                );
              },
            ),
          ],
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.email),
              ),
              Tab(
                icon: Icon(Icons.face),
              ),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          Timeline(currentUser: currentUser),
          Search(),
          Center(
            child: Text('messages'),
          ),
          Profile(
            profileId: currentUser?.ownerId,
          ),
        ]),
      ),
      length: 4,
    );
  }
}
