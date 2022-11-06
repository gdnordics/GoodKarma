import 'package:cloud_firestore/cloud_firestore.dart';

class UserEvents {
  final String? id, eventId, userId;
  final bool? accepted;
  final DateTime? acceptedDateTime;

  UserEvents({
    this.id,
    this.eventId,
    this.userId,
    this.accepted,
    this.acceptedDateTime,
  });
  factory UserEvents.fromDoc(DocumentSnapshot doc) {
    return UserEvents(
      id: doc.id,
      userId: doc['userId'],
      eventId: doc['eventId'],
      accepted: doc['accepted'],
      acceptedDateTime: (doc['acceptedDateTime'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'accepted': accepted,
      'acceptedDateTime': acceptedDateTime,
    };
  }
}
