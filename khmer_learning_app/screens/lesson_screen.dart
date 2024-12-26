import 'package:flutter/material.dart';
import '../data/lesson_data.dart';
import '../screens/exercises/matching.dart';
import '../screens/exercises/pronunciation.dart';
import '../screens/exercises/fill_in.dart';
import 'lesson_card.dart';
import 'congrats.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  int currentStep = 0;

  void _goToNext() {
    setState(() {
      if (currentStep < exercises.length - 1) {
        currentStep++;
      }
    });
  }

  void _goToPrevious() {
    setState(() {
      if (currentStep > 0) {
        currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson 1'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: _goToPrevious,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: _goToNext,
                  ),
                ],
              ),
              SizedBox(
                width: 300,
                height: 6,
                child: LinearProgressIndicator(
                  value: (currentStep + 1) / exercises.length,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: getExerciseBody(currentStep),
      ),
    );
  }

  Widget getExerciseBody(int step) {
    switch (exercises[step]['type']) {
      case 'audio':
        return const PronunciationBody();
      case 'matching':
        return const MatchingExerciseBody();
      case 'fill_in_the_blanks':
        return const FillInTheBlankScreen();
      case 'congrats':
        return const BeautifulCongratulationsScreen();
      default:
        return const Center(child: Text('Unknown Exercise'));
    }
  }

  Widget buildPronunciationBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Tap to hear the pronunciation',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            shrinkWrap: true, 
            physics: const NeverScrollableScrollPhysics(), 
            children:
                lessons.map((lesson) => LessonCard(lesson: lesson)).toList(),
          ),
        )
      ],
    );
  }

  Widget buildFillInTheBlanksBody() {
    return const Center(
      child: Text(
        'This is the Fill in the Blanks Exercise',
        style: TextStyle(fontSize: 24),
      ),
    );
  }

}



