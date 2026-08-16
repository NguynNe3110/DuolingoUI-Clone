// lib/presentation/mappers/lesson_node_mapper.dart

import '../../domain/entities/lesson_entities.dart';
import '../../features/main/home/widgets/app_lesson_node.dart';
import '../../features/main/home/widgets/lesson_node_data.dart';

class LessonNodeMapper {
  /// Chuyển đổi từ Domain Entity sang UI ViewData
  /// Đây là "cây cầu" giúp UI không phụ thuộc vào Domain
  static LessonNodeData toViewData({
    required Lesson lesson,
    required Door door,
    required DomainNodeStatus domainStatus,
    required UserProgress progress,
  }) {
    return LessonNodeData(
      id: int.tryParse(lesson.id) ?? 0,
      type: _mapLessonType(lesson.type),
      title: lesson.title,
      color: _mapThemeColor(door.themeColor),
      status: _mapNodeStatus(domainStatus),
      progress: progress.getRingProgress(lesson),
      partCount: lesson.partCount, // Đổi tên từ 'segments' thành 'partCount' cho rõ nghĩa
    );
  }

  static LessonNodeColor mapThemeColorForScope(DomainThemeColor color) {
    return _mapThemeColor(color);
  }

  static LessonNodeType _mapLessonType(DomainLessonType type) {
    return switch (type) {
      DomainLessonType.star => LessonNodeType.star,
      DomainLessonType.book => LessonNodeType.book,
      DomainLessonType.headphone => LessonNodeType.headphone,
      DomainLessonType.video => LessonNodeType.video,
      DomainLessonType.weight => LessonNodeType.weight,
    };
  }

  static LessonNodeColor _mapThemeColor(DomainThemeColor color) {
    return switch (color) {
      DomainThemeColor.green => LessonNodeColor.Green,
      DomainThemeColor.blue => LessonNodeColor.Blue,
      DomainThemeColor.red => LessonNodeColor.Red,
      DomainThemeColor.orange => LessonNodeColor.Orange,
      DomainThemeColor.cyan => LessonNodeColor.Cyan,
      DomainThemeColor.violet => LessonNodeColor.Violet,
      DomainThemeColor.brown => LessonNodeColor.Brown,
      DomainThemeColor.pink => LessonNodeColor.Pink,
      DomainThemeColor.purple => LessonNodeColor.Purple,
    };
  }

  static LessonNodeStatus _mapNodeStatus(DomainNodeStatus status) {
    return switch (status) {
      DomainNodeStatus.locked => LessonNodeStatus.locked,
      DomainNodeStatus.learnAhead => LessonNodeStatus.learnAhead,
      // DomainNodeStatus.available => LessonNodeStatus.available,
      DomainNodeStatus.current => LessonNodeStatus.current,
      DomainNodeStatus.completed => LessonNodeStatus.done,
    };
  }
}