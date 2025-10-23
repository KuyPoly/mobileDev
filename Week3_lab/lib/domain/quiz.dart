import 'package:uuid/uuid.dart';

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

class Answer{
  final String id;
  final Question question;
  final String answerChoice;

   Answer({
    String? id,
    required this.question,
    required this.answerChoice,
  }) : this.id = id ?? Uuid().v4();

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }

  factory Answer.fromJson(Map<String, dynamic> json, Question question) {
    return Answer(
      id: json['id'],
      question: question,
      answerChoice: json['answerChoice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': question.id,
      'answerChoice': answerChoice,
    };
  }
}

class Player {
  final String id;
  final String name;
  int score = 0;
  int point = 0;

  Player({
    String? id,
    required this.name,
  }) : this.id = id ?? Uuid().v4();

  void updateScore(int score) {
    this.score += score;
  }

  void updatePoint(int points) {
    this.point += points;
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
    )
      ..score = json['score'] ?? 0
      ..point = json['point'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
      'point': point,
    };
  }
}

class Quiz{
  List<Question> questions;
  List <Answer> answers =[];
  List<Player> players = [];

  Quiz({required this.questions});

  void addAnswer(Answer answer) {
     this.answers.add(answer);
  }

  void addPlayer(Player player){
    this.players.add(player);
  }

  int getScoreInPercentage(List<Answer> answers) {
    int totalSScore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSScore++;
      }
    }
    return ((totalSScore / questions.length) * 100).toInt();

  }

  int getPoint(List<Answer> answers) {
    int totalPoint = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalPoint += answer.question.point;
      }
    }
    return totalPoint;
  }
}