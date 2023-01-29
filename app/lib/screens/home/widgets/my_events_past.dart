import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/widgets/event_list.dart';
import 'package:good_karma_app/widgets/events_loading.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:provider/provider.dart';

class MyEventsPast extends StatelessWidget {
  final Function(String) onEventPressed;
  const MyEventsPast({Key? key, required this.onEventPressed}) : super(key: key);

  Future<List<Event>> getPast(BuildContext context) async {
    var currentUserId = Provider.of<UserData>(context, listen: false).currentUserId!;
    var ds = Provider.of<DatabaseService>(context, listen: false);
    return await ds.getMyPastEvents(currentUserId);
  }

   Widget buildEvents(BuildContext context, List<Event> events) {
    if (events.isNotEmpty) {
      return EventList(events: events, onEventPressed: onEventPressed);
    }
    return Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            alignment: Alignment.center,
            width: 250.0,
            child: Text(
            "Looks like you haven't attended anything yet",
            style: normalPromptTextStyle,
            textAlign: TextAlign.center,
          ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: FutureBuilder(
            future: getPast(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Event> events = snapshot.data;
                return buildEvents(context, events);
              } else {
                return const EventsLoadingScreen();
              }
            }));
  }
}

