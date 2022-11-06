import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/screens/event_details/widgets/publish_button.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/buttons/edit_button.dart';

class EventDetailsButtons extends StatelessWidget {
  final VoidCallback onEditEvent;
  final VoidCallback onEditQuestions;
  final VoidCallback onPublish;
  final Function(bool) onRequestToAttend;
  final VoidCallback onCancelAttendence;
  final bool isHost;
  final bool isPublic;
  final bool hasQuestions;
  final String? requestStatus;

  const EventDetailsButtons(
      {Key? key,
      required this.onEditEvent,
      required this.onEditQuestions,
      required this.onPublish,
      required this.onRequestToAttend,
      required this.onCancelAttendence,
      required this.isHost,
      required this.isPublic,
      required this.hasQuestions,
      this.requestStatus})
      : super(key: key);

  onApplyPressed() {
    onRequestToAttend(hasQuestions);
  }

  Widget buildAttendyButton() {
    if (requestStatus == RequestToAttend.requestCancelled) {
      return ActionButton(
        width: 252,
        height: 58,
        text: "APPLY FOR VOLUNTEERING", onPressed: onApplyPressed);
    }

    if (requestStatus == RequestToAttend.requestPendingResponse) {
      return ActionButton(
        width: 252,
        height: 58,
        text: "CANCEL REQUEST", onPressed: onCancelAttendence, color: cancelRequestToAttendColor);
    }

    if (requestStatus == RequestToAttend.requestAccepted) {
      return ActionButton(
        width: 252,
        height: 58,
        text: "LEAVE VOLUNTEERING", onPressed: onCancelAttendence, color: cancelRequestToAttendColor);
    }

    return ActionButton(
      width: 252,
      height: 58,
      text: "APPLY FOR VOLUNTEERING", onPressed: onApplyPressed);
  }

  @override
  Widget build(BuildContext context) {
    if (isHost) {
      if (isPublic)  {
        return Container(
          alignment: Alignment.center,
          child: Column(children: [
          EditButton(
            text: "Edit Event",
            onPressed: onEditEvent,
          )
        ]));
      }

      return Container(
          alignment: Alignment.center,
          child: Column(children: [
        EditButton(
            text: "Edit Event",
            onPressed: onEditEvent,
        ),
        SizedBox(height: 20),
        PublishButton(onPressed: onPublish)
      ]));
    }

    return Container(
      alignment: Alignment.center,
      child: buildAttendyButton()
    );
  }
}
