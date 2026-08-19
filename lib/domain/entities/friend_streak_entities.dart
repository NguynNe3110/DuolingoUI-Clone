enum FriendStreakStatus {
  active,      // Đã chấp nhận - hiện flame
  pending,     // Chờ chấp nhận - hiện clock
  empty,       // Slot trống - hiện SVG
}

class FriendStreakEntities {
  final String id;
  final FriendStreakStatus status;
  final String? avatarImage; // null nếu empty
  final String? displayName; // Cho letter avatar
  final int? streakCount;    // Số ngày streak

  const FriendStreakEntities({
    required this.id,
    required this.status,
    this.avatarImage,
    this.displayName,
    this.streakCount,
  });

  bool get isEmpty => status == FriendStreakStatus.empty;
  bool get isPending => status == FriendStreakStatus.pending;
  bool get hasStreak => status == FriendStreakStatus.active;
}
