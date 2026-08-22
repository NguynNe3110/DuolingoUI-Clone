import '../../domain/entities/lesson_entities.dart';

class MockHomeTree {
  static HomeTree build() {
    final section1 = Section(
      id: 'section_1',
      number: '1',
      title: 'Phần 1',
      description: 'Học các từ vựng cơ bản và cách chào hỏi.',
      doors: [
        Door(
          id: 'door_1',
          number: 1,
          title: 'Giới thiệu gốc gác',
          themeColor: DomainThemeColor.green,
          lessons: const [
            Lesson(id: '0', title: 'Bài 1', type: DomainLessonType.star, partCount: 4),
            Lesson(id: '1', title: 'Bài 2', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '2', title: 'Bài 3', type: DomainLessonType.headphone, partCount: 5),
            Lesson(id: '3', title: 'Bài 4', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '4', title: 'Bài 5', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '5', title: 'Bài 6', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '6', title: 'Bài 7', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '7', title: 'Bài 8', type: DomainLessonType.video, partCount: 6),
            Lesson(id: '8', title: 'Bài 9', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '9', title: 'Bài 10', type: DomainLessonType.book, partCount: 5),
            Lesson(id: '10', title: 'Bài 11', type: DomainLessonType.weight, partCount: 3),
            Lesson(id: '11', title: 'Bài 12', type: DomainLessonType.star, partCount: 5),
            Lesson(id: '12', title: 'Bài 13', type: DomainLessonType.video, partCount: 4),
            Lesson(id: '13', title: 'Bài 14', type: DomainLessonType.book, partCount: 3),
            Lesson(id: '14', title: 'Bài 15', type: DomainLessonType.headphone, partCount: 6),
            Lesson(id: '15', title: 'Bài 16', type: DomainLessonType.weight, partCount: 5),
            Lesson(id: '16', title: 'Bài 17', type: DomainLessonType.star, partCount: 4),
          ],
        ),
        Door(
          id: 'door_2',
          number: 2,
          title: 'Chào hỏi cơ bản',
          themeColor: DomainThemeColor.blue,
          lessons: const [
            Lesson(id: '17', title: 'Bài 18', type: DomainLessonType.star, partCount: 4),
            Lesson(id: '18', title: 'Bài 19', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '19', title: 'Bài 20', type: DomainLessonType.headphone, partCount: 5),
            Lesson(id: '20', title: 'Bài 21', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '21', title: 'Bài 22', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '22', title: 'Bài 23', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '23', title: 'Bài 24', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '24', title: 'Bài 25', type: DomainLessonType.video, partCount: 6),
            Lesson(id: '25', title: 'Bài 26', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '26', title: 'Bài 27', type: DomainLessonType.book, partCount: 5),
          ],
        ),
      ],
    );

    final section2 = Section(
      id: 'section_2',
      number: '2',
      title: 'Phần 2',
      description: 'Tìm hiểu về các thành viên trong gia đình.',
      doors: [
        Door(
          id: 'door_3',
          number: 3,
          title: 'Gia đình của tôi',
          themeColor: DomainThemeColor.pink,
          lessons: const [
            Lesson(id: '27', title: 'Bài 28', type: DomainLessonType.book, partCount: 6),
            Lesson(id: '28', title: 'Bài 29', type: DomainLessonType.video, partCount: 5),
            Lesson(id: '29', title: 'Bài 30', type: DomainLessonType.headphone, partCount: 3),
            Lesson(id: '30', title: 'Bài 31', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '31', title: 'Bài 32', type: DomainLessonType.star, partCount: 6),
            Lesson(id: '32', title: 'Bài 33', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '33', title: 'Bài 34', type: DomainLessonType.book, partCount: 5),
            Lesson(id: '34', title: 'Bài 35', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '35', title: 'Bài 36', type: DomainLessonType.weight, partCount: 6),
            Lesson(id: '36', title: 'Bài 37', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '37', title: 'Bài 38', type: DomainLessonType.video, partCount: 5),
            Lesson(id: '38', title: 'Bài 39', type: DomainLessonType.book, partCount: 4),
            Lesson(id: '39', title: 'Bài 40', type: DomainLessonType.headphone, partCount: 5),
          ],
        ),
        Door(
          id: 'door_4',
          number: 4,
          title: 'Hoạt động gia đình',
          themeColor: DomainThemeColor.red,
          lessons: const [
            Lesson(id: '40', title: 'Bài 40', type: DomainLessonType.star, partCount: 4),
            Lesson(id: '41', title: 'Bài 41', type: DomainLessonType.book, partCount: 5),
            Lesson(id: '42', title: 'Bài 42', type: DomainLessonType.headphone, partCount: 3),
            Lesson(id: '43', title: 'Bài 43', type: DomainLessonType.video, partCount: 6),
            Lesson(id: '44', title: 'Bài 44', type: DomainLessonType.weight, partCount: 4),
          ],
        ),
      ],
    );

    final section3 = Section(
      id: 'section_3',
      number: '3',
      title: 'Phần 3',
      description: 'Tham gia lễ hội âm nhạc và học từ vựng mới.',
      doors: [
        Door(
          id: 'door_5',
          number: 5,
          title: 'Lễ hội âm nhạc',
          themeColor: DomainThemeColor.blue,
          lessons: const [
            Lesson(id: '45', title: 'Bài 41', type: DomainLessonType.headphone, partCount: 4),
            Lesson(id: '46', title: 'Bài 42', type: DomainLessonType.video, partCount: 5),
            Lesson(id: '47', title: 'Bài 43', type: DomainLessonType.star, partCount: 3),
            Lesson(id: '48', title: 'Bài 44', type: DomainLessonType.book, partCount: 6),
            Lesson(id: '49', title: 'Bài 45', type: DomainLessonType.weight, partCount: 4),
            Lesson(id: '50', title: 'Bài 46', type: DomainLessonType.headphone, partCount: 5),
            Lesson(id: '51', title: 'Bài 47', type: DomainLessonType.video, partCount: 3),
            Lesson(id: '52', title: 'Bài 48', type: DomainLessonType.star, partCount: 4),
          ],
        ),
      ],
    );

    const progress = UserProgress(
      completedLessonIds: {'0', '1', '17', '18'},
      currentLessonId: '2',
      completedParts: {'2': 2, '19': 3},
    );

    final course = Course(
      id: 'course_english',
      title: 'Tiếng Anh',
      sections: [section1, section2, section3],
    );

    return HomeTree(course: course, progress: progress);
  }
}
