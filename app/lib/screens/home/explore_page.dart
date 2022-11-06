import 'package:flutter/cupertino.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/app_user.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/models/event_view_model.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/event_details/event_details_screen.dart';
import 'package:good_karma_app/widgets/events_loading.dart';
import 'package:good_karma_app/screens/home/widgets/upcoming_events.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/appbar/search_app_bar.dart';
import 'package:good_karma_app/widgets/events_loading.dart';
import 'package:provider/provider.dart';

class ExplorePage extends StatefulWidget {
  final Function(dynamic) onGoBack;
  final VoidCallback onSearchPressed;

  const ExplorePage({
    Key? key,
    required this.onGoBack,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onEventPressed(String eventId) {
    Navigator.of(context)
        .push(SlideRightRoute(
            page: EventDetailsScreen(
          eventId: eventId,
        )))
        .then(widget.onGoBack);
  }

  Future<List<Event>> getEvents() async {
    var ds = Provider.of<DatabaseService>(context, listen: false);
    return await ds.getUpcomingEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SearchAppBar(
        onSearch: widget.onSearchPressed,
      ),
      Expanded(
          child: Container(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 10.0),
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: Text("Upcoming Events",
                          style: boldTextStyle.copyWith(
                            fontSize: 20.0,
                          ))),
                  Expanded(
                      child: FutureBuilder(
                          future: getEvents(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List<Event> events = snapshot.data;
                              return UpcomingEvents(
                                  events: events,
                                  onEventPressed: onEventPressed);
                            } else {
                              return const EventsLoadingScreen();
                            }
                          }))
                ],
              )))
    ]);
  }
}
