import 'dart:math';

import 'package:test/test.dart';
import 'package:my_first_project/domain/quiz.dart';

main() {
   // Create 2 questions and the quiz
  Question q1 =
      Question(title: "2+2", choices: ["1", "2", "4"], goodChoice: "4", point: 10);

  Question q2 =
      Question(title: "2+3", choices: ["1", "2", "5"], goodChoice: "5", point: 50);

  Quiz quiz = Quiz(questions: [q1, q2]);

  test('All answers are good (100%) (60 points)', () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "4");
    Answer a2 = Answer(question: q2, answerChoice: "5");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(quiz.answers), equals(100));
    expect(quiz.getPoint(quiz.answers), equals(60));
  });

  test("Answer are 50% correct 50 points", () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "1");
    Answer a2 = Answer(question: q2, answerChoice: "5");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(quiz.answers), equals(50));
    expect(quiz.getPoint(quiz.answers), equals(50));
  });

  test("Answer are bad 0% 0 points", () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "1");
    Answer a2 = Answer(question: q2, answerChoice: "1");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(quiz.answers), equals(0));
    expect(quiz.getPoint(quiz.answers), equals(0));
  });

  test("Player scores are 100% correct", (){
    Player p1 = Player(name: "Rat");
    Player p2 = Player(name: "Hello");

    quiz.addPlayer(p1);
    quiz.addPlayer(p2);

    // Player 1 answers
    List<Answer> p1Answers = [
      Answer(question: q1, answerChoice: "4"),
      Answer(question: q2, answerChoice: "5")
    ];
    p1.score = quiz.getScoreInPercentage(p1Answers);
    p1.point = quiz.getPoint(p1Answers);

    // Player 2 answers
    List<Answer> p2Answers = [
      Answer(question: q1, answerChoice: "1"),
      Answer(question: q2, answerChoice: "5")
    ];
    p2.score = quiz.getScoreInPercentage(p2Answers);
    p2.point = quiz.getPoint(p2Answers);

    // Check players scores
    expect(p1.score, equals(100));
    expect(p1.point, equals(60));

    expect(p2.score, equals(50));
    expect(p2.point, equals(50));
  });
}