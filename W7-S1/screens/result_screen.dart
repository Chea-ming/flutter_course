import 'package:flutter/material.dart';
import '../model/quiz.dart';
import '../model/submission.dart';

class ResultScreen extends StatelessWidget {
  final Submission submission;
  final VoidCallback onRestart;
  final Quiz quiz;

  const ResultScreen({
    super.key,
    required this.submission,
    required this.onRestart,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    final score = submission.getScore();
    final totalQuestions = quiz.questions.length;

    return Scaffold(
      backgroundColor: Colors.blue[500]!,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $score out of $totalQuestions!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: quiz.questions.length,
                itemBuilder: (context, index) {
                  final question = quiz.questions[index];
                  final userAnswer = submission.answers[index].questionAnswer;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: userAnswer == question.goodAnswer
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}', 
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                question.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          for (var answer in question.possibleAnswers)
                            Text(
                              answer + (answer == question.goodAnswer ? '✔️' : ''),
                              style: TextStyle(
                                color: answer == userAnswer &&
                                        userAnswer == question.goodAnswer
                                    ? Colors.green
                                    : answer == userAnswer
                                        ? Colors.red
                                        : Colors.black,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onRestart,
              child: const Text('Restart Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
