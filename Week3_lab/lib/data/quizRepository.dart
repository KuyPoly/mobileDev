import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  // READ Quiz from JSON file
  Quiz readQuiz() {
    final file = File(filePath);
    final content = file.readAsStringSync();
    Map<String, dynamic> data = jsonDecode(content);

    // Map JSON to domain objects
    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q) {
      return Question(
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        point: q['points'] ?? 1,
      );
    }).toList();

    return Quiz(questions: questions);
  }

  // Write Quiz to JSON file
  void writeQuiz(Quiz quiz) {
    // Convert Quiz to JSON format
    Map<String, dynamic> quizResultJson = {
      'questions': quiz.questions.map((q) => q.toJson()).toList(),
      'players': quiz.players.map((p) => p.toJson()).toList(),
    };

    final file = File(filePath);

    final encoder = JsonEncoder.withIndent('  ');
    String prettyJson = encoder.convert(quizResultJson);

    // Write to file
    file.writeAsStringSync(prettyJson);
    print('Quiz saved to $filePath');
  }
}