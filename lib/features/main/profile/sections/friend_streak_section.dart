import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/domain/entities/friend_streak_entities.dart';
import 'package:duolingo_ui_clone/features/main/mission/sections/header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../widgets/section_header_widget.dart';



class FriendStreakSection extends StatelessWidget {
  final List<FriendStreakEntities> friends;
  final void Function(FriendStreakEntities) onTap; // HAY

  const FriendStreakSection({
    super.key,
    required this.friends,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeaderWidget(
            title: 'STREAK BẠN BÈ',
          ),
          const SizedBox(height: 12),
          Row(
            // mainAxisAlignment: MainAxisAlignment.start, // Không cần thiết khi dùng Expanded đều nhau
            children: friends.map((friend) {
              return Expanded(
                child: FriendStreakItem(
                  friend: friend,
                  onTap: () => onTap(friend), // Truyền  friend
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class FriendStreakItem extends StatelessWidget {
  final FriendStreakEntities friend;
  final VoidCallback onTap;

  const FriendStreakItem({
    super.key,
    required this.friend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start, // ✅ Quan trọng
        children: [
          // Avatar container - cố định kích thước
          SizedBox(
            width: 56,
            height: 56,
            child: _buildAvatar(),
          ),
          SizedBox(height: 4,),
          // ✅ Luôn dành space cho streak counter (để không bị lệch)
          SizedBox(
            height: 20, // Chiều cao cố định cho khu vực streak
            child: friend.hasStreak && friend.streakCount != null
                ? _buildStreakCounter()
                : const SizedBox.shrink(), // Widget rỗng nhưng vẫn giữ height
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    if (friend.isEmpty) {
      return _EmptySlotAvatar();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.greenSurface450,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              AppIcon.avatar,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (friend.isPending) const _PendingBadge(),
      ],
    );
  }

  Widget _buildStreakCounter() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppIcon.streak,
          width: 16,
        ),
        const SizedBox(width: 3),
        Text(
          '${friend.streakCount}',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: AppColors.duoOrange,
            height: 1.0,
          ),
        ),
      ],
    );
  }
}

class _EmptySlotAvatar extends StatelessWidget {
  const _EmptySlotAvatar();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE5E5E5),
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: SvgPicture.asset(
          AppIcon.inviteStreakEmpty
        )
      ),
    );
  }
}


class _PendingBadge extends StatelessWidget {
  const _PendingBadge();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -2,
      bottom: -2,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: SvgPicture.asset(
          AppIcon.timeDisable,
          width: 24,
        )
      ),
    );
  }
}
