import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? id;
  final String? name;
  final String? profileImageUrl, email, bio, token;
  final int attendedEvents;
  final bool acceptedEULA;
  // {} named parameters
  AppUser(
      {this.id,
      this.name,
      this.profileImageUrl,
      this.email,
      this.bio,
      this.token,
      required this.acceptedEULA,
      required this.attendedEvents});

  factory AppUser.fromDoc(DocumentSnapshot doc) {
    var data = (doc.data() as Map<String,dynamic>);
    return AppUser(
        id: doc.id,
        name: data['name'],
        profileImageUrl: data['profileImageUrl'],
        email: data['email'],
        bio: data['bio'],
        token: data['token'],
        attendedEvents: data.containsKey('attendedEvents') ? data['attendEvents'] : 0,
        acceptedEULA: data.containsKey('acceptedEULA') ? data['acceptedEULA'] : false
        );
  }
}
