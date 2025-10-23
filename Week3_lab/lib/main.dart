import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'data/quizRepository.dart';

void main() {

  // List<Question> questions = [
  //   Question(
  //       title: "Capital of France?",
  //       choices: ["Paris", "London", "Rome"],
  //       goodChoice: "Paris",why it cannot fi
  //       ),
        
  //   Question(
  //       title: "2 + 2 = ?", 
  //       choices: ["2", "4", "5"], 
  //       goodChoice: "4",
  //       point: 50),
  // ];

  // Read quiz from JSON file
  QuizRepository repository = QuizRepository('D:\\y3t1\\mobile dev\\assignment\\Week3_lab\\lib\\data\\quiz.json');
  Quiz quiz = repository.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();

  QuizRepository resultsRepo = QuizRepository('D:\\y3t1\\mobile dev\\assignment\\Week3_lab\\lib\\data\\quiz_result.json');
  resultsRepo.writeQuiz(quiz);
}