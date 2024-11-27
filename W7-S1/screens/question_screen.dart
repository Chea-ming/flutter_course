import 'package:flutter/material.dart';
import 'package:flutter_application_1/W7-S1/model/quiz.dart';
import 'package:flutter_application_1/W7-S1/model/submission.dart';

class QuestionScreen extends StatefulWidget {
  final Quiz quiz;
  final int currentQuestionIndex;
  final Submission submission; 
  final VoidCallback onFinish;
  final VoidCallback onNext;

  const QuestionScreen({
    super.key,
    required this.quiz,
    required this.currentQuestionIndex,
    required this.submission,
    required this.onFinish,
    required this.onNext,
  });

  @override
  // ignore: library_private_types_in_public_api
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String? selectedAnswer; 

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.quiz.questions[widget.currentQuestionIndex];

    return Scaffold(
      backgroundColor: Colors.blue[500]!,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            for (var answer in currentQuestion.possibleAnswers)
              RadioListTile<String>(
                title: Text(answer),
                value: answer,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedAnswer != null) {
                  widget.submission.addAnswer(currentQuestion, selectedAnswer!);
                  if (widget.currentQuestionIndex <
                      widget.quiz.questions.length - 1) {
                    widget.onNext(); 
                  } else {
                    widget.onFinish(); 
                  }
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
