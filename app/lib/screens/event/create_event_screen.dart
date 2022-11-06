import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:good_karma_app/screens/event/widgets/event_form.dart';
import 'package:good_karma_app/screens/event_details/event_details_screen.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String id = 'create_event_screen';
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBackwards() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      appBar: BackAppBar.createAppBar(onBackwards),
      body: EventForm(onSave: onSave, title: "Create a new Event")
    ));
  }

  Future<void> onSave(Event event) async {
    var eventId = await Provider.of<DatabaseService>(context, listen: false).addEvent(event);
    Navigator.of(context).pushReplacement(SlideRightRoute(
      page: EventDetailsScreen(
        eventId: eventId
      )
    ));
  }
}
