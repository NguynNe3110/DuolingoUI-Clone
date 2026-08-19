/// UiEffect: One-time UI events (navigation, snackbar, dialog...)
/// KHÔNG nằm trong State — đây là triết lý "Production Concept" bạn đang theo.
sealed class ProfileUiEffect {
  const ProfileUiEffect._();
}

// --- Navigation Effects ---
class NavigateToFriendProfile extends ProfileUiEffect {
  final String friendId;
  const NavigateToFriendProfile({required this.friendId}) : super._();
}

class NavigateToAddFriend extends ProfileUiEffect {
  const NavigateToAddFriend() : super._();
}

class NavigateToMonthlyBadges extends ProfileUiEffect {
  const NavigateToMonthlyBadges() : super._();
}

class NavigateToAchievements extends ProfileUiEffect {
  const NavigateToAchievements() : super._();
}

class NavigateToCourses extends ProfileUiEffect {
  const NavigateToCourses() : super._();
}

class NavigateToFollowing extends ProfileUiEffect {
  const NavigateToFollowing() : super._();
}

class NavigateToFollowers extends ProfileUiEffect {
  const NavigateToFollowers() : super._();
}

class NavigateToSettings extends ProfileUiEffect {
  const NavigateToSettings() : super._();
}

class NavigateToShare extends ProfileUiEffect {
  const NavigateToShare() : super._();
}