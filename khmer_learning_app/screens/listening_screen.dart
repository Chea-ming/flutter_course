import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Khmer - Listening'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildVideoCard(
            title: 'Learn Khmer - Lesson 1',
            url: 'https://www.youtube.com/watch?v=U0VxxT0HO80&t=1s',
          ),
          _buildVideoCard(
            title: 'Learn Khmer - Lesson 2',
            url: 'https://www.youtube.com/watch?v=v4u_UrvSBPk&t=88s',
          ),
          _buildVideoCard(
            title: 'Learn Khmer - Lesson 3',
            url: 'https://www.youtube.com/watch?v=Z0XPeQACWm4&t=73s',
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard({required title, required url}) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: videoId!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
        ],
      ),
    );
  }
}
