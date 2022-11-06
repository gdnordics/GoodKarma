import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/models/request_to_attend.dart';

class RequestToAttendFormData {
  final RequestToAttend? request;
  final EventQuestions questions;

  const RequestToAttendFormData({
    required this.request,
    required this.questions
  });
}