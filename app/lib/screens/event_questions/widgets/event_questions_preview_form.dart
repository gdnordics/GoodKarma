import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';

class EventQuestionsPreviewForm extends StatefulWidget {
  final Function(EventQuestions) onNext;
  final EventQuestions eventQuestions;

  const EventQuestionsPreviewForm({
    Key? key,
    required this.onNext,
    required this.eventQuestions
  }) : super(key: key);

  @override
  _EventQuestionsPreviewFormState createState() => _EventQuestionsPreviewFormState();
}

class _EventQuestionsPreviewFormState extends State<EventQuestionsPreviewForm> {

  Widget buildQuestions() {
      return Column(
        children: widget.eventQuestions.questions.map((q) {
          return buildQuestion(q.query!);
        }).toList()
      );
  }

  Widget buildQuestion(String query) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(query,
            style: boldTextStyle.copyWith(
                fontSize: 16.0)),
        TextFormWidget(
          hintText: "Type here",
          readOnly: true),
        SizedBox(height: 20)
      ]));
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
                      Text("Volunteer approval form",
                          style: boldTextStyle.copyWith(fontSize: 24.0)),
                      const SizedBox(height: 30.0),
                      Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: buildQuestions(),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                          alignment: Alignment.center,
                          child: ActionButton(
                            width: 252,
                            height: 58,
                              text: "LOOKS GOOD!",
                              onPressed: () => widget.onNext(widget.eventQuestions))),
                      const SizedBox(height: 20.0),
                     Center(
                       child: SizedBox(width: 260,
                        child: Text(
                          "Volunteers will see this form before signing up for your event",
                          style: normalTextStyle.copyWith(
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic
                          ))))
                    ])),
          ));
  }

}