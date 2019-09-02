import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bouldering_app_testing1/welcome_screen.dart';
import 'package:bouldering_app_testing1/feed_page.dart';


void main() {
  Firestore.instance.settings(timestampsInSnapshotsEnabled: true).then((_) {
    print("Timestamps enabled in snapshots\n");
  }, onError: (_){
    print('Error enabling timestamps in snapshots\n');
  });
  runApp(BoulderApp());
}

class BoulderApp extends StatefulWidget {
  @override
  _BoulderAppState createState() => _BoulderAppState();
}

class _BoulderAppState extends State<BoulderApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.idP,
      routes: {
        WelcomeScreen.idP:(context) => WelcomeScreen(),
        FeedPage.id:(context) => FeedPage(),
      },
    );
  }
}
