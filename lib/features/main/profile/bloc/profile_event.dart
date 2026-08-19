import 'package:duolingo_ui_clone/features/main/profile/bloc/profile_state.dart';

sealed class ProfileEvent {
  const ProfileEvent._();
}

class LoadProfile extends ProfileEvent {
  const LoadProfile() : super._();
}

class FriendStreakTapped extends ProfileEvent {
  final FriendStreak friend;
  const FriendStreakTapped({required this.friend}) : super._();
}

class MonthlyBadgesHeaderTapped extends ProfileEvent {
  const MonthlyBadgesHeaderTapped() : super._();
}

class AchievementsHeaderTapped extends ProfileEvent {
  const AchievementsHeaderTapped() : super._();
}

class CoursesTapped extends ProfileEvent {
  const CoursesTapped() : super._();
}

class FollowingTapped extends ProfileEvent {
  const FollowingTapped() : super._();
}

class FollowersTapped extends ProfileEvent {
  const FollowersTapped() : super._();
}

class SettingsTapped extends ProfileEvent {
  const SettingsTapped() : super._();
}

class ShareTapped extends ProfileEvent {
  const ShareTapped() : super._();
}