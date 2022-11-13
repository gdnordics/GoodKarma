import 'package:flutter/cupertino.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/widgets/event_list.dart';

class UpcomingEvents extends StatelessWidget {
  final Function(String) onEventPressed;
  final List<Event> events;

  const UpcomingEvents({
    Key? key,
    required this.onEventPressed,
    required this.events,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (events.isNotEmpty) {
      return EventList(events: events, onEventPressed: onEventPressed);
    }
    return Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.center,
            width: 300.0,
            child: Text(
            "Be the first to create a event",
            style: normalKarmaTextStyle.copyWith(
              fontSize: 24.0
            ),
            textAlign: TextAlign.center,
          ))
        ]));
  }
}
