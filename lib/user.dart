import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String ownerId;
  final String email;
  final String photo;
  final String bio;

  User({
    this.ownerId,
    this.email,
    this.photo,
    this.bio,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      ownerId: doc['ownerId'],
      email: doc['email'],
      photo: doc['photo'],
      bio: doc['bio'],
    );
  }
}