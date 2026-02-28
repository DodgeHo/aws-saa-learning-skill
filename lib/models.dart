import 'dart:convert';

class Question {
  final int id;
  final String? qNum;
  final String? stemEn;
  final String? stemZh;
  final List<String>? optionsEn;
  final List<String>? optionsZh;
  final String? correctAnswer;
  final String? explanationEn;
  final String? explanationZh;
  final String? sourceDoc;
  final int? sourcePage;

  Question({
    required this.id,
    this.qNum,
    this.stemEn,
    this.stemZh,
    this.optionsEn,
    this.optionsZh,
    this.correctAnswer,
    this.explanationEn,
    this.explanationZh,
    this.sourceDoc,
    this.sourcePage,
  });

  factory Question.fromMap(Map<String, dynamic> m) => Question(
        id: m['id'] as int,
        qNum: m['q_num'] as String?,
        stemEn: m['stem_en'] as String?,
        stemZh: m['stem_zh'] as String?,
        optionsEn: (m['options_en'] != null)
            ? List<String>.from(json.decode(m['options_en']))
            : null,
        optionsZh: (m['options_zh'] != null)
            ? List<String>.from(json.decode(m['options_zh']))
            : null,
        correctAnswer: m['correct_answer'] as String?,
        explanationEn: m['explanation_en'] as String?,
        explanationZh: m['explanation_zh'] as String?,
        sourceDoc: m['source_doc'] as String?,
        sourcePage: m['source_page'] as int?,
      );
}
