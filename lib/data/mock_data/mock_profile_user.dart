

import 'package:duolingo_ui_clone/domain/entities/user_entities.dart';
import 'package:duolingo_ui_clone/domain/entities/user_profile_entities.dart';

class MockProfileUser {
  static final UserProfileEntities mock = UserProfileEntities(
      user: UserEntities(
          name: 'T Nguyên<3',
      ),
      joinTimeYear: 2025,
      courseGrade: 28,
      countFollow: 25,
      countFollower: 38,
      currentLeaderboard: 'Lam Ngọc',
      currentStreak: 6,
      totalKN: 37496
  );
}