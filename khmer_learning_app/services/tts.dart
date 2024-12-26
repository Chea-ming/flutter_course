import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class TTSService {
  final String url = 'https://tts-api.idri.edu.kh/api/v1/text-to-speech';
  final AudioPlayer audioPlayer = AudioPlayer();

  double volume = 1.0; // Default volume

  void setVolume(double newVolume) {
    volume = newVolume.clamp(0.0, 1.0); 
    audioPlayer.setVolume(volume); 
  }

  Future<void> playAudio(String text) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'text': text, 'sound': 'male'});

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final base64String = data['base64'];

        // Decode the Base64 string into bytes
        final audioData = base64.decode(base64String);
        // Get the temporary directory
        final tempDir = await getTemporaryDirectory();

        // Create the audio file path
        final audioFile = File('${tempDir.path}/audio.mp3');
        await audioFile.writeAsBytes(audioData);
        var urlSource = DeviceFileSource(audioFile.path);

        // Play the audio
        await audioPlayer.play(urlSource);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}
