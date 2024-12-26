import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'screens/home_screen.dart'; 
import 'screens/writing_screen.dart';
import 'screens/reading_screen.dart';
import 'screens/listening_screen.dart';

void main() {
  runApp(const KhmerLearningApp());
}

class KhmerLearningApp extends StatefulWidget {
  const KhmerLearningApp({super.key});

  @override
  _KhmerLearningAppState createState() => _KhmerLearningAppState();
}

class _KhmerLearningAppState extends State<KhmerLearningApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    const WritingScreen(),
    const ReadingScreen(),
    const ListeningScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.pencil),
              label: 'Writing',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book),
              label: 'Reading',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.headphones),
              label: 'Listening',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _screens[index];
            },
          );
        },
      ),
    );
  }
}
