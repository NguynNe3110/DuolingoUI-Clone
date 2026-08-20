import '../../domain/entities/friend_streak_entities.dart';

class MockFriendStreak {
  static final List<FriendStreakEntities> friends = [
    const FriendStreakEntities(
      id: 'user_v',
      status: FriendStreakStatus.active,
      displayName: 'V',
      streakCount: 1,
    ),
    FriendStreakEntities(
      id: 'friend_1',
      status: FriendStreakStatus.pending, // Chờ chấp nhận
      avatarImage: 'assets/avatar_friend.png',
    ),
    const FriendStreakEntities(
      id: 'empty_1',
      status: FriendStreakStatus.empty,
    ),
    const FriendStreakEntities(
      id: 'empty_2',
      status: FriendStreakStatus.empty,
    ),
    const FriendStreakEntities(
      id: 'empty_3',
      status: FriendStreakStatus.empty,
    ),
  ];
}