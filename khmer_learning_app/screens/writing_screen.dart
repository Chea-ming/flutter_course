import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Khmer Writing Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, 'Consonants', consonants,
              'assets/images3/con.jpg'),
          _buildCard(
              context, 'Vowels', vowels, 'assets/images3/vow.jpg'),
          _buildCard(
              context, 'Numbers', numbers, 'assets/images3/num.jpg'),
          _buildCard(context, 'Extras', extraVowels,
              'assets/images3/extra.jpg'),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, List<String> letters,
      String backgroundImage) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover, // Adjust the way the image fits in the container
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrawingScreen(letters: letters),
              ),
            );
          },
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(16), // Add padding for the title
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 53, 53, 53)),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawingScreen extends StatefulWidget {
  final List<String> letters;
  const DrawingScreen({super.key, required this.letters});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final DrawingController _drawingController = DrawingController();
  int currentLetterIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw the Letter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setState(() {
                _drawingController.clear();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              if (currentLetterIndex < widget.letters.length - 1) {
                setState(() {
                  currentLetterIndex++;
                });
              } else {
                Navigator.pop(context); // Go back to the main screen
              }
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.letters[currentLetterIndex],
            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: DrawingBoard(
              controller: _drawingController,
              background: Container(
                color: Colors.white,
                height: 900,
                width: 600,
              ),
              showDefaultActions: true,
              showDefaultTools: true,
            ),
          ),
        ],
      ),
    );
  }
}

const consonants = ['ក', 'ខ', 'គ', 'ឃ', 'ង'];
const vowels = ['ា', 'ិ', 'ី', 'ឹ', 'ឺ'];
const numbers = ['០', '១', '២', '៣', '៤'];
const extraVowels = ['ឯ', 'ឰ', 'ឱ', 'ឲ'];
