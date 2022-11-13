import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/event/edit_event_screen.dart';
import 'package:good_karma_app/screens/event_details/event_loading_screen.dart';
import 'package:good_karma_app/screens/event_details/models/event_details.dart';
import 'package:good_karma_app/screens/event_details/widgets/confirm_delete_dialog.dart';
import 'package:good_karma_app/screens/event_details/widgets/event_details_buttons.dart';
import 'package:good_karma_app/screens/event_details/widgets/event_details_date.dart';
import 'package:good_karma_app/screens/event_details/widgets/event_details_header.dart';
import 'package:good_karma_app/screens/event_details/widgets/event_details_list.dart';
import 'package:good_karma_app/screens/event_details/widgets/volunteer_action_button.dart';
import 'package:good_karma_app/screens/event_questions/event_questions_screen.dart';
import 'package:good_karma_app/screens/request_to_attend/request_to_attend_screen.dart';
import 'package:good_karma_app/screens/volunteer_requests/volunteers_screen.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  static const String id = 'event_details_screen';
  final String eventId;
  const EventDetailsScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool? wasPublished;
  bool? hasQuestions;
  String? requestStatus;

  Future<EventDetails> fetchEventDetails() async {
    var currentUserId = Provider.of<UserData>(context).currentUserId!;
    var ds = Provider.of<DatabaseService>(context, listen: false);
    Event event = await ds.getEvent(widget.eventId);
    bool isOwner = event.creatorUserId == currentUserId;
    bool publicEvent = (event.public ?? false);
    
    if (isOwner && publicEvent) {
      var pendingApprovals = await ds.getPendingApprovals(widget.eventId);
      return EventDetails.fromEvent(event, true, pendingApprovals: pendingApprovals);
    }

    /* Only fetch questions if not public event */
    EventQuestions questions = await ds.getEventQuestions(widget.eventId);
    if (isOwner) {
      return EventDetails.fromEvent(event, true, questions: questions);
    }
    
    RequestToAttend? request = await ds.getRequestToAttend(widget.eventId, currentUserId);
    return EventDetails.fromEvent(event, false, questions:questions, request: request);
  }

  @override
  void initState() {
    super.initState();
    wasPublished = null;
    hasQuestions = null;
    requestStatus = null;
  }

  void onGoBack(dynamic _) {
    setState(() {
      requestStatus = null;
    });
  }

  onBackwards() {
    Navigator.pop(context);
  }

  onBookmark() {
    debugPrint("Pressed to bookmark event");
  }

  onConfirmDelete() async {
    debugPrint("Confirm Delete of event");
    await Provider.of<DatabaseService>(context, listen: false)
        .deleteEvent(widget.eventId);
    Navigator.pop(context);
  }

  onDelete() {
    debugPrint("Pressed Delete event");
    showDialog(
        builder: (BuildContext ctx) {
          return ConfirmDeleteDialog(
              onCancel: () {}, onConfirm: onConfirmDelete);
        },
        context: context);
  }

  onEditEvent() {
    debugPrint("Pressed to edit event");
    Navigator.of(context).push(SlideRightRoute(
        page: EditEventScreen(eventId: widget.eventId)
    )).then(onGoBack);
  }

  onEditQuestion() {
    debugPrint("Pressed to edit questions");

    Navigator.of(context).push(SlideRightRoute(
      page: EventQuestionsScreen(eventId: widget.eventId)
    )).then(onGoBack);
  }

  onPublish() async {
    debugPrint("Pressed to publish event");
    await Provider.of<DatabaseService>(context, listen: false)
        .setPublicStatus(widget.eventId, true);
    setState(() {
      wasPublished =  true;
    });
  }

  onApproveRequests() {
    debugPrint("Pressed to approve requests");
    Navigator.of(context).push(SlideRightRoute(
      page: VolunteersScreen(eventId: widget.eventId)
    )).then(onGoBack);
  }

  onRequestToAttend(bool hasQuestions) async {
    debugPrint("Requesting to attend!");
    if (hasQuestions) {
      Navigator.of(context).push(SlideRightRoute(
        page: RequestToAttendScreen(eventId: widget.eventId)
      )).then(onGoBack);
    } else {
      debugPrint("Request to join directly, there are not questions!");
      var currentUserId = Provider.of<UserData>(context, listen: false).currentUserId!;
      var request = RequestToAttend(
        eventId: widget.eventId, 
        requesterId: currentUserId, 
        answers: List.empty(), 
        status: RequestToAttend.requestPendingResponse);
      await Provider.of<DatabaseService>(context, listen: false)
        .setRequestToAttend(request);
      setState(() {
        requestStatus = RequestToAttend.requestPendingResponse;
      });
    }
  }

  onCancelAttendence() async {
    debugPrint("Requesting Cancel Attendence");
    var currentUserId = Provider.of<UserData>(context, listen: false).currentUserId!;
    await Provider.of<DatabaseService>(context, listen: false)
        .updateRequestToAttendStatus(widget.eventId, currentUserId, RequestToAttend.requestCancelled);
    setState(() {
        requestStatus = RequestToAttend.requestCancelled;
      });
  }

  Widget buildVolunteerAction(EventDetails event, bool hasQuestions) {
    if (event.isOwner && !event.hasPassed()) {
      if (!event.public) {
        return Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: VolunteerActionButton(
                    text: hasQuestions ? "EDIT QUESTIONS" : "ADD QUESTIONS", 
                    onPressed: onEditQuestion,
                    color: addQuestionsColor,
                  )); 
      } else if (event.pendingApprovals > 0) {
        return Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: VolunteerActionButton(
                    text: "APPROVE", 
                    onPressed: onApproveRequests,
                    color: primaryLightGreenColor,
                  ));
      } else {
        return Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: VolunteerActionButton(
                    text: "MANAGE", 
                    onPressed: onApproveRequests,
                    color: primaryLightGreenColor,
                  ));
      }
    }
    return SizedBox(width: 40);
  }

  Widget buildEventDetailsButtons(EventDetails event, bool hasQuestions) {
    bool public = wasPublished ?? event.public;

    if (event.hasPassed()) {
      return SizedBox(height: 30);
    } else {
      return EventDetailsButtons(
                onEditEvent: onEditEvent,
                onEditQuestions: onEditQuestion,
                onPublish: onPublish,
                onRequestToAttend: onRequestToAttend,
                onCancelAttendence: onCancelAttendence,
                isHost: event.isOwner,
                isPublic: public,
                hasQuestions: hasQuestions,
                requestStatus: requestStatus ?? event.requestStatus,
              );
  }

  }

  Widget buildBannerImage(String? imageUrl) {
    if (imageUrl == null) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 148);
    }
    return Image.network(
                      imageUrl,
                      errorBuilder: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                      height: 148.0,
                    );
  }

  Widget buildEventDetails(EventDetails event) {
    debugPrint("Event: ${event.title}, public: ${event.public}");
    bool questionsExist = hasQuestions ?? event.hasQuestions;

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBannerImage(event.imageUrl),
                    Container(
                        padding: const EdgeInsets.only(
                            left: 18.0, top: 20.0, right: 10.0),
                        child: Text(event.title!,
                            style: boldTextStyle.copyWith(fontSize: 35.0)))
                  ],
                ),
                Positioned(
                    right: 25,
                    top: 80.0,
                    child:
                        EventDetailsDate(eventDateTime: event.eventDateTime!)),
              ],
            ),
            Container(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(event.description!, style: normalTextStyle)),
            SizedBox(height: 20.0),
            EventDetailsList(
              location: event.location!,
              eventDuration: event.eventDuration,
              creatorName: event.creatorName,
              volunteersNeeded: event.volunteersNeeded,
              karmaPoints: 5,
              volunteerAction: buildVolunteerAction(event, questionsExist),
              pendingApprovals: event.pendingApprovals,
            ),
            SizedBox(height: 30.0),
            buildEventDetailsButtons(event, questionsExist),
            SizedBox(height: 30.0)
          ],
        ),
      ),
    );
  }

  Widget buildScaffolding(EventDetails event) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: EventDetailsHeader(
              onBackward: onBackwards,
              onDelete: onDelete,
              enableDelete: event.isOwner && !event.hasPassed(),
            )),
        body:  buildEventDetails(event));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<EventDetails>(
          future: fetchEventDetails(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return buildScaffolding(snapshot.data!);
            }
            return EventLoadingScreen();
          })),
    );
  }
}
