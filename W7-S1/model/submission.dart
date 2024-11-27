import 'quiz.dart';

class Answer {
  final String questionAnswer;
  final Question question;

  Answer({required this.questionAnswer, required this.question});
  
  bool isCorrect() => (questionAnswer == question.goodAnswer) ? true : false;
}

class Submission {
  List<Answer> answers;

  Submission({required this.answers});

  int getScore() {
    int score = 0;
    for(int i = 0; i < answers.length; i++){
      if(answers[i].isCorrect()) score++;
    }
    return score;
  }

  Answer? getAnswerFor(Question question) => Answer(questionAnswer: question.goodAnswer, question: question);

  void addAnswer(Question question, String answer) => answers.add(Answer(questionAnswer: answer, question: question));

  void removeAnswers() => answers.clear();
}