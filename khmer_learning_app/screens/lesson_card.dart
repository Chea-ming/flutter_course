import 'package:flutter/material.dart';
import '../models/lesson.dart';
import '../services/tts.dart';

class LessonCard extends StatelessWidget {
  final LessonCardData lesson;
  final ttsService = TTSService();

  LessonCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: InkWell(
        onTap: () => ttsService.playAudio(lesson.khmer),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child:
                    Image.asset(lesson.imgUrl, height: 120, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  lesson.english,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Text(
                  lesson.khmer,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center, 
                ),
              ),
            ],
          ),
      ),
      ),
    );
  }
}
