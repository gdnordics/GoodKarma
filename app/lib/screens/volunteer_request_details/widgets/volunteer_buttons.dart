import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/approve_button.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/reject_button.dart';
import 'package:good_karma_app/screens/volunteer_request_details/widgets/undo_button.dart';

class VolunteerButtons extends StatelessWidget {
  final String requestStatus;
  final VoidCallback onReject;
  final VoidCallback onAccept;
  final VoidCallback onUndo;

  const VolunteerButtons({
    Key? key,
    required this.requestStatus,
    required this.onReject,
    required this.onAccept,
    required this.onUndo
  }): super(key:key);

  @override
  Widget build(BuildContext context) {
    if (requestStatus == RequestToAttend.requestPendingResponse) {
      return Container(
        height: 110.0,
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          ApproveButton(onPressed: onAccept),
          SizedBox(width: 50),
          RejectButton(onPressed: onReject)
        ]));
    }

    if (requestStatus == RequestToAttend.requestAccepted) {
      return Container(
        height: 150.0,
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            "Accepted to volunteer",
            style: normalTextStyle.copyWith(
              fontSize: 24.0,
              color: approvedEventColor
            ),),
          SizedBox(width: 10),
          UndoButton(onPressed: onUndo)
        ]));
    }

    if (requestStatus == RequestToAttend.requestDenied) {
      return Container(
        height: 150.0,
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            "Reject to volunteer",
            style: normalTextStyle.copyWith(
              fontSize: 24.0,
              color: cancelRequestToAttendColor
            ),
          ),
          SizedBox(height: 10),
          UndoButton(onPressed: onUndo)
        ]));
    }

    return Container(
        height: 110.0,
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text("Request Cancelled"));
  }
}