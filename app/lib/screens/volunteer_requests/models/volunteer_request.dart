import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/request_to_attend.dart';

class VolunteerRequest {
  final AppUser user;
  final RequestToAttend request;

  const VolunteerRequest({
    required this.user,
    required this.request
  });
}