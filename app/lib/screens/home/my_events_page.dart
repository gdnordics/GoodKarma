import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/screens/event_details/event_details_screen.dart';
import 'package:good_karma_app/screens/home/widgets/my_events_attending.dart';
import 'package:good_karma_app/screens/home/widgets/my_events_past.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:good_karma_app/widgets/appbar/search_app_bar.dart';

import 'widgets/my_events_organizing.dart';

class MyEventsPage extends StatefulWidget {
  final Function(dynamic) onGoBack;
  final VoidCallback onSearchPressed;
  const MyEventsPage({
    Key? key, 
    required this.onGoBack,
    required this.onSearchPressed,
    }) : super(key: key);

  @override
  _MyEventsPageState createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: 3,
      vsync: this,
    );
  }

  void onEventPressed(String eventId) {
    Navigator.of(context)
        .push(SlideRightRoute(
            page: EventDetailsScreen(
          eventId: eventId,
        )))
        .then(widget.onGoBack);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchAppBar(
              onSearch: widget.onSearchPressed,
            ),
        Expanded(
            child: Column(
              children: [
                TabBar(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  controller: _controller,
                  labelColor: primaryLightGreenColor,
                  unselectedLabelColor: primaryDarkGreenColor,
                  indicatorColor: Colors.transparent,
                  labelStyle: boldTextStyle.copyWith(
                    fontSize: 18.0
                  ),
                  unselectedLabelStyle: boldTextStyle.copyWith(
                    fontSize: 18.0
                  ),
                  tabs: const [  
                    Tab(text: 'Attending', height: 62.0,),
                    Tab(text: 'Organizing', height: 62.0,),
                    Tab(text: 'Past', height: 62.0),
                  ]
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      MyEventsAttending(onEventPressed: onEventPressed),
                      MyEventsOrganizing(onEventPressed: onEventPressed),
                      MyEventsPast(onEventPressed: onEventPressed),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
