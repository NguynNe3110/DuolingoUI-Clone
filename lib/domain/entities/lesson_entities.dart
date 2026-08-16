// lib/domain/entities/lesson_entities.dart

enum DomainLessonType { star, book, headphone, video, weight }
enum DomainThemeColor { green, blue, red, orange, cyan, violet, brown, pink, purple }
enum DomainNodeStatus { locked, learnAhead, current, completed }

class Lesson {
  final String id;
  final DomainLessonType type;
  final String title;
  final int partCount;

  const Lesson({
    required this.id,
    required this.type,
    required this.title,
    this.partCount = 4,
  });
}

class Door {
  final String id;
  final List<Lesson> lessons;
  final String title; // tieu de cua
  final int number; // so cua
  final DomainThemeColor themeColor;

  const Door({
    required this.id,
    required this.lessons,
    required this.title,
    required this.number,
    required this.themeColor,
  });

  Lesson? getLessonBefore(Lesson lesson) {
    final index = lessons.indexOf(lesson);
    return index > 0 ? lessons[index - 1] : null;
  }
}

class Section {
  final String id;
  final String title; // tieu de phan
  final String number; // phan so
  final String description;

  final List<Door> doors;

  const Section({
    required this.id,
    required this.title,
    required this.number,
    required this.description,
    required this.doors,
  });

  Door? getDoorBefore(Door door) {
    final index = doors.indexOf(door);
    return index > 0 ? doors[index - 1] : null;
  }
}

class Course {
  final String id;
  final List<Section> sections;
  final String title;

  const Course({
    required this.id,
    required this.sections,
    required this.title
  });
}

class UserProgress {
  final Set<String> completedLessonIds;
  final String? currentLessonId;
  final Map<String, int> completedParts;

  const UserProgress({
    this.completedLessonIds = const {},
    this.currentLessonId,
    this.completedParts = const {},
  });

  bool isLessonCompleted(String lessonId) => completedLessonIds.contains(lessonId);

  bool isDoorCompleted(Door door) => door.lessons.every((l) => isLessonCompleted(l.id)); //hay

  double getRingProgress(Lesson lesson) {
    if (lesson.partCount == 0) return 0.0;
    final done = completedParts[lesson.id] ?? 0;
    return done / lesson.partCount;
  }

  int getCompletedParts(Lesson lesson) => completedParts[lesson.id] ?? 0;
}

class HomeTree {
  final Course course;
  final UserProgress progress;

  const HomeTree({required this.course, required this.progress});
}
// relation course > Section > door > lesson