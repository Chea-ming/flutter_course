import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../data/lesson_data.dart';
import '../../services/tts.dart';

class MatchingExerciseBody extends StatefulWidget {
  const MatchingExerciseBody({super.key});

  @override
  _MatchingExerciseBodyState createState() => _MatchingExerciseBodyState();
}

class _MatchingExerciseBodyState extends State<MatchingExerciseBody> {
  final tts = TTSService();
  AudioPlayer audioPlayer = AudioPlayer();
  List<bool> matched = []; 
  int currentLessonIndex = 0; 
  bool allMatched = false;

  @override
  void initState() {
    super.initState();
    matched = List.filled(lessons.length, false);
  }

  Future<void> checkMatch(int index) async {
    // Get the current lesson being played
    final currentLesson = lessons[currentLessonIndex];

    if (currentLesson.english == lessons[index].english) {
      // Check for a match
      if (!matched[index]) {
        setState(() {
          matched[index] = true;
          allMatched = matched.every((element) => element);
        });
        audioPlayer.setVolume(0.8);
        audioPlayer.setSource(AssetSource('audio/correct.mp3'));
        await audioPlayer.resume(); 

        // Move to the next lesson for the next audio
        if (currentLessonIndex < lessons.length - 1) {
          currentLessonIndex++;
          await tts.playAudio(lessons[currentLessonIndex].khmer); // Play the next audio for the next lesson
        }
      }
    } else {
      audioPlayer.setSource(AssetSource('audio/wrong.mp3'));
      audioPlayer.setVolume(0.3);
      await audioPlayer.resume(); 
      // Optionally, show visual feedback for incorrect selection
      _showIncorrectFeedback();
    }
  }

  void _showIncorrectFeedback() {
    // Implement your animation or visual feedback here
    // For example, you can use a Snackbar or change the card color briefly
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Incorrect match! Try again.'),
        duration: Duration(microseconds: 2000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Select the correct word for the sound:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Center(
          child: SizedBox(
            width: 200,
            height: 120,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 2,
              child: InkWell(
                onTap: () {
                  tts.playAudio(lessons[currentLessonIndex]
                      .khmer); // Play the current lesson audio
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Icon(
                      size: 60,
                      color: Color.fromARGB(255, 91, 91, 91),
                      Icons.volume_up, // Replace with your icon
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
            height: 250), // Space between the main card and word cards
        Expanded(
          child: ListView.builder(
            itemCount: lessons.length,
            itemBuilder: (context, index) {
              if (matched[index]) {
                return const SizedBox(); 
              }
              final lesson = lessons[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: InkWell(
                    onTap: () {
                      checkMatch(index); // Check if the selected card matches
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              lesson.khmer,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              ' (${lesson.phonetic})',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 92, 92, 92),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
