import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/event_question_answer.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/screens/volunteer_request_details/models/event_request_question.dart';

class EventRequestDetails {
  final String eventId;
  final String eventName;
  final List<EventRequestQuestion> questions;
  final String requestStatus;

  const EventRequestDetails({
    required this.eventId,
    required this.eventName,
    required this.questions,
    required this.requestStatus
  });

  factory EventRequestDetails.createRequestDetails(Event event, EventQuestions questions, RequestToAttend request) {
    List<EventRequestQuestion> requestQuestions = [];
    for (var q in questions.questions) {
      requestQuestions.add(EventRequestQuestion(
        id: q.id, 
        query: q.query!, 
        answer: request.answers.firstWhere((e) => e.questionId == q.id, 
          orElse: () => EventQuestionAnswer(questionId: q.id, answer: null)).
          answer));
    }

    return EventRequestDetails(
      eventId: event.id!, 
      eventName: event.title!,
      questions: requestQuestions,
      requestStatus: request.status);
  }
}