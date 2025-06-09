import 'enum/number_type.dart';

class QuestionEntity {
  final String? code;
  final String? parType;
  final String? questionType;
  final String? question;
  String? answer;

  bool get isNumberQuestion {
    return NumberTypeExtension.fromString(questionType) == NumberType.number;
    // return questionType == 'number' || questionType == 'NUMBER';
  }

  QuestionEntity({
    this.code,
    this.parType,
    this.questionType,
    this.question,
    this.answer,
  });

  factory QuestionEntity.fromJson(Map<String, dynamic> json) {
    return QuestionEntity(
      code: json['code'],
      parType: json['parType'],
      questionType: json['questionType'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'parType': parType,
      'questionType': questionType,
      'question': question,
      'answer': answer,
    };
  }
}
