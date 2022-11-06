import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/models/request_to_attend.dart';

class EventDetails {
  final String? id,
      title,
      location,
      description,
      imageUrl,
      eventCategory;
  final int karmaPoints;
  final String creatorUserId;
  final String creatorName;
  final int volunteersNeeded;
  final DateTime? eventDateTime;
  final DateTime? createdDateTime;
  final bool public;
  final bool isOwner;
  final bool hasQuestions;
  final String? requestStatus;
  final int pendingApprovals;
  final Duration eventDuration;

  EventDetails({
    this.id,
    this.title,
    this.location,
    this.description,
    this.imageUrl,
    this.eventCategory,
    required this.karmaPoints,
    this.eventDateTime,
    this.createdDateTime,
    required this.public,
    required this.isOwner,
    required this.hasQuestions,
    this.requestStatus,
    required this.creatorUserId,
    required this.creatorName,
    required this.volunteersNeeded,
    required this.pendingApprovals,
    required this.eventDuration,
  });
  factory EventDetails.fromEvent(Event event, bool isOwner, {EventQuestions? questions, RequestToAttend? request, List<RequestToAttend>? pendingApprovals}) {

    Duration eventDuration = Duration();
    if (event.durationMinutes != null) {
      int hours = (event.durationMinutes!/60).floor(); 
      int minutes = (event.durationMinutes! % 60);
      eventDuration = Duration(hours: hours, minutes: minutes);
    }

    return EventDetails(
      id: event.id,
      title: event.title,
      location: event.location,
      description: event.description,
      imageUrl: event.imageUrl,
      eventCategory: event.eventCategory,
      karmaPoints: event.karmaPoints ?? 0,
      volunteersNeeded: event.volunteersNeeded ?? 0,
      eventDateTime: event.eventDateTime,
      creatorUserId: event.creatorUserId!,
      creatorName: event.creatorName!,
      createdDateTime: event.createdDateTime,
      isOwner: isOwner,
      public: event.public ?? false,
      hasQuestions: questions?.questions.isNotEmpty ?? false ,
      requestStatus: request?.status,
      pendingApprovals: pendingApprovals?.length ?? 0,
      eventDuration: eventDuration
    );
  }

  bool hasPassed() {
    DateTime now = DateTime.now();
    return eventDateTime!.isBefore(now);
  }
}