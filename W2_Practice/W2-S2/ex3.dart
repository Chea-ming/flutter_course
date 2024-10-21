class Duration {
  final int _milliseconds;

  int get seconds => _milliseconds ~/ 1000 % 60;
  int get minutes => _milliseconds ~/ (1000 * 60) % 60;
  int get hours => _milliseconds ~/ (1000 * 60 * 60);

  Duration.fromMilliseconds(int ms) : _milliseconds = ms;

  Duration.fromHours(int hours) : _milliseconds = hours * 1000 * 60 * 60;

  Duration.fromMinutes(int minutes) : _milliseconds = minutes * 1000 * 60;

  Duration.fromSeconds(int seconds) : _milliseconds = seconds * 1000;

  Duration operator +(Duration other) {
    return Duration.fromMilliseconds(_milliseconds + other._milliseconds);
  }

  Duration operator -(Duration other) {
    int resultMilliseconds = _milliseconds - other._milliseconds;
    if (resultMilliseconds < 0) {
      throw Exception('Resulting duration cannot be negative.');
    }
    return Duration.fromMilliseconds(resultMilliseconds);
  }

  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Duration) return false;
    return _milliseconds == other._milliseconds;
  }

  bool operator >(Duration other) => _milliseconds > other._milliseconds;
  bool operator <(Duration other) => _milliseconds < other._milliseconds;
  bool operator >=(Duration other) => _milliseconds >= other._milliseconds;
  bool operator <=(Duration other) => _milliseconds <= other._milliseconds;

  @override
  String toString() {
    return '${hours} hours, ${minutes} minutes, ${seconds} seconds';
  }
}

void main() {
  Duration duration1 = Duration.fromHours(3); // 3 hours
  Duration duration2 = Duration.fromMinutes(45); // 45 minutes
  print(duration1 + duration2); // 3 hours, 45 minutes, 0 seconds
  print(duration1>duration2); // true

  try {
    print(duration2 - duration1); // This will throw an exception
  } catch (e) {
    print(e);
  }
}
