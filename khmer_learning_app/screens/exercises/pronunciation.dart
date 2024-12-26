import '../../data/lesson_data.dart';
import '../lesson_card.dart';
import 'package:flutter/material.dart';


class PronunciationBody extends StatelessWidget {

  const PronunciationBody({super.key});

  @override
  Widget build(BuildContext context) {
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
}
