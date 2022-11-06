import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/screens/volunteer_request_details/volunteer_request_details_screen.dart';
import 'package:good_karma_app/screens/volunteer_requests/models/volunteer_request.dart';
import 'package:good_karma_app/screens/volunteer_requests/models/volunteer_requests.dart';
import 'package:good_karma_app/screens/volunteer_requests/widgets/volunteers_list.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:provider/provider.dart';
import 'volunteer_list_loading_screen.dart';

class VolunteersScreen extends StatefulWidget {
  static const String id = 'volunteer_requests_screen';
  final String eventId;

  const VolunteersScreen({
    Key? key,
    required this.eventId
  }) 
  : super(key: key);

  @override
  _VolunteersScreenState createState() => _VolunteersScreenState();
}

class _VolunteersScreenState extends State<VolunteersScreen> {

  @override
  void initState() {
    super.initState();
  }

  Future<VolunteerRequests> fetchRequests() async {
    debugPrint("Fetching data");
    var ds = Provider.of<DatabaseService>(context, listen: false);
    var requests = await ds.getRequestsToAttend(widget.eventId);
    List<String> userIds = [];
    for (var r in requests) {
      userIds.add(r.requesterId);
    }
    var users = await ds.getUsers(userIds);
    return VolunteerRequests(
      awaitingApproval: requests.where((r) => r.status == RequestToAttend.requestPendingResponse)
        .map((r) => VolunteerRequest(
          user: users.firstWhere((u) => u.id == r.requesterId),
          request: r)).toList(), 
      approved: requests.where((r) => r.status == RequestToAttend.requestAccepted).map((r) => VolunteerRequest(
          user: users.firstWhere((u) => u.id == r.requesterId),
          request: r)).toList(),
      rejected: requests.where((r) => r.status == RequestToAttend.requestDenied).map((r) => VolunteerRequest(
          user: users.firstWhere((u) => u.id == r.requesterId),
          request: r)).toList()
      );
  }

  void onGoBack(dynamic _) {
    setState(() {
    });
  }

  onBackwards() {
    Navigator.pop(context);
  }

  onVolunteerPressed(String requesterId) {
    debugPrint("Pressed Volunteer Requester: $requesterId, for Event: ${widget.eventId}");
    Navigator.of(context).push(SlideRightRoute(
        page: VolunteerRequestDetailsScreen(eventId: widget.eventId, requesterId: requesterId)
    )).then(onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: BackAppBar.createAppBar(onBackwards),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Volunteers",
                  style: boldTextStyle.copyWith(
                      fontSize: 24.0))
              ),
              SizedBox(height: 20.0),
              FutureBuilder<VolunteerRequests> (
                future: fetchRequests(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return VolunteersList(
                      requests: snapshot.data!,
                      onVolunteerPressed: onVolunteerPressed);
                  }
                    return const VolunteerListLoadingScreen();
                }
              ),
          ])
      )
    );
  }
}
