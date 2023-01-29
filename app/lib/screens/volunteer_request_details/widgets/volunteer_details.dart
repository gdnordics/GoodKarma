import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/screens/volunteer_request_details/models/event_request_details.dart';
import 'package:good_karma_app/screens/volunteer_request_details/models/event_request_question.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/confirm_reject_dialog.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/volunteer_buttons.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:provider/provider.dart';

class VolunteerDetails extends StatefulWidget {
  final AppUser user;
  final EventRequestDetails details;

  const VolunteerDetails({
    Key? key, 
    required this.user, 
    required this.details,
  }) : super(key: key);

  @override
  _VolunteerDetailsState createState() => _VolunteerDetailsState();
}

class _VolunteerDetailsState extends State<VolunteerDetails> {
  String? newRequestStatus;

  onConfirmReject(String? message) async {
    debugPrint("Rejecting with message: $message");

    var db = Provider.of<DatabaseService>(context, listen: false);
    await db.rejectRequestToAttendStatus(
      widget.details.eventId, 
      widget.user.id!, 
      message);

    setState(() {
      newRequestStatus = RequestToAttend.requestDenied;
    });
  }

  onReject() {
    debugPrint("Reject user");

    showDialog(
      builder: (BuildContext ctx) {
        return ConfirmRejectDialog(
            onCancel: () {}, 
            onConfirm: onConfirmReject, 
            volunteerName: widget.user.name!
        );
      },
      context: context);
  }

  onAccept() async {
    debugPrint("Approve user");
    var db = Provider.of<DatabaseService>(context, listen: false);
    await db.updateRequestToAttendStatus(
      widget.details.eventId, 
      widget.user.id!, 
      RequestToAttend.requestAccepted);

    setState(() {
      newRequestStatus = RequestToAttend.requestAccepted;
    });
  }
  
  onUndo() async {
    debugPrint("Undo user");
    var db = Provider.of<DatabaseService>(context, listen: false);
    await db.updateRequestToAttendStatus(
      widget.details.eventId, 
      widget.user.id!, 
      RequestToAttend.requestPendingResponse);

    setState(() {
      newRequestStatus = RequestToAttend.requestPendingResponse;
    });
  }

  Widget buildUserProfile() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(48.0)),
                child: SizedBox.fromSize(
                    size: Size(96.0, 96.0),
                    child: Image.asset(
                      "assets/icon.png",
                      fit: BoxFit.cover,
                    ))),
            SizedBox(width: 30.0),
            Container(
                alignment: Alignment.topLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.user.name!,
                          style: normalTextStyle.copyWith(fontSize: 24.0))
                    ]))
          ],
        ));
  }

  Widget buildQuestionAnwser(int index, EventRequestQuestion question) {
    var boxShadow = BoxShadow(
        color: shadowColor,
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 1));
    return Container(
        width: 340.0,
        margin: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(
              color: shadowBorderColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [boxShadow]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${index + 1}. ${question.query}",
              style: boldTextStyle.copyWith(fontSize: 16.0)),
          SizedBox(height: 10.0),
          Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text("${question.answer}",
                  style: normalTextStyle.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: answerTextColor)))
        ]));
  }

  Widget buildAnswersAndQuestions() {
    List<Widget> answers = [];
    int i = 0;
    for (var q in widget.details.questions) {
      answers.add(buildQuestionAnwser(i, q));
      i++;
    }

    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(left: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("${widget.details.eventName} form answers",
            style: boldTextStyle.copyWith(fontSize: 20.0)),
        SizedBox(height: 10.0),
        Column(mainAxisAlignment: MainAxisAlignment.start, children: answers),
        SizedBox(height: 10.0)
      ]),
    );
  } 

  @override
  Widget build(BuildContext context) {
    String requestStatus = newRequestStatus ?? widget.details.requestStatus;
    return Column(
      children: [
      Expanded(child:
      ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(children: [
                SizedBox(height: 20.0),
                buildUserProfile(),
                SizedBox(height: 20.0),
                buildAnswersAndQuestions()
              ])))),
      VolunteerButtons(
            requestStatus: requestStatus,
            onReject: onReject,
            onAccept: onAccept,
            onUndo: onUndo,
      ),
    ]);
  }
}
