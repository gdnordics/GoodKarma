import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/screens/request_to_attend/models/request_to_attend_form_data.dart';
import 'package:good_karma_app/screens/request_to_attend/widgets/request_to_attend_form.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:provider/provider.dart';
import 'request_to_attend_loading_screen.dart';

class RequestToAttendScreen extends StatefulWidget {
  static const String id = 'request_to_attend_screen';
  final String eventId;

  const RequestToAttendScreen({
    Key? key,
    required this.eventId
  }) 
  : super(key: key);

  @override
  _RequestToAttendScreenState createState() => _RequestToAttendScreenState();
}

class _RequestToAttendScreenState extends State<RequestToAttendScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<RequestToAttendFormData> fetchData() async {
    var ds = Provider.of<DatabaseService>(context, listen: false);
    var userId = Provider.of<UserData>(context, listen: false).currentUserId!;
    var questions = await ds.getEventQuestions(widget.eventId);
    var request = await ds.getRequestToAttend(widget.eventId, userId);
    return RequestToAttendFormData(request: request, questions: questions);
  }

  onNext(RequestToAttend request) {
    debugPrint("Request to join event: ${request.eventId}");
    Provider.of<DatabaseService>(context, listen: false).setRequestToAttend(request);
    Navigator.pop(context);
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
          body: FutureBuilder<RequestToAttendFormData>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RequestToAttendForm(
              onNext: onNext, 
              eventQuestions: snapshot.data!.questions, 
              oldRequest: snapshot.data!.request);
          }
          //shimmer here
          return const RequestAttendLoadingScreen();
        }
      )
      ),
    );
  }
}