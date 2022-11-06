import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

NumberFormat formatter = NumberFormat("00");

class EventDetailsList extends StatelessWidget {
  final String location;
  final Duration eventDuration;
  final String creatorName;
  final int volunteersNeeded;
  final int karmaPoints;
  final Widget? volunteerAction;
  final int pendingApprovals;

  const EventDetailsList(
      {Key? key,
      required this.location,
      required this.eventDuration,
      required this.creatorName,
      required this.volunteersNeeded,
      required this.karmaPoints,
      required this.pendingApprovals,
      this.volunteerAction
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: Container(
                height: 48.0,
                width: 48.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: primayBackdropColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child:
                    Icon(Icons.location_pin, color: primaryLightGreenColor, size: 34)),
            title: Text(location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: mediumTextStyle)),
        ListTile(
          leading: Container(
              height: 48.0,
              width: 48.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: primayBackdropColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: const Icon(Icons.access_time,
                  color: primaryColor, size: 34)),
          title: Text(
              "${formatter.format(eventDuration.inHours.remainder(60))}:${formatter.format(eventDuration.inMinutes.remainder(60))}",
              style: boldTextStyle),
          subtitle: Text("Event Duration"),
        ),
        ListTile(
          leading: Container(
              height: 48.0,
              width: 48.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: primayBackdropColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: const Icon(Icons.person_outline_rounded,
                  color: primaryColor, size: 34)),
          title: Text(creatorName, style: boldTextStyle),
          subtitle: Text("Organiser"),
        ),
        ListTile(
          leading: Container(
              height: 48.0,
              width: 48.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: primayBackdropColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: const Icon(Icons.people_outline_rounded,
                  color: primaryLightGreenColor, size: 34)),
          title: Text(("$volunteersNeeded Volunteers Needed").toString(),
              style: boldTextStyle),
          subtitle: pendingApprovals > 0
              ? Text("$pendingApprovals Awaiting approval")
              : null,
          trailing: volunteerAction,
        ),
        ListTile(
          leading: Container(
              height: 48.0,
              width: 48.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: primayBackdropColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: const Icon(Icons.attach_money_rounded,
                  color: primaryLightGreenColor, size: 34)),
          title:
              Text('$karmaPoints  Karma Points reward', style: boldTextStyle),
        ),
      ],
    );
  }
}
