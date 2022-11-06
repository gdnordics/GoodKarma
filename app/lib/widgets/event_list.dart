import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/widgets/cards/event_list_item.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final Function(String) onEventPressed;


  const EventList({
    Key? key,
    required this.events,
    required this.onEventPressed,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return EventListItem(
            event: events[index],
            onEventPressed: onEventPressed,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 10.0),
      ),
      Positioned(child:
      Container(height: 0.0,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: backgroundColor,
            spreadRadius: 10.0,
            blurRadius: 6.0
          )
        ]
      )))
      ]);
  }
}