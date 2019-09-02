import 'package:flutter/material.dart';
import 'feed_page.dart';
import 'user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';


String name;
String email;
String imageUrl;

final usersRef = Firestore.instance.collection('users');
final postsRef = Firestore.instance.collection('posts');
final commentsRef = Firestore.instance.collection('comments');
final timelineRef = Firestore.instance.collection('timeline');

final DateTime timestamp = DateTime.now();
User currentUser;
final StorageReference storageRef = FirebaseStorage.instance.ref();
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

class WelcomeScreen extends StatefulWidget {
  static const String idP = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation animation;


  createUserInFireStore() async {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    usersRef.document(user.id).setData({
      "ownerId": user.displayName,
      "photo": user.photoUrl,
      "email": user.email,
      "bio": "",
      "userId": user.id,
    });

    doc = await usersRef.document(user.id).get();

    currentUser = User.fromDocument(doc);
  }

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn(); // over here
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);

    createUserInFireStore();

    name = user.displayName;
    email = user.email;
    imageUrl = user.photoUrl;

    return user;
  }



  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    //animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = ColorTween(begin: Colors.blueAccent, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });


  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: .84,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/images/welcome_screen.png',
                    ),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'mtn_logo',
                  child: CircleAvatar(
                    backgroundColor: Colors.yellowAccent[400],
                    radius: 50.0,
                    child: Icon(
                      Icons.landscape,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  'Seattle Climbing',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 350.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonTheme(
                    minWidth: 300.0,
                    height: 40.0,
                    child: RaisedButton(
                      elevation: 10.0,
                      color: Colors.lightBlueAccent,
                      splashColor: Colors.blueAccent,
                      child: Text(
                        'Sign In with Google',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'Nunito'),
                      ),
                      onPressed: () {
//                        Navigator.pushNamed(context, FeedPage.id);

                        _handleSignIn()
                            .then((FirebaseUser user) => Navigator.pushNamed(context, FeedPage.id))
                            .catchError((e) => print(e));

                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
