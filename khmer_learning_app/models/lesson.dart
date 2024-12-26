class Lesson {
  final String title;
  final String description;

  Lesson({required this.title, required this.description});
}

class Unit {
  final String title;
  final List<Lesson> lessons;

  Unit({required this.title, required this.lessons});
}

class LessonCardData {
  final String english;
  final String khmer;
  final String phonetic;
  final String imgUrl;

  LessonCardData({
    required this.english,
    required this.khmer,
    required this.phonetic,
    required this.imgUrl
  });
}

