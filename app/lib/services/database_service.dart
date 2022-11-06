import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/services/constants.dart';

class DatabaseService {
  Future<AppUser> getUser(String userId) async {
    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    return AppUser.fromDoc(userDoc);
  }

  Future<List<AppUser>> getUsers(List<String> includeUsers) async {
     QuerySnapshot userSnapshot = await usersRef.get();
     List<AppUser> users = [];
     for (var doc in userSnapshot.docs) {
       AppUser user = AppUser.fromDoc(doc);
       if (includeUsers.contains(user.id)) {
         users.add(user);
       }
     }
     return users;
  }

  Future<void> setAcceptedEULA(String userId) async {
    await usersRef.doc(userId).set({"acceptedEULA": true}, SetOptions(merge: true));
  }

  Future<Event> getEvent(String eventId) async {
    return await eventsRef.doc(eventId).get().then((doc) {
      return Event.fromDoc(doc);
    });
  }

  Future<String> addEvent(Event event) async {
    var id = eventsRef.doc().id;
    var doc = event.toDoc();
    doc["id"] = id;
    await eventsRef.doc(id).set(doc);
    return id;
  }

  void updateEvent(Event event) async {
    await eventsRef.doc(event.id).set(event.toDoc());
  }

  Future<void> deleteEvent(String eventId) async {
    await eventsRef.doc(eventId).delete();
  }

  Future<void> setPublicStatus(String eventId, bool public) async {
    await eventsRef.doc(eventId).set({"public": public}, SetOptions(merge: true));
  }
  
  Future<EventQuestions> getEventQuestions(String id) async {
    var doc = await eventQuestionsRef.doc(id).get();

    if (doc.exists) {
      return EventQuestions.fromDoc(doc);
    }
    return EventQuestions(id: id, questions: List.empty(growable: true));
  }

  Future<void> setEventQuestions(EventQuestions questions) async {
    await eventQuestionsRef.doc(questions.id).set(questions.toDoc());
  }

  Future<RequestToAttend?> getRequestToAttend(String eventId, String userId) async {
    var doc = await requestsToAttendRef.doc(RequestToAttend.getId(eventId, userId)).get();
    if (doc.exists) {
      return RequestToAttend.fromDoc(doc);
    }
    return null;
  }

  Future<List<RequestToAttend>> getPendingApprovals(String eventId) async {
    List<RequestToAttend> requests = [];
    QuerySnapshot requestsSnapshot =
        await requestsToAttendRef
          .where("eventId", isEqualTo: eventId)
          .where("status", isEqualTo: RequestToAttend.requestPendingResponse).get();

    for (var doc in requestsSnapshot.docs) {
      // ignore: avoid_print
      requests.add(RequestToAttend.fromDoc(doc));
    }

    return requests;
  }

  Future<List<RequestToAttend>> getRequestsToAttend(String eventId) async {
    List<RequestToAttend> requests = [];
    QuerySnapshot requestsSnapshot =
        await requestsToAttendRef
          .where("eventId", isEqualTo: eventId)
          .where("status", whereIn: [
            RequestToAttend.requestPendingResponse,
            RequestToAttend.requestAccepted,
            RequestToAttend.requestDenied
          ]).get();

    for (var doc in requestsSnapshot.docs) {
      // ignore: avoid_print
      requests.add(RequestToAttend.fromDoc(doc));
    }

    return requests;
  }

  Future<void> updateRequestToAttendStatus(String eventId, String userId, String status) async {
    await requestsToAttendRef.doc(RequestToAttend.getId(eventId, userId))
      .set({'status': status}, SetOptions(merge: true));
  }

  Future<void> rejectRequestToAttendStatus(String eventId, String userId, String? message) async {
    await requestsToAttendRef.doc(RequestToAttend.getId(eventId, userId))
      .set({'status': RequestToAttend.requestDenied, 'rejectMsg': message}, SetOptions(merge: true));
  }

  Future<void> setRequestToAttend(RequestToAttend request) async {
    await requestsToAttendRef.doc(request.id).set(request.toDoc());
  }

  Future<List<Event>> getUpcomingEvents() async {
    var now = DateTime.now();
    List<Event> events = [];
    QuerySnapshot eventsSnapshot =
        await eventsRef
        .where("public", isEqualTo: true)
        .where('eventDateTime', isGreaterThan: now)
        .orderBy('eventDateTime', descending: true).get();

    for (var doc in eventsSnapshot.docs) {
      events.add(Event.fromDoc(doc));
    }

    return events;
  }

  Future<List<Event>> getMyOrganizedEvents(String creatorUserId) async {
    var now = DateTime.now();
    List<Event> userOrganizedEvents = [];
    QuerySnapshot eventsSnapshot = await eventsRef
        .where('creatorUserId', isEqualTo: creatorUserId)
        .where('eventDateTime', isGreaterThan: now)
        .orderBy('eventDateTime', descending: true)
        .get();

    for (var doc in eventsSnapshot.docs) {
      userOrganizedEvents.add(Event.fromDoc(doc));
    }

    return userOrganizedEvents;
  }

  Future<List<Event>> getMyAttendingEvents(String userId) async {
    var now = DateTime.now();
    List<Event> attendingEvents = [];
    QuerySnapshot requestsSnapshot = await requestsToAttendRef
          .where("requesterId", isEqualTo: userId)
          .where("status", whereIn: [
            RequestToAttend.requestPendingResponse,
            RequestToAttend.requestAccepted,
          ]).get();

    for (var doc in requestsSnapshot.docs) {
      var event = await getEvent(doc["eventId"]);
      if (event.eventDateTime != null && event.eventDateTime!.compareTo(now) > 0) {
        attendingEvents.add(event);
      }
    }

    attendingEvents.sort((e1, e2) => e1.eventDateTime!.compareTo(e2.eventDateTime!));
    return attendingEvents;
  }

  Future<List<Event>> getMyPastEvents(String userId) async {
    var now = DateTime.now();
    List<Event> pastEvents = [];
    QuerySnapshot requestsSnapshot = await requestsToAttendRef
          .where("requesterId", isEqualTo: userId)
          .where("status", whereIn: [
            RequestToAttend.requestPendingResponse,
            RequestToAttend.requestAccepted,
          ]).get();

    for (var doc in requestsSnapshot.docs) {
      var event = await getEvent(doc["eventId"]);
      if (event.eventDateTime != null && event.eventDateTime!.compareTo(now) < 0) {
        pastEvents.add(event);
      }
    }

    QuerySnapshot eventsSnapshot = await eventsRef
        .where('creatorUserId', isEqualTo: userId)
        .where('eventDateTime', isLessThan: now)
        .orderBy('eventDateTime', descending: true)
        .get();
      
    for (var doc in eventsSnapshot.docs) {
      var event = Event.fromDoc(doc);
      if (event.eventDateTime != null) {
        pastEvents.add(event);
      }
    }

    pastEvents.sort((e1, e2) => e1.eventDateTime!.compareTo(e2.eventDateTime!));
    return pastEvents;
  }
}
