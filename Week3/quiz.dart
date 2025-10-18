class Question{
  final String _questionText;
  final List<String> _choices;
  final String _correct;

  Question(
    this._questionText,
    this._choices,
    this._correct
  );

  @override
  String toString() {
    return "$_questionText\n $_choices \n $_correct";
  }

  List<String> get choices => _choices;
  String get correct => _correct;
  String get questionText => _questionText;
}

class Answer {
  String _answer;
  Question _question;

  Answer(this._answer, this._question);

  @override
  String toString() {
    return "$_answer";
  }
  
  bool isGoodAnswer()  => _answer == _question.correct;
  String get answerChoice => _answer;
}

class Quiz{
  List<Question> questions;
  List<Answer> answers;

  Quiz(this.questions, this.answers);

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  int getScore() {
    int totalPoint = 0;
    for(var answer in answers) {
      answer.isGoodAnswer()? totalPoint += 1 : totalPoint+= 0;
    }
    return totalPoint;
  }

  void printResult() {
    for(int i = 0; i < questions.length; i++) {
      String res;
      res = answers[i].isGoodAnswer()? "correct" : "wrong";
      print("Q.${i+1} ${questions[i].questionText}");
      questions[i].choices.forEach(print);
      print("your choice: ${answers[i]._answer}");
      print("$res\n");
    }
    double totalScore = (getScore()/questions.length)*100;
    print("\n Total Score: $totalScore");
  }
}

void main() {

  Question q1 = Question("1 + 7 = 17", ["True", "False"], "False");
  Question q2 = Question("A, B, C ,..., E", ["D", "G", "L"], "D");

  Quiz quiz = Quiz(
    [q1, q2],
    [
      Answer("False", q1),
      Answer("L", q2),
    ]
  );

  quiz.printResult();

}