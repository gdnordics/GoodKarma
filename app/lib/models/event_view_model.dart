import 'package:good_karma_app/models/event.dart';

class EventViewModel {
  final Event event;

  final bool isBookmarked;
  final bool hasJoined;
  final bool applied;
  final bool accepted;

  const EventViewModel({
    required this.event,
    required this.isBookmarked,
    required this.hasJoined,
    required this.applied,
    required this.accepted,
  });
}
