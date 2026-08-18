
import 'package:duolingo_ui_clone/domain/entities/user_entities.dart';

class FriendStreakEntities {
  final UserEntities users;
  final int friendStreak;

  const FriendStreakEntities({
    required this.users,
    required this.friendStreak,

  });
}