import 'package:flutter/material.dart';
import 'user.dart';
import 'welcome_screen.dart';
import 'progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:uuid/uuid.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:firebase_storage/firebase_storage.dart';

class Upload extends StatefulWidget {
  final User currentUser;

  Upload({this.currentUser});

  @override
  _UploadState createState() => _UploadState();
}

String globalPostId;
String postId = Uuid().v4();

class _UploadState extends State<Upload> {
  bool isUploading = false;

  TextEditingController locationController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      Navigator.pop(context);
    }
  }

  createPostInFirestore({String title, String description, String location}) {
    postsRef.document(name).collection("userPosts").document(postId).setData({
      "postId": postId,
      "ownerId": name,
      "photo": googleSignIn.currentUser.photoUrl,
      "title": title,
      "description": description,
      "location": location,
      "timestamp": DateTime.now(), //timestamp
      "likes": {},
    });
  }

  createTimeLineInFirestore(
      {String title, String description, String location}) {
    timelineRef.document(postId).setData({
      "postId": postId,
      "ownerId": name,
      "photo": googleSignIn.currentUser.photoUrl,
      "title": title,
      "description": description,
      "location": location,
      "timestamp": DateTime.now(), //timestamp
    });
  }

  handleSubmit() {
    setState(() {
      isUploading = true;
    });
    //compress image
    // upload image

    if (titleController.text.length > 0) {
      createPostInFirestore(
        title: titleController.text,
        description: captionController.text,
        location: locationController.text,
      );
      createTimeLineInFirestore(
        title: titleController.text,
        description: captionController.text,
        location: locationController.text,
      );
      captionController.clear();
      titleController.clear();
      locationController.clear();

      Navigator.pop(context);
    }
    globalPostId = postId;

    setState(() {
      isUploading = false;
      postId = Uuid().v4();
    });
  }

  getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    String formattedAddress =
        '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.locality}';
    locationController.text = formattedAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Text Post',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text(
              'POST',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          isUploading ? linearProgress() : Text(""),
          ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                imageUrl,
              ),
            ),
            title: Container(
              width: 250.0,
              child: Form(
                key: _formKey,
                autovalidate: true,
                child: TextFormField(
                  validator: (val) {
                    if (val.trim().length < 1) {
                      return 'Please enter a title';
                    } else if (val.length > 300) {
                      return 'Title too long';
                    } else {
                      return null;
                    }
                  },
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'An interesting title',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            title: Container(
              width: 250.0,
              height: 200.0,
              child: TextField(
                controller: captionController,
                decoration: InputDecoration(
                  hintText: 'Your text post',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.pin_drop,
              color: Colors.teal[300],
              size: 35.0,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'Where will we climb?',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('getting user location');
          getUserLocation();
        },
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
        elevation: 7.0,
      ),
    );
  }
}
