import 'package:wo/entities/cus_info.dart';
import 'package:wo/entities/question_entity.dart';

class FeedbackSurveyBody {
  final int? woHcId;
  final String? type_pks;
  final CustomerInfo? cus_info;
  final List<QuestionEntity>? listQuestion;

  FeedbackSurveyBody({
    this.cus_info,
    this.listQuestion,
    this.type_pks,
    this.woHcId,
  });

  factory FeedbackSurveyBody.fromJson(Map<String, dynamic> json) {
    return FeedbackSurveyBody(
      woHcId: json['woHcId'] as int?,
      type_pks: json['type_pks'] as String?,
      cus_info: json['cus_info'] != null
          ? CustomerInfo.fromJson(json['cus_info'])
          : null,
      listQuestion: (json['listQuestion'] as List<dynamic>?)
          ?.map((e) => QuestionEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'woHcId': woHcId,
      'type_pks': type_pks,
      'cus_info': cus_info?.toJson(),
      'listQuestion': listQuestion?.map((e) => e.toJson()).toList(),
    };
  }
}
