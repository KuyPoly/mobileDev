import 'package:my_first_project/domain/quiz.dart';
import 'package:test/test.dart';

main() {
  // Create 2 questions and the quiz
  Question q1 =
      Question(title: "2+2", choices: ["1", "2", "4"], goodChoice: "4", point: 10);

  Question q2 =
      Question(title: "2+3", choices: ["1", "2", "5"], goodChoice: "5");

  Quiz quiz = Quiz(questions: [q1, q2]);

  test('All answers are good (100%)', () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "4");
    Answer a2 = Answer(question: q2, answerChoice: "5");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(100));
    expect(quiz.getPoint(), equals(11));
  });

  test('All answers are kinda good (50%)', () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "4");
    Answer a2 = Answer(question: q2, answerChoice: "1");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(50));
    expect(quiz.getPoint(), equals(10));
  });

    test('All answers are so bad (0%)', () {
    // Create the answer here
    Answer a1 = Answer(question: q1, answerChoice: "2");
    Answer a2 = Answer(question: q2, answerChoice: "1");

    quiz.answers = [a1, a2];

    // Check something
    expect(quiz.getScoreInPercentage(), equals(0));
    expect(quiz.getPoint(), equals(0));
  });
}