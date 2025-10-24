import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Question{
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question({
    String? id,
    required this.title,
    required this.choices,
    required this.goodChoice,
    int point = 1,
  })  : this.point = point,
        this.id = id ?? Uuid().v4();

  // Factory constructor for JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      title: json['title'],
      choices: List<String>.from(json['choices']),
      goodChoice: json['goodChoice'],
      point: json['points'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'choices': choices,
      'goodChoice': goodChoice,
      'points': point,
    };
  }
}

class Answer {
  final String id;
  final Question question;
  final String answerChoice;

  Answer({String? id, required this.question, required this.answerChoice}) : id = id ?? uuid.v4();

  factory Answer.fromJson(Map<String, dynamic> json, Map<String, Question> questionById) {
    final qid = json['questionId'] as String?;
    if (qid == null) {
      throw FormatException('Answer missing questionId: ${json}');
    }
    final question = questionById[qid];
    if (question == null) {
      throw FormatException('Answer references unknown questionId: $qid');
    }

    return Answer(
      id: json['id'] as String?,
      question: question,
      answerChoice: json['answerChoice'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': question.id,
      'answerChoice': answerChoice,
    };
  }

  bool isGood() {
    return answerChoice == question.goodChoice;
  }
}

class Player {
  final String id;
  final String name;
  List<Answer> answers;

  Player({String? id, required this.name, List<Answer>? answers}) : id = id ?? uuid.v4(), answers = answers ?? [];

  factory Player.fromJson(Map<String, dynamic> json, Map<String, Question> questionById) {
    final answersJson = json['answers'] as List<dynamic>? ?? [];
    final List<Answer> answers = [];
    for (var a in answersJson) {
      try {
        answers.add(Answer.fromJson(a as Map<String, dynamic>, questionById));
      } catch (e) {
        print('Warning: skipping invalid answer in player ${json['name'] ?? json['id']}: $e');
      }
    }

    return Player(
      id: json['id'] as String?,
      name: json['name'] as String? ?? '',
      answers: answers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'answers': answers.map((a) => a.toJson()).toList(),
    };
  }
}

class Quiz {
  List<Player> players;
  List<Question> questions;

  Quiz({required this.players, required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final questionsJson = json['questions'] as List<dynamic>? ?? [];
    final questions = questionsJson.map((q) => Question.fromJson(q as Map<String, dynamic>)).toList();

    final questionById = {for (var q in questions) q.id: q};

    List<Player> players = [];
    if (json.containsKey('players') && json['players'] is List<dynamic>) {
      players = (json['players'] as List<dynamic>).map((p) => Player.fromJson(p as Map<String, dynamic>, questionById)).toList();
    }

    return Quiz(players: players, questions: questions);
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((q) => q.toJson()).toList(),
      'players': players.map((p) => p.toJson()).toList(),
    };
  }

  void addAnswer(Player player, Answer answer) {
    player.answers.add(answer);
  }

  int getScore(Player player) {
    int totalScore = 0;
    for (Answer answer in player.answers) {
      if (answer.isGood()) {
        totalScore += answer.question.point;
      }
    }
    return totalScore;
  }

  int getScoreInPercentage(Player player) {
    int totalCorrect = 0;
    for (Answer answer in player.answers) {
      if (answer.isGood()) totalCorrect++;
    }
    if (questions.isEmpty) return 0;
    return ((totalCorrect / questions.length) * 100).toInt();
  }
}