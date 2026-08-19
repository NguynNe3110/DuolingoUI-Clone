import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import 'profile_ui_effect.dart';

/// BaseBloc Mini: Bloc thường chỉ emit State.
/// Ở đây ta thêm StreamController để emit UiEffect riêng biệt.
/// → State sạch, chỉ chứa dữ liệu render UI.
/// → UiEffect xử lý one-time events (navigation, snackbar...).
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final StreamController<ProfileUiEffect> _effectController =
  StreamController<ProfileUiEffect>.broadcast();

  /// Stream để UI lắng nghe effects.
  Stream<ProfileUiEffect> get effectStream => _effectController.stream;

  ProfileBloc() : super(ProfileState.initial()) {
    on<LoadProfile>(_onLoadProfile);
    on<FriendStreakTapped>(_onFriendStreakTapped);
    on<MonthlyBadgesHeaderTapped>(_onMonthlyBadgesHeaderTapped);
    on<AchievementsHeaderTapped>(_onAchievementsHeaderTapped);
    on<CoursesTapped>(_onCoursesTapped);
    on<FollowingTapped>(_onFollowingTapped);
    on<FollowersTapped>(_onFollowersTapped);
    on<SettingsTapped>(_onSettingsTapped);
    on<ShareTapped>(_onShareTapped);
  }

  /// Helper: emit effect mà không làm bẩn State.
  void _emitEffect(ProfileUiEffect effect) {
    if (!_effectController.isClosed) {
      _effectController.add(effect);
    }
  }

  Future<void> _onLoadProfile(
      LoadProfile event,
      Emitter<ProfileState> emit,
      ) async {
    // TODO: Gọi Repository để lấy dữ liệu thật.
    // Hiện tại state đã được khởi tạo với placeholder data.
  }

  void _onFriendStreakTapped(
      FriendStreakTapped event,
      Emitter<ProfileState> emit,
      ) {
    // Logic: icon có người → profile; icon rỗng → mời bạn.
    if (event.friend.isEmpty) {
      _emitEffect(const NavigateToAddFriend());
    } else {
      _emitEffect(NavigateToFriendProfile(friendId: event.friend.id));
    }
  }

  void _onMonthlyBadgesHeaderTapped(
      MonthlyBadgesHeaderTapped event,
      Emitter<ProfileState> emit,
      ) {
    _emitEffect(const NavigateToMonthlyBadges());
  }

  void _onAchievementsHeaderTapped(
      AchievementsHeaderTapped event,
      Emitter<ProfileState> emit,
      ) {
    _emitEffect(const NavigateToAchievements());
  }

  void _onCoursesTapped(CoursesTapped event, Emitter<ProfileState> emit) {
    _emitEffect(const NavigateToCourses());
  }

  void _onFollowingTapped(FollowingTapped event, Emitter<ProfileState> emit) {
    _emitEffect(const NavigateToFollowing());
  }

  void _onFollowersTapped(FollowersTapped event, Emitter<ProfileState> emit) {
    _emitEffect(const NavigateToFollowers());
  }

  void _onSettingsTapped(SettingsTapped event, Emitter<ProfileState> emit) {
    _emitEffect(const NavigateToSettings());
  }

  void _onShareTapped(ShareTapped event, Emitter<ProfileState> emit) {
    _emitEffect(const NavigateToShare());
  }

  @override
  Future<void> close() {
    _effectController.close();
    return super.close();
  }
}