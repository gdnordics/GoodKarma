import 'package:flutter/widgets.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/filter_model.dart';
import 'package:good_karma_app/services/constants.dart';

class SearchService {
  Future<Event> getEvent(String eventId) async {
    return await eventsRef.doc(eventId).get().then((doc) {
      return Event.fromDoc(doc);
    });
  }

  Future<List<Event>> searchEvents(String query, FilterModel filter) async {
    List<Event> events = [];

    final resp = await searchFunc.call(
        {
          'query': query,
          'locations': filter.locations.toList(),
          'volunteersMin': filter.volunteerRange.min,
          'volunteersMax': filter.volunteerRange.max,
          'durationMinutesMin': filter.durationRange.min * 60,
          'durationMinutesMax': filter.durationRange.max * 60,
        }
    );

    for (var map in resp.data) {
      var data = Map<String, dynamic>.from(map);
      var event = Event.fromMap(data);
      if (event.eventDateTime != null) {
        events.add(event);
      }
    }

    return events;
  }
}