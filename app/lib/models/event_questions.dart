import 'package:cloud_firestore/cloud_firestore.dart';

class EventQuestion {
  final String id;
  final String? query;
  final bool required;

  const EventQuestion({
    required this.id,
    required this.required,
    this.query
  });

  factory EventQuestion.fromMap(Map<String, dynamic> data) {
    return EventQuestion(
      id: data['id'],
      query: data['query'],
      required: (data['required'] as bool)
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'query': query,
      'required': required
    };
  }
}


class EventQuestions {
  final String id;
  final List<EventQuestion> questions;

  EventQuestions({
    required this.id,
    required this.questions
  });

  factory EventQuestions.fromDoc(DocumentSnapshot doc) {
    var data = (doc.data() as Map<String, dynamic>);
    var questions = data.containsKey('questions') ? 
      data['questions'].map((q) => EventQuestion.fromMap(q as Map<String, dynamic>)).toList() : 
      List.empty();
    return EventQuestions(
      id: doc.id,
      questions: List<EventQuestion>.from(questions)
    );
  }

  Map<String, dynamic> toDoc() {
    return {
      'id': id,
      'questions': questions.map((q) => q.toDoc()).toList()
    };
  }
}