import 'package:flutter/cupertino.dart';

enum LessonStatus { locked, current, done }

class LessonNode {
  const LessonNode({
    required this.id,
    required this.icon,
    this.status = LessonStatus.locked,
    this.progress = 0.0, // 0..1
    this.segments = 3,   // số "phần" của bài = số khúc cung của vòng
  });

  final int id;
  final IconData icon;
  final LessonStatus status;
  final double progress;
  final int segments;
}