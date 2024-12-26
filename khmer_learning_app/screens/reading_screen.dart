import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


Future<String> loadStoryContent(String filename) async {
  return await rootBundle.loadString('assets/stories/$filename');
}

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  _ReadingScreenState createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  final List<String> stories = [
    'រឿងទី ១: ស្ដេចនិងស្រីស្អាត', // Romance
    'រឿងទី ២: ព្រៃឈើនៃស្នេហា', // Romance
    'រឿងទី ៣: ការស្រឡាញ់នៃក្មេងៗ', // Romance
    'រឿងទី ៤: ការបង្ហាញអំពីភាពយន្ត', // Adventure
    'រឿងទី ៥: ការលេងសប្បាយនៅលើផ្ទៃដី', // Adventure
  ];

  @override
  void initState() {
    super.initState();
    loadStories();
  }

  List<String> storyContents = List.filled(5, ''); 

  Future<void> loadStories() async {
    storyContents[0] = await loadStoryContent('story1.txt');
    storyContents[1] = await loadStoryContent('story2.txt');
    storyContents[2] = await loadStoryContent('story3.txt');
    storyContents[3] = await loadStoryContent('story4.txt');
    storyContents[4] = await loadStoryContent('story5.txt');
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Khmer Stories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StorySearchDelegate(stories: stories, storyContents: storyContents),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStorySection('Romance Stories', 0, 3),
            _buildStorySection('Adventure Stories', 3, 5),
          ],
        ),
      ),
    );
  }

  Widget _buildStorySection(String title, int startIndex, int endIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200, // Set height for the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: endIndex - startIndex,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to the StoryDetailScreen with the selected story content
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoryDetailScreen(
                        story: stories[startIndex + index],
                        content: storyContents[startIndex + index],
                      ),
                    ),
                  );
                },
                child: _buildStoryCard(
                    stories[startIndex + index], startIndex + index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStoryCard(String storyTitle, int index) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: 150, // Set width for each card
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images3/background${index + 1}.jpg'), // Specify the background image
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              storyTitle,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white, // Ensure text is readable
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StorySearchDelegate extends SearchDelegate<String> {
  final List<String> stories;
  final List<String> storyContents; // Add storyContents to the delegate

  StorySearchDelegate({required this.stories, required this.storyContents});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredStories =
        stories.where((story) => story.contains(query)).toList();

    return ListView.builder(
      itemCount: filteredStories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredStories[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryDetailScreen(
                  story: filteredStories[index],
                  content: storyContents[index], 
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredStories =
        stories.where((story) => story.contains(query)).toList();

    return ListView.builder(
      itemCount: filteredStories.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(filteredStories[index]),
          onTap: () {
            query = filteredStories[index];
            showResults(context);
          },
        );
      },
    );
  }
}

class StoryDetailScreen extends StatelessWidget {
  final String story;
  final String content; // Add content parameter
  const StoryDetailScreen(
      {super.key, required this.story, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content, // Display the detailed content
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
