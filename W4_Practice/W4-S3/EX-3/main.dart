import 'package:flutter/material.dart';

List<String> images = [
  "assets/w4-s2/bird.jpg",
  "assets/w4-s2/bird2.jpg",
  "assets/w4-s2/insect.jpg",
  "assets/w4-s2/girl.jpg",
  "assets/w4-s2/man.png",
];
void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageViewer(),
    ));

class ImageViewer extends StatefulWidget {
  const ImageViewer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {

   int _currentIndex = 0;

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % images.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + images.length) % images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.green[50],
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              title: const Text('Image viewer'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.navigate_before),
                  tooltip: 'Go to the previous image',
                  onPressed: _previousImage,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                  child: IconButton(
                    icon: const Icon(Icons.navigate_next),
                    tooltip: 'Go to the next image',
                    onPressed: _nextImage,
                  ),
                ),
              ],
            ),
            body: Center(
              child: Image.asset(
                images[_currentIndex],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),
        );
  }
}
