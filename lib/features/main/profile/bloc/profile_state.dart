// ============================================================
// State chỉ chứa dữ liệu thuần để vẽ UI.
// KHÔNG chứa: message, navigate, isLoading flag riêng lẻ...
// ============================================================

import '../../../../core/theme/app_icon.dart';

class ProfileState {
  final String username;
  final String handle;
  final String joinYear;
  final int followingCount;
  final int followerCount;
  final int streakDays;
  final int courseLevel;
  final String league;
  final int xp;
  final List<FriendStreak> friendStreaks;
  final List<MonthlyBadge> monthlyBadges;
  final List<Achievement> achievements;

  const ProfileState({
    required this.username,
    required this.handle,
    required this.joinYear,
    required this.followingCount,
    required this.followerCount,
    required this.streakDays,
    required this.courseLevel,
    required this.league,
    required this.xp,
    required this.friendStreaks,
    required this.monthlyBadges,
    required this.achievements,
  });

  /// Placeholder data — sau này thay bằng dữ liệu từ Repository.
  factory ProfileState.initial() => ProfileState(
    username: 'T Nguyên<3',
    handle: '@TRANNGUYEN3110',
    joinYear: '2025',
    followingCount: 38,
    followerCount: 25,
    streakDays: 6,
    courseLevel: 28,
    league: 'Lam Ngọc',
    xp: 37496,
    friendStreaks: [
      FriendStreak(
        id: 'v_user',
        name: 'V',
        avatar: null, // Dùng chữ "V" thay vì ảnh
        isLetterAvatar: true,
        hasStreak: true,
        streakCount: 1,
      ),
      FriendStreak(
        id: 'friend_001',
        name: 'Friend',
        avatar: 'assets/avatar_friend.png',
        isLetterAvatar: false,
        hasStreak: false,
        streakCount: 0,
        hasCheckmark: true,
      ),
      const FriendStreak.empty(id: 'empty_1'),
      const FriendStreak.empty(id: 'empty_2'),
      const FriendStreak.empty(id: 'empty_3'),
    ],
    monthlyBadges: [
      MonthlyBadge(id: 'b1', pathIcon: AppIcon.badgeMonth1, isUnlocked: true),
      MonthlyBadge(id: 'b2', pathIcon: AppIcon.badgeMonth2, isUnlocked: true),
      MonthlyBadge(id: 'b3', pathIcon: AppIcon.badgeMonth3, isUnlocked: true),
      MonthlyBadge(id: 'b4', pathIcon: AppIcon.badgeMonth4, isUnlocked: true),
    ],
    achievements: [
      Achievement(id: 'a1',pathIcon: AppIcon.achievementDiscover, isNew: true),
      Achievement(id: 'a2',pathIcon: AppIcon.achievementMorning, isNew: true),
      Achievement(id: 'a3',pathIcon: AppIcon.achievementOwl, isNew: true),
      Achievement(id: 'a4',pathIcon: AppIcon.achievementStreak, isNew: true),

    ],
  );
}


class FriendStreak {
  final String id;
  final String name;
  final String? avatar;
  final bool isLetterAvatar;
  final bool hasStreak;
  final int streakCount;
  final bool hasCheckmark;

  const FriendStreak({
    required this.id,
    required this.name,
    this.avatar,
    this.isLetterAvatar = false,
    required this.hasStreak,
    required this.streakCount,
    this.hasCheckmark = false,
  });

  const FriendStreak.empty({required this.id})
      : name = '',
        avatar = null,
        isLetterAvatar = false,
        hasStreak = false,
        streakCount = 0,
        hasCheckmark = false;

  /// Slot rỗng = chưa có bạn → tap sẽ navigate đến màn hình mời bạn.
  bool get isEmpty => avatar == null && !isLetterAvatar;
}

class MonthlyBadge {
  final String id;
  final String pathIcon;
  final bool isUnlocked;

  const MonthlyBadge({
    required this.id,
    required this.pathIcon,
    required this.isUnlocked,
  });
}

class Achievement {
  final String id;
  final bool isNew;
  final String pathIcon;

  const Achievement({
    required this.id,
    required this.isNew,
    required this.pathIcon,
  });
}