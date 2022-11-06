import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/screens/volunteer_request_details/models/event_request_details.dart';
import 'package:good_karma_app/screens/volunteer_request_details/models/volunteer_request_details.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/confirm_reject_dialog.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/volunteer_buttons.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/volunteer_details.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:provider/provider.dart';
import 'volunteer_request_details_loading.dart';


class VolunteerRequestDetailsScreen extends StatefulWidget {
  static const String id = 'volunteer_request_details_screen';
  final String eventId;
  final String requesterId;

  const VolunteerRequestDetailsScreen({
    Key? key,
    required this.eventId,
    required this.requesterId,
  }) 
  : super(key: key);

  @override
  _VolunteerRequestDetailsScreenState createState() => _VolunteerRequestDetailsScreenState();
}

class _VolunteerRequestDetailsScreenState extends State<VolunteerRequestDetailsScreen> {
  
  Future<VolunteerRequestDetails> fetchVolunteerRequestDetails() async {
    var ds = Provider.of<DatabaseService>(context, listen: false);
    var user = await ds.getUser(widget.requesterId);
    var event = await ds.getEvent(widget.eventId);
    var questions = await ds.getEventQuestions(widget.eventId);
    var request = await ds.getRequestToAttend(widget.eventId, widget.requesterId);
    return VolunteerRequestDetails(
      user: user,
      details: EventRequestDetails.createRequestDetails(event, questions, request!)
    );
  }

  onBackwards() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: BackAppBar.createAppBar(onBackwards),
          body: 
          Container(
            height: MediaQuery.of(context).size.height,
            child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Volunteer Request",
                  style: boldTextStyle.copyWith(
                      fontSize: 24.0))
              ),
              SizedBox(height: 10.0),
              Expanded(child:
              FutureBuilder<VolunteerRequestDetails>(
                future: fetchVolunteerRequestDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!;
                    return VolunteerDetails(
                      user: data.user, 
                      details: data.details);
                  }
                  //shimmer here
                  return const VolunteerRequestScreen();
                }
              ))
          ]),
      ))
    );
  }
}