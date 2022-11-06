import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkedEvent {
  final String? id, eventId;
  final DateTime? createdDateTime;

  BookmarkedEvent({
    this.id,
    this.eventId,
    this.createdDateTime,
  });
  factory BookmarkedEvent.fromDoc(DocumentSnapshot doc) {
    return BookmarkedEvent(
      id: doc.id,
      eventId: doc['eventId'],
      createdDateTime: (doc['createdDateTime'] as Timestamp).toDate(),
    );
  }
  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'eventId': eventId,
      'createdDateTime': createdDateTime,
    };
  }
}
