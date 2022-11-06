import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? id,
      title,
      location,
      description,
      imageUrl,
      eventCategory,
      creatorUserId,
      creatorName;
  final int? karmaPoints;
  final int? durationMinutes;
  final int? volunteersNeeded;
  final DateTime? eventDateTime;
  final DateTime? endDateTime;
  final DateTime? createdDateTime;
  final bool? public;

  Event({
    this.id,
    this.title,
    this.location,
    this.description,
    this.imageUrl,
    this.eventCategory,
    this.karmaPoints,
    this.eventDateTime,
    this.endDateTime,
    this.volunteersNeeded,
    this.creatorUserId,
    this.creatorName,
    this.createdDateTime,
    this.durationMinutes,
    this.public,
  });
  factory Event.fromDoc(DocumentSnapshot doc) {
    var data = (doc.data() as Map<String, dynamic>);
    return Event(
      id: doc.id,
      title: data['title'],
      location: data['location'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      eventCategory: data['eventCategory'],
      karmaPoints: data['karmaPoints'],
      volunteersNeeded: data['volunteersNeeded'],
      eventDateTime: (data['eventDateTime'] as Timestamp).toDate(),
      endDateTime: (data['endDateTime'] as Timestamp).toDate(),
      creatorUserId: data['creatorUserId'],
      creatorName: data['creatorName'],
      createdDateTime: (data['createdDateTime'] as Timestamp).toDate(),
      durationMinutes: data['durationMinutes'],
      public: (data.containsKey('public') ? data['public'] : false)  as bool
    );
  }
  factory Event.fromMap(Map<String,dynamic> data) {
    return Event(
      id: data['id'],
      title: data['title'],
      location: data['location'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      eventCategory: data['eventCategory'],
      karmaPoints: data['karmaPoints'],
      volunteersNeeded: data['volunteersNeeded'],
      eventDateTime: DateTime.fromMillisecondsSinceEpoch(data['eventDateTime']),
      endDateTime: DateTime.fromMillisecondsSinceEpoch(data['endDateTime']),
      creatorUserId: data['creatorUserId'],
      creatorName: data['creatorName'],
      createdDateTime: DateTime.fromMillisecondsSinceEpoch(data['createdDateTime']),
      durationMinutes: data['durationMinutes'],
      public: data['public'] == "true"
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'eventCategory': eventCategory,
      'karmaPoints': karmaPoints,
      'volunteersNeeded': volunteersNeeded,
      'eventDateTime': eventDateTime,
      'endDateTime': endDateTime,
      'creatorUserId': creatorUserId,
      'creatorName': creatorName,
      'createdDateTime': createdDateTime,
      'durationMinutes': durationMinutes,
      'public': public
    };
  }
}
