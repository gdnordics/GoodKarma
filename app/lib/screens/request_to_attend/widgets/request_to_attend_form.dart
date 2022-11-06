import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:good_karma_app/helpers/style.dart';
import 'package:good_karma_app/models/event_question_answer.dart';
import 'package:good_karma_app/models/event_questions.dart';
import 'package:good_karma_app/models/request_to_attend.dart';
import 'package:good_karma_app/models/user_data.dart';
import 'package:good_karma_app/widgets/buttons/action_button.dart';
import 'package:good_karma_app/widgets/text_form_widget.dart';
import 'package:provider/provider.dart';

class RequestToAttendForm extends StatefulWidget {
  final Function(RequestToAttend) onNext;
  final RequestToAttend? oldRequest;
  final EventQuestions eventQuestions;

  const RequestToAttendForm(
      {Key? key, 
      required this.onNext, 
      required this.eventQuestions,
      required this.oldRequest
      })
      : super(key: key);

  @override
  _RequestToAttendFormState createState() =>
      _RequestToAttendFormState();
}

class _RequestToAttendFormState extends State<RequestToAttendForm> {
  final _formKey = GlobalKey<FormState>();
  late List<EventQuestionAnswer> answers;

  @override
  void initState() {
    super.initState();
    answers = widget.eventQuestions.questions
        .map((q) => EventQuestionAnswer(
          questionId: q.id, 
          answer: widget.oldRequest?.answers.
            firstWhere((a) => a.questionId == q.id, 
            orElse: () => EventQuestionAnswer(questionId: q.id, answer: null))
            .answer))
        .toList();
  }

  onValidateQuestion(int index, String? answer) {
    if (widget.eventQuestions.questions[index].required &&
        (answer == null || answer.isEmpty)) {
      return "Missing value";
    }
    return null;
  }

  onSaveQuestion(int index, String? answer) {
    debugPrint("Saving answer [$index]: $answer");
    setState(() {
      answers[index] = EventQuestionAnswer(
          questionId: answers[index].questionId, answer: answer);
    });
  }

  onSendRequest() {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var request = RequestToAttend(
        eventId: widget.eventQuestions.id,
        requesterId: Provider.of<UserData>(context, listen: false).currentUserId!,
        answers: answers,
        status: RequestToAttend.requestPendingResponse
      );
      widget.onNext(request);
    }
  }

  Widget buildQuestions() {
    int index = 0;
    return Column(
        children: widget.eventQuestions.questions.map((q) {
          var answer = answers.firstWhere((a) => a.questionId == q.id).answer;
          return buildQuestion(index++, q.query!, answer);
    }).toList());
  }

  Widget buildQuestion(int index, String query, String? initialValue) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(query, style: boldTextStyle.copyWith(fontSize: 16.0)),
          TextFormWidget(
              hintText: "Type here",
              initialValue: initialValue,
              onValidation: (input) => onValidateQuestion(index, input),
              onSaved: (input) => onSaveQuestion(index, input)),
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
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Form(key: _formKey, child: buildQuestions()),
                      ),
                      const SizedBox(height: 30.0),
                      Container(
                          alignment: Alignment.center,
                          child: ActionButton(
                              width: 252,
                              height: 58,
                              text: "SEND REQUEST",
                              onPressed: onSendRequest)),
                    ]))));
  }
}
