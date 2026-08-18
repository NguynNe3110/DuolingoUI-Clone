
import 'dart:ffi';

import 'package:duolingo_ui_clone/domain/entities/user_entities.dart';

class UserProfileEntities {
  final UserEntities user;
  final int joinTimeYear;
  final int countFollow;
  final int countFollower;
  final int currentStreak;
  final int courseGrade;
  final String currentLeaderboard;
  final int totalKN;


  const UserProfileEntities({
    required this.user,
    required this.joinTimeYear,
    required this.courseGrade,
    required this.countFollow,
    required this.countFollower,
    required this.currentLeaderboard,
    required this.currentStreak,
    required this.totalKN,
  });
}
