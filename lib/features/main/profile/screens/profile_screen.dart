import 'dart:async';
import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/features/main/profile/sections/profile_state_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../../../../domain/entities/friend_streak_entities.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../bloc/profile_ui_effect.dart';
import '../sections/achievements_section.dart';
import '../sections/friend_streak_section.dart';
import '../sections/month_badges_section.dart';
import '../sections/profile_header_section.dart';
import '../sections/profile_overview_section.dart';
import '../widgets/banner_widget.dart';
import '../widgets/section_header_widget.dart';


// ============================================================
// Constants
// ============================================================
const double _bannerHeight = 180;
const double _headerHeight = 56;
const double _bottomNavHeight = 64;

const Color _newRed = Color(0xFFFF4B4B);

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(const LoadProfile()),
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatefulWidget {
  const _ProfileScreenContent();

  @override
  State<_ProfileScreenContent> createState() => _ProfileScreenContentState();
}

class _ProfileScreenContentState extends State<_ProfileScreenContent> {
  final ScrollController _scrollController = ScrollController();

  // Scroll flags cho header animation
  bool _showBorder = false;
  bool _isPastBanner = false;

  late StreamSubscription<ProfileUiEffect> _effectSubscription;

  final List<FriendStreakEntities> friends = [
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

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Lắng nghe UiEffect stream từ BLoC
    _effectSubscription =
        context
            .read<ProfileBloc>()
            .effectStream
            .listen(_handleEffect);
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final newShowBorder = offset > 0;
    final newIsPastBanner = offset >= _bannerHeight;

    // Chỉ setState khi có thay đổi → tránh rebuild không cần thiết
    if (newShowBorder != _showBorder || newIsPastBanner != _isPastBanner) {
      setState(() {
        _showBorder = newShowBorder;
        _isPastBanner = newIsPastBanner;
      });
    }
  }

  /// Xử lý UiEffect → Navigation (placeholder, bạn thay route thật sau).
  void _handleEffect(ProfileUiEffect effect) {
    switch (effect) {
      case NavigateToFriendProfile(:final friendId):
        _navigateTo('/friend-profile/$friendId');
      case NavigateToAddFriend():
        _navigateTo('/add-friend');
      case NavigateToMonthlyBadges():
        _navigateTo('/monthly-badges');
      case NavigateToAchievements():
        _navigateTo('/achievements');
      case NavigateToCourses():
        _navigateTo('/courses');
      case NavigateToFollowing():
        _navigateTo('/following');
      case NavigateToFollowers():
        _navigateTo('/followers');
      case NavigateToSettings():
        _navigateTo('/settings');
      case NavigateToShare():
      // TODO: Implement share sheet
        debugPrint('Share tapped');
    }
  }

  void _navigateTo(String route) {
    // Placeholder navigation — bạn thay bằng GoRouter hoặc route thật.
    debugPrint('Navigate to: $route');
    // Navigator.pushNamed(context, route);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: AppColors.background,
            child: Stack(
              children: [
                // --- Scrollable Content ---
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: _headerHeight), // Chừa chỗ cho header
                          const BannerWidget(),
                          ProfileStateSection(state: state,),
                          ProfileOverviewSection(state: state),

                          FriendStreakSection(
                            friends: friends,
                            onTap: (friend) {},
                          ),

                          MonthlyBadgesSection(
                              monthlyBadges: state.monthlyBadges),
                          AchievementsSection(achievements: state.achievements),


                          SizedBox(height: _bottomNavHeight + 16),
                        ],
                      ),
                    );
                  },
                ),

                // --- Sticky Header ---
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ProfileHeaderSection(
                    scrollController: _scrollController,
                    backgroundColor: AppColors.greenSurface450,
                    borderColor: AppColors.duoGreenDarkSecondary,
                    isPastBanner: _isPastBanner,
                  ),
                ),
              ],
            ),
          )
        )
    );
  }
}
