import '../models/lesson.dart';

List<Unit> getUnits() {
  return [
    Unit(
      title: 'Introduction and Basic',
      lessons: [
        Lesson(
            title: 'Greetings and Farewells',
            description: 'hello, how are you?, goodbye!'),
        Lesson(
            title: 'Introducing yourself',
            description: 'name, age, personality'),
        Lesson(
            title: 'Numbers and Basic Questions',
            description: 'counting 1-10, WH questions'),
      ],
    ),
    Unit(
      title: 'Everyday Conversations',
      lessons: [
        Lesson(
            title: 'Food and Drink',
            description: 'common foods and drinks'),
        Lesson(
            title: 'Shopping Essential',
            description: 'clothing items, sizes, colors'),
        Lesson(
            title: 'Directions and Locations',
            description: 'directions: left, right, straight'),
      ],
    ),
    Unit(
      title: 'Expanding Your Grammar',
      lessons: [
        Lesson(
            title: 'Family and Relationship',
            description: 'family members and relationship'),
        Lesson(
            title: 'Daily Activities',
            description: 'common daily routines'),
        Lesson(
            title: 'Times and Dates',
            description: 'telling time, day of the week'),
      ],
    ),
    Unit(
      title: 'Cultural Context and Practical Use',
      lessons: [
        Lesson(
            title: 'Cultural Insights',
            description: 'key cultural phrases and concepts'),
        Lesson(
            title: 'Travel and Transportation',
            description: 'modes of transport, travel-related phrases'),
        Lesson(
            title: 'Review and Applications',
            description: 'review of vocabulary unit 1-4'),
      ],
    ),
    // Add more units as needed
  ];
}

final List<LessonCardData> lessons = [
  LessonCardData(
    english: 'Hello',
    khmer: 'សួស្តី',
    phonetic: 'Sur Sdey',
    imgUrl: 'assets/images3/hello.png'
  ),
  LessonCardData(
    english: 'How are you?',
    khmer: 'សុខសប្បាយទេ?',
    phonetic: 'Sok Sabay te',
    imgUrl: 'assets/images3/how.png',
  ),
  LessonCardData(
    english: 'Goodbye',
    khmer: 'លា ហើយ',
    phonetic: 'Lea Hery',
    imgUrl: 'assets/images3/bye.png'
  ),
];

final List<Map<String, String>> exercises = [
  {
    'title': 'Tap to hear the pronunciation',
    'type': 'audio',
  },
  {
    'title': 'Words Matching Exercise',
    'type': 'matching',
  },
  {
    'title': 'Fill in the blanks',
    'type': 'fill_in_the_blanks',
  },
  {
    'title': 'Congrats',
    'type': 'congrats',
  }
];

final List<Map<String, String>> dialogs = [
  {
    'khmer': 'ខ្ញុំឈ្មោះសុខ',
    'translation': 'Hello, my name is Sok',
    'correctAnswer': 'សួស្តី',
    'order': 'filledFirst',
  },
  {
    'khmer': 'ខានជួបគ្នាយូរហើយ',
    'translation': 'Long time no see, How are you?',
    'correctAnswer': 'សុខសប្បាយទេ?',
    'order': 'khmerFirst',
  },
  {
    'khmer': 'អរគុណ',
    'translation': 'Thank you, Goodbye!',
    'correctAnswer': 'លា ហើយ',
    'order': 'khmerFirst',
  },
];
