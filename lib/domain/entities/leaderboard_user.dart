import 'dart:ui';

class LeaderboardUser {
  final int rank;
  final String name;
  final int kn;
  final int courseGrade;
  final String course;
  final String avatar;
  final bool isMe;
  final bool isActive;

  const LeaderboardUser({
    required this.rank,
    required this.name,
    required this.kn,
    this.courseGrade = 0,
    required this.course,
    required this.avatar,
    this.isMe = false,
    this.isActive = false,
  });
}