import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/colors.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';
import 'package:uuid/uuid.dart';

const int MAX_QUESTIONS = 6;

class EventQuestionsForm extends StatefulWidget {
  final Function(EventQuestions) onPreview;
  final Function(String) onSkipQuestions;
  final EventQuestions eventQuestions;

  const EventQuestionsForm(
      {Key? key, 
      required this.onPreview, 
      required this.onSkipQuestions,
      required this.eventQuestions})
      : super(key: key);

  @override
  _EventQuestionsFormState createState() => _EventQuestionsFormState();
}

class _EventQuestionsFormState extends State<EventQuestionsForm> {
  final _formKey = GlobalKey<FormState>();
  late List<EventQuestion> questions;

  @override
  void initState() {
    super.initState();
    questions = widget.eventQuestions.questions;
  }

  onAddQuestion() {
    if (MAX_QUESTIONS > questions.length) {
      setState(() {
        questions.add(EventQuestion(
          id: Uuid().v4(),
          query: null,
          required: false,
        ));
      });
    }
  }

  onDeleteQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  onPreviewPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint("EventQuestions form saved");
      widget.onPreview(
          EventQuestions(id: widget.eventQuestions.id, questions: questions));
    }
  }

  onSkipQuestions() {
    widget.onSkipQuestions(widget.eventQuestions.id);
  }

  onValidateQuestion(int index, String? query) {
    if (query == null || query.isEmpty) {
      return "Missing value";
    }
    return null;
  }

  onSaveQuestion(int index, String? query) {
    setState(() {
      questions[index] = EventQuestion(
          id: questions[index].id,
          query: query,
          required: questions[index].required);
    });
  }

  Widget buildQuestions() {
    if (questions.isNotEmpty) {
      int index = 0;
      return Column(
          children: questions.map((q) {
        return buildQuestion(index++, q.query);
      }).toList());
    } else {
      return SizedBox(height: 50);
    }
  }

  Widget buildQuestion(int index, String? initialValue) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Question ${index + 1}",
                style: boldTextStyle.copyWith(fontSize: 16.0)),
            Container(
                padding: const EdgeInsets.only(right: 5.0),
                child: InkWell(
                  child: Icon(Icons.remove_circle,
                      size: 20, color: deleteEventQuestionColor),
                  onTap: () => onDeleteQuestion(index),
                ))
          ]),
          TextFormWidget(
              initialValue: initialValue,
              hintText: "Type here",
              onValidation: (input) => onValidateQuestion(index, input),
              onSaved: (input) => onSaveQuestion(index, input)),
          SizedBox(height: 20)
        ]));
  }

  Widget buildPreviewButton(List<EventQuestion> questions) {
    if (questions.isEmpty) {
      return ActionButton(
          width: 252,
          height: 58,
          text: "SKIP QUESTIONS",
          onPressed: onSkipQuestions,
          color: primaryDarkGreenColor);
    } else {
      return ActionButton(
          width: 252,
          height: 58,
          text: "PREVIEW FORM",
          onPressed: onPreviewPressed,
          color: primaryDarkGreenColor);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: Container(
              margin: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20.0, right: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Set Up Application Questions",
                        style: boldTextStyle.copyWith(fontSize: 24.0)),
                    const SizedBox(height: 30.0),
                    Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Form(
                          key: _formKey,
                          child: buildQuestions(),
                        )),
                    const SizedBox(height: 30.0),
                    Container(
                        alignment: Alignment.center,
                        child: ActionButton(
                          width: 252,
                          height: 58,
                          text: "ADD QUESTION",
                          onPressed: onAddQuestion,
                          disabled: MAX_QUESTIONS <= questions.length,
                        )),
                    const SizedBox(height: 20.0),
                    Container(
                        alignment: Alignment.center,
                        child: buildPreviewButton(questions))
                  ])),
        ));
  }
}
