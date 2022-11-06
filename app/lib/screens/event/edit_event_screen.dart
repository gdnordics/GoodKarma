import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/event.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:good_karma_app/screens/event/widgets/event_form.dart';
import 'package:good_karma_app/screens/event_details/event_details_screen.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/utils/slide_route.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  static const String id = 'edit_event_screen';
  final String eventId;
  const EditEventScreen({Key? key, required this.eventId}) : super(key: key);
  

  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<Event> fetchEvent() async {
    return await Provider.of<DatabaseService>(context, listen: false)
        .getEvent(widget.eventId);
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
          body: FutureBuilder<Event>(
            future: fetchEvent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return EventForm(onSave: onSave, title: "Edit Event", originalEvent: snapshot.data);
              }
              return const CircularProgressIndicator();
            }
          )
      ),
    );
  }


  Future<void> onSave(Event event) async {
      Provider.of<DatabaseService>(context, listen: false).updateEvent(event);
      Navigator.of(context).pop();
  }
}
