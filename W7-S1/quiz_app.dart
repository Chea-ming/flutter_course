import 'package:flutter/material.dart';
import 'model/quiz.dart';
import 'model/submission.dart';
import 'screens/welcome_screen.dart';
import 'screens/question_screen.dart';
import 'screens/result_screen.dart';

enum QuizState {
  notStarted,
  started,
  finished,
}

Color appColor = Colors.blue[500]!;

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentQuestionIndex = 0;
  Submission _submission = Submission(answers: []);
  QuizState _quizState = QuizState.notStarted; 

  void _startQuiz() {
    setState(() {
      _quizState = QuizState.started;
    });
  }

  void _finishQuiz() {
    setState(() {
      _quizState = QuizState.finished;
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _finishQuiz(); 
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _quizState = QuizState.notStarted;
      _currentQuestionIndex = 0;
      _submission.removeAnswers();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    switch (_quizState) {
      case QuizState.notStarted:
        currentScreen = WelcomeScreen(
          onStart: _startQuiz,
          quizTitle: 'Crazy Quiz',
        );
        break;
      case QuizState.started:
        currentScreen = QuestionScreen(
          quiz: widget.quiz,
          currentQuestionIndex: _currentQuestionIndex,
          submission: _submission, 
          onFinish: _finishQuiz,
          onNext: _nextQuestion,
        );
        break;
       case QuizState.finished:
        currentScreen = ResultScreen(
          submission: _submission,
          quiz: widget.quiz, 
          onRestart: _restartQuiz,
        );
        break;
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: appColor,
        body: Center(
          child: currentScreen,
        ),
      ),
    );
  }
}
