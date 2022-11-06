import 'package:good_karma_app/screens/volunteer_requests/models/volunteer_request.dart';

class VolunteerRequests {
  final List<VolunteerRequest> awaitingApproval;
  final List<VolunteerRequest> approved;
  final List<VolunteerRequest> rejected;

  const VolunteerRequests({
    required this.awaitingApproval,
    required this.approved,
    required this.rejected
  });

  bool isNotEmpty() {
    return awaitingApproval.isNotEmpty || approved.isNotEmpty || rejected.isNotEmpty;
  } 
}