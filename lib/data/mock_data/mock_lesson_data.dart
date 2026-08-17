import '../../domain/entities/lesson_entities.dart';

/// NGUYÊN TẮC ĐỊNH DANH (xem lại bài học "phạm vi của key"):
/// - lessonId UNIQUE toàn course   → key của UserProgress không được trùng.
/// - door number UNIQUE, đánh số LIÊN TỤC xuyên section → "CỬA 27", range "20 - 29".
/// - Section sở hữu door riêng, KHÔNG dùng chung list door giữa các phần.
class MockData {
  List<Course> getMockData() => [course];

  static final Course course = Course(
    id: 'course_english',
    title: 'Khóa học Tiếng Anh',
    sections: [
      _section(1, 'I know some words in English.', 1, 9),
      _section(2, 'I can speak with people a little.', 10, 19),
      _section(3, 'I can talk about daily activities.', 20, 29),
      _section(4, 'I can handle real-life situations.', 30, 39),
    ], // 9 + 10 + 10 + 10 = 39 cửa ✔
  );

  /// Progress mock khớp với scheme ID mới — gắn thẳng vào HomeTree để test.
  static const UserProgress mockProgress = UserProgress(
    completedLessonIds: {'d1_l0', 'd1_l1', 'd1_l2'},
    currentLessonId: 'd1_l3',
    completedParts: {'d2_l0': 2},
  );

  // ────────────────────────────────────────────────────────────
  // GENERATORS — thay vì viết tay vài trăm object
  // ────────────────────────────────────────────────────────────

  static const _types = DomainLessonType.values;
  static const _colors = DomainThemeColor.values;

  static const _doorTitles = [
    'Tham gia lễ hội âm nhạc',
    'Xử lý tình huống y tế khẩn cấp',
    'Gọi món tại nhà hàng',
    'Hỏi đường người bản xứ',
    'Trò chuyện với hàng xóm',
    'Đặt vé xem phim',
  ];

  static Section _section(
      int number,
      String description,
      int fromDoor,
      int toDoor,
      ) {
    return Section(
      id: 'section_$number',
      number: '$number',
      title: 'Phần $number',
      description: description,
      doors: [for (var n = fromDoor; n <= toDoor; n++) _door(n)],
    );
  }

  static Door _door(int number) {
    return Door(
      id: 'door_$number',
      number: number,
      title: _doorTitles[number % _doorTitles.length],
      themeColor: _colors[number % _colors.length],
      lessons: [
        for (var i = 0; i < _lessonCountOf(number); i++) _lesson(number, i),
      ],
    );
  }

  /// ✅ ID = "d{cửa}_l{index}" → unique tuyệt đối, không còn allLessons dùng chung.
  static Lesson _lesson(int doorNumber, int index) => Lesson(
    id: 'd${doorNumber}_l$index',
    title: 'Tiêu đề 1',
    type: _types[(doorNumber + index) % _types.length],
    partCount: 3 + ((doorNumber + index) % 4), // 3..6
  );

  /// 8–14 bài mỗi cửa → đường zigzag trông tự nhiên như Duolingo thật.
  static int _lessonCountOf(int doorNumber) => 8 + (doorNumber % 7);
}