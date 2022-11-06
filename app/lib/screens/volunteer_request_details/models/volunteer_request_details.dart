import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/screens/volunteer_request_details/models/event_request_details.dart';

class VolunteerRequestDetails {
  final AppUser user;
  final EventRequestDetails details;

  const VolunteerRequestDetails({
    required this.user,
    required this.details
  });
}