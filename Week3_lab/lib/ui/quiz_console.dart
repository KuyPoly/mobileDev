import 'dart:io';
import 'dart:math';

import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    // Loop to allow multiple players
    while (true) {
      stdout.write("Your name: ");
      String? playerName = stdin.readLineSync();

      // Exit if no name is provided
      if (playerName == null || playerName.trim().isEmpty) {
        break;
      }

      // Add players to the quiz
      quiz.addPlayer(Player(name: playerName));

      // Player takes quiz
      List<Answer> playerAnswers = [];

      for (var question in quiz.questions) {
        print('Question: ${question.title} - (${question.point} points))');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');
        String? userInput = stdin.readLineSync();

        // Check for null input
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          playerAnswers.add(answer);
        } else {
          print('No answer entered. Skipping question.');
        }

        print('');
      }

      // Calculate score and points for players
      quiz.players.last.score = quiz.getScoreInPercentage(playerAnswers);
      quiz.players.last.point = quiz.getPoint(playerAnswers);

      print("${quiz.players.last.name}, your score in percentage: ${quiz.players.last.score} %");
      print("${quiz.players.last.name}, your score in points: ${quiz.players.last.point}");

      // Display all players scores
      for (var player in quiz.players) {
        print("Player: ${player.name}\t\tScore:${player.score}");
      }
    }

    print('--- Quiz Finished ---');
  }
}