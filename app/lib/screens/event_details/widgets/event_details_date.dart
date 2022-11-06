import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';

class EventDetailsDate extends StatelessWidget {
  final DateTime eventDateTime;

  const EventDetailsDate({Key? key, required this.eventDateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          color: primaryLightGreenColor,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
              height: 85.0,
              width: 85.0,
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(DateFormat.MMMM().format(eventDateTime),
                        style: normalTextStyle.copyWith(
                            color: kLoginButtonTextColor, fontSize: 12.0)),
                    Text(DateFormat.d().format(eventDateTime),
                        style: boldTextStyle.copyWith(
                            color: kLoginButtonTextColor, fontSize: 36.0)),
                    Text(DateFormat.y().format(eventDateTime),
                        style: normalTextStyle.copyWith(
                            color: kLoginButtonTextColor, fontSize: 12.0)),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}
