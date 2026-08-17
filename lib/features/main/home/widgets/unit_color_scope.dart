import 'package:duolingo_ui_clone/features/main/home/widgets/app_lesson_node.dart';
import 'package:flutter/cupertino.dart';

class UnitColorScope extends InheritedWidget {
  const UnitColorScope({super.key, required this.color, required super.child});
  final LessonNodeColor color;

  // Dùng khi muốn lấy màu, nhưng không bắt buộc phải có Scope (tránh crash)
  static LessonNodeColor? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UnitColorScope>()?.color;
  }

  // Dùng khi bắt buộc phải có Scope (sẽ assert ở debug mode nếu thiếu)
  static LessonNodeColor of(BuildContext context) {
    final color = maybeOf(context);
    assert(color != null, 'AppLessonNode phải nằm trong UnitColorScope hoặc được truyền unitColor');
    return color!;
  }

  @override
  bool updateShouldNotify(UnitColorScope oldWidget) => color != oldWidget.color;
}
