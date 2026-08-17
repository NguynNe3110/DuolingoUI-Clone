import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/material.dart';

import '../../../../data/mock_data/mock_leaderboard.dart';
import '../../../../domain/entities/leaderboard_user.dart';
import '../sections/leaderboard_header.dart';
import '../widgets/boost_fab.dart';
import '../widgets/group_footer.dart';
import '../widgets/leaderboard_item.dart';
import '../widgets/rank_bagde.dart';

/// =====================================================================
/// LEADERBOARD SCREEN — Màn hình "Giải đấu"
/// Map Kotlin: LeaderboardFragment.kt
/// Áp dụng: Bài 5.2 (ListView.builder), 5.3 (tách item),
///          5.6 (setState), 5.7 (ScrollController)
/// =====================================================================

// ----------------------------- SCREEN --------------------------------
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  final _users = LeaderboardState.mock;

  @override
  void initState() {
    super.initState();
    // Map Kotlin: recyclerView.addOnScrollListener(...)
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 0;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled); // Map: notifyDataSetChanged()
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        // ⭐ Header nằm NGOÀI ListView → không biến mất khi cuộn
        child: Column(
          children: [
            LeaderboardHeader(elevated: _isScrolled),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _users.length + 2, // +2 footer thăng/rớt hạng
                itemBuilder: (context, index) {
                  if (index == _users.length) {
                    return const GroupFooter(isPromotion: true);
                  }
                  if (index == _users.length + 1) {
                    return const GroupFooter(isPromotion: false);
                  }
                  return LeaderboardItem(user: _users[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const BoostFab(),
    );
  }
}
