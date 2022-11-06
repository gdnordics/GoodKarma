import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_karma_app/models/event_question_answer.dart';

class RequestToAttend {
  late String id;
  final String eventId;
  final String requesterId;
  final List<EventQuestionAnswer> answers;
  final String status;
  final String? rejectMessage;

  static String requestPendingResponse = "pending_response";
  static String requestAccepted = "accepted";
  static String requestDenied = "denied";
  static String requestCancelled = "cancelled";
  static String requestFinished = "finished";

  static String getId(String eventId, String requesterId) {
    return "${eventId}_$requesterId";
  }

  RequestToAttend({
    required this.eventId,
    required this.requesterId,
    required this.answers,
    required this.status,
    this.rejectMessage
  }) {
    id = RequestToAttend.getId(eventId, requesterId);
  }

  factory RequestToAttend.fromDoc(DocumentSnapshot doc) {
    var data = (doc.data() as Map<String, dynamic>);
    var answers = data.containsKey('answers') ?
      data['answers'].map((q) => EventQuestionAnswer.fromMap(q as Map<String, dynamic>)).toList() : 
      List.empty();
    var rejectMessage = data.containsKey('rejectMsg') ?
      data['rejectMsg'] :
      null;
    return RequestToAttend(
      eventId: data['eventId'],
      requesterId: data['requesterId'],
      answers: List<EventQuestionAnswer>.from(answers),
      status: data['status'],
      rejectMessage: rejectMessage
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'eventId': eventId,
      'requesterId': requesterId,
      'answers': answers.map((a) => a.toDoc()).toList(),
      'status': status,
      'rejectMsg': rejectMessage
    };
  }
}