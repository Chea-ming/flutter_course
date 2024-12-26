import 'package:flutter/material.dart';
import 'dart:async';
import '../../data/lesson_data.dart';
import '../../services/tts.dart';
import 'package:audioplayers/audioplayers.dart'; // Import audio player

class FillInTheBlankScreen extends StatefulWidget {
  const FillInTheBlankScreen({super.key});

  @override
  _FillInTheBlankScreenState createState() => _FillInTheBlankScreenState();
}

class _FillInTheBlankScreenState extends State<FillInTheBlankScreen> {
  String filledAnswer = '____';
  int currentDialogIndex = 0; // Track the current dialog index
  int? incorrectCardIndex; // Track the index of the incorrect card
  final tts = TTSService();
  final AudioPlayer _audioPlayer = AudioPlayer(); // Initialize audio player

  List<Map<String, String>> answeredDialogs = []; // Track answered dialogs
  List<bool> answeredCards = []; // Track which cards have been answered

  @override
  void initState() {
    super.initState();
    answeredCards = List.generate(
        lessons.length, (_) => false); // Initialize answered cards
  }

  void checkAnswer(String selectedAnswer, int index) {
    if (selectedAnswer == dialogs[currentDialogIndex]['correctAnswer']) {
      setState(() {
        answeredDialogs.add({
          ...dialogs[currentDialogIndex],
          'filledAnswer': selectedAnswer, // Store the filled answer
        });
        answeredCards[index] = true; // Mark the card as answered

        // Move to the next dialog or finalize
        if (currentDialogIndex < dialogs.length - 1) {
          currentDialogIndex++;
          filledAnswer = '____'; // Reset filled answer
        } else {
          // Finalize state
          filledAnswer = ''; // Clear filled answer
        }
        incorrectCardIndex = null; // Reset incorrect index
      });
      _audioPlayer.setSource(AssetSource('audio/correct.mp3'));
      _audioPlayer.setVolume(0.6);
      _audioPlayer.resume();
    } else {
      // Incorrect answer handling
      setState(() {
        incorrectCardIndex = index; // Set incorrect card index
      });
      _audioPlayer.setSource(AssetSource('audio/wrong.mp3'));
      _audioPlayer.setVolume(0.3);
      _audioPlayer.resume();
      Timer(const Duration(seconds: 2), () {
        setState(() {
          incorrectCardIndex = null; // Reset incorrect card index
        });
      });
    }
  }

  void playAudioForAnsweredDialog(Map<String, String> dialog) {
    String audioText = dialog['order'] == 'filledFirst'
        ? '${dialog['filledAnswer']} ${dialog['khmer']}'
        : '${dialog['khmer']}, ${dialog['filledAnswer']}';
    tts.playAudio(audioText);
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose of the audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isCompleted = currentDialogIndex >= dialogs.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        const Text(
          'Fill in the blank',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Person Image
            Image.asset(
              'assets/images3/boy.png',
              width: 50,
              height: 50,
            ),
            const SizedBox(width: 16), // Space between image and card
            // Dialog Card
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    if (!isCompleted) {
                      tts.playAudio(dialogs[currentDialogIndex]['order'] ==
                              'filledFirst'
                          ? dialogs[currentDialogIndex]['correctAnswer']! +
                              dialogs[currentDialogIndex]['khmer']!
                          : dialogs[currentDialogIndex]['khmer']! +
                              dialogs[currentDialogIndex]['correctAnswer']!);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dialogs[currentDialogIndex]['order'] == 'filledFirst'
                              ? '${isCompleted ? '' : '$filledAnswer, '}${dialogs[currentDialogIndex]['khmer']}'
                              : '${dialogs[currentDialogIndex]['khmer']}, ${isCompleted ? '' : filledAnswer}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          dialogs[currentDialogIndex]
                              ['translation']!, // English translation
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        // New dialog section
        if (answeredDialogs.isNotEmpty) ...[
          for (var dialog in answeredDialogs) ...[
            Row(
              children: [
                Image.asset(
                  'assets/images3/boy.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: InkWell(
                      onTap: () => playAudioForAnsweredDialog(dialog),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dialog['order'] == 'filledFirst'
                                  ? '${dialog['filledAnswer']}, ${dialog['khmer']}'
                                  : '${dialog['khmer']}, ${dialog['filledAnswer']}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              dialog['translation']!, // English translation
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ],
        // Word cards section
        if (!isCompleted)
          Expanded(
            child: ListView.builder(
              itemCount: lessons.length, // Show all lessons as word cards
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                if (answeredCards[index]) {
                  return const SizedBox.shrink(); // Don't display answered cards
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        // Check the answer and handle the result
                        checkAnswer(lesson.khmer, index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: (incorrectCardIndex == index)
                                ? Colors.red
                                : Colors.transparent,
                            width: 2,
                          ), // Set border color based on state
                          borderRadius: BorderRadius.circular(16),
                        ),
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
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
