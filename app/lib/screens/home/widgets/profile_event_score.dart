import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';

class ProfileEventScore extends StatelessWidget {
  final int eventsVolunteered;
  final int karmaPoints;
  final int eventsOrganized;

  const ProfileEventScore({
    Key? key,
    required this.eventsVolunteered,
    required this.karmaPoints,
    required this.eventsOrganized
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        alignment: Alignment.center,
        width: 76,
        height: 60,
        child: Column(children: [
          Text(
            eventsVolunteered.toString(),
            style:
                normalTextStyle.copyWith(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: Text(
              "Events Volunteered",
              style: normalTextStyle.copyWith(
                  fontSize: 14.0, color: Color(0xFF747688)),
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
      Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: VerticalDivider(thickness: 1.0, color: Color(0xFFDDDDDD))),
      Container(
        alignment: Alignment.center,
        width: 76,
        height: 60,
        child: Column(children: [
          Text(
            eventsOrganized.toString(),
            style:
                normalTextStyle.copyWith(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: Text(
              "Events Organized",
              style: normalTextStyle.copyWith(
                  fontSize: 14.0, color: Color(0xFF747688)),
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
      Container(
          height: 40,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: VerticalDivider(thickness: 1.0, color: Color(0xFFDDDDDD))),
          //This should be on the new row
      Container(
       alignment: Alignment.center,
       width: 76,
       height: 60,
        child: Column(children: [
          Text(
            karmaPoints.toString(),
            style:
                normalTextStyle.copyWith(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: Text(
              "Karma Points",
              style: normalTextStyle.copyWith(
                  fontSize: 14.0, color: Color(0xFF747688)),
              textAlign: TextAlign.center,
            ),
          )
        ]),
      ),
    ]);
  }
}