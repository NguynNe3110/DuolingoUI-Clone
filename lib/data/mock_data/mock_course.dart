// feature/main/home/widgets/course_switcher_state.dart
// (Sau này Course sẽ chuyển xuống domain/entities, mock chuyển xuống data/)
import '../../core/theme/app_icon.dart';

class MockCourse {
  const MockCourse({
    required this.id,
    required this.name,
    required this.icon,
  });

  final String id;
  final String name;
  final String icon;
}

class CourseSwitcherState {
  const CourseSwitcherState({
    required this.courses,
    required this.selectedCourseId,
  });

  final List<MockCourse> courses;
  final String selectedCourseId;

  /// Data mẫu để dựng UI khi chưa nối Bloc/Repository
  static const CourseSwitcherState mock = CourseSwitcherState(
    courses: [
      MockCourse(id: 'en',    name: 'Tiếng Anh',          icon: AppIcon.flagUnitedState),
      MockCourse(id: 'cn',    name: 'Tiếng Canada',   icon: AppIcon.flagCanada),
      MockCourse(id: 'vi',  name: 'Tiếng Việt',               icon: AppIcon.flagVietNam),
      MockCourse(id: 'ru', name: 'Tiếng Nga',             icon: AppIcon.flagRussia),
    ],
    selectedCourseId: 'en',
  );

  CourseSwitcherState copyWith({
    List<MockCourse>? courses,
    String? selectedCourseId,
  }) {
    return CourseSwitcherState(
      courses: courses ?? this.courses,
      selectedCourseId: selectedCourseId ?? this.selectedCourseId,
    );
  }
}