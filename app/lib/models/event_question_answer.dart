class EventQuestionAnswer {
  final String questionId;
  final String? answer;

  const EventQuestionAnswer({
    required this.questionId,
    required this.answer
  });

  factory EventQuestionAnswer.fromMap(Map<String, dynamic> data) {
    return EventQuestionAnswer(
      questionId: data['questionId'], 
      answer: data['answer']
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'questionId': questionId,
      'answer': answer
    };
  }
}