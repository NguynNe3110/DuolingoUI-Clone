// lib/domain/usecases/resolve_node_status_usecase.dart

import '../entities/lesson_entities.dart';

// lib/domain/usecases/resolve_node_status_usecase.dart

import '../entities/lesson_entities.dart';

class ResolveNodeStatusUseCase {
  DomainNodeStatus call({
    required Lesson lesson,
    required Door door,
    required HomeTree tree,
    required UserProgress progress,
  }) {
    // 1. Bài đang học
    if (progress.currentLessonId == lesson.id) return DomainNodeStatus.current;

    // 2. Bài đã hoàn thành
    if (progress.isLessonCompleted(lesson.id)) return DomainNodeStatus.completed;

    // 3. Học vượt
    if (_isLearnAhead(lesson, door, tree, progress)) {
      return DomainNodeStatus.learnAhead;
    }

    // 4. MỌI thứ còn lại (kể cả bài ngay sau current) đều locked
    return DomainNodeStatus.locked;
  }

  bool _isLearnAhead(
      Lesson lesson,
      Door door,
      HomeTree tree,
      UserProgress progress,
      ) {
    // Chỉ node ĐẦU của một cửa mới được là node học vượt
    if (door.lessons.isEmpty || door.lessons.first.id != lesson.id) return false;

    // Duyệt cửa theo thứ tự toàn cây (xuyên section)
    final allDoors = [for (final s in tree.course.sections) ...s.doors];
    final currentDoorIndex = allDoors.indexWhere(
          (d) => d.lessons.any((l) => l.id == progress.currentLessonId),
    );
    final doorIndex = allDoors.indexOf(door);

    // Node học vượt = node đầu của cửa NGAY SAU cửa hiện tại,
    // bất kể tiến độ trong cửa hiện tại ra sao.
    // (Muốn MỌI cửa khóa đều có node học vượt? đổi thành: doorIndex > currentDoorIndex)
    return doorIndex == currentDoorIndex + 1;
  }
}

//   bool _isAvailable(Lesson lesson, Door door, UserProgress progress) {
//     final currentIndex = door.lessons.indexWhere((l) => l.id == progress.currentLessonId);
//     final myIndex = door.lessons.indexWhere((l) => l.id == lesson.id);
//
//     // Bài nằm ngay sau bài current thì available
//     return currentIndex >= 0 && myIndex == currentIndex + 1;
//   }
// }