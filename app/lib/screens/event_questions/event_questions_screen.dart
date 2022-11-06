import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/screens/event_questions/widgets/event_questions_form.dart';
import 'package:good_karma_app/screens/event_questions/widgets/event_questions_preview_form.dart';
import 'package:good_karma_app/services/database_service.dart';
import 'package:good_karma_app/widgets/appbar/back_app_bar.dart';
import 'package:provider/provider.dart';

class EventQuestionsScreen extends StatefulWidget {
  static const String id = 'edit_questions_screen';
  final String eventId;

  const EventQuestionsScreen({
    Key? key,
    required this.eventId
  }) 
  : super(key: key);

  @override
  _EventQuestionScreenState createState() => _EventQuestionScreenState();
}

class _EventQuestionScreenState extends State<EventQuestionsScreen> {
  EventQuestions? eventQuestions = null;
  bool previewMode = false;

  @override
  void initState() {
    super.initState();
    eventQuestions = null;
    previewMode = false;
  }

  Future<EventQuestions> fetchEventQuestions() {
    if (eventQuestions == null) {
      return Provider.of<DatabaseService>(context, listen: false).getEventQuestions(widget.eventId);
    }
    return Future.value(eventQuestions!);
  }

  onPreview(EventQuestions questions) {
    setState(() {
      eventQuestions = questions;
      previewMode = true;
    });
  }

  onSkipQuestions(String id) {
    EventQuestions questions = EventQuestions(id: id, questions: List.empty());
    Provider.of<DatabaseService>(context, listen: false).setEventQuestions(questions);
    Navigator.pop(context);
  }

  onNext(EventQuestions questions) {
    debugPrint("Handling event question: ${questions.id}");
    Provider.of<DatabaseService>(context, listen: false).setEventQuestions(questions);
    Navigator.pop(context);
  }

  onBackwards() {
    if (!previewMode) {
      Navigator.pop(context);
    } else {
      debugPrint("Edit Preview Mode");
      setState(() {
        previewMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: BackAppBar.createAppBar(onBackwards),
          body: FutureBuilder<EventQuestions>(
        future: fetchEventQuestions(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return previewMode ? 
              EventQuestionsPreviewForm(onNext: onNext, eventQuestions: eventQuestions!) :
              EventQuestionsForm(onPreview: onPreview, onSkipQuestions: onSkipQuestions, eventQuestions: snapshot.data!);
          }
          return const CircularProgressIndicator();
        }
      )
      ),
    );
  }
}