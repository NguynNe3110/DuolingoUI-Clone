import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/section_header_widget.dart';

const Color _newRed = Color(0xFFFF4B4B);

class AchievementsSection extends StatelessWidget {
  final List<Achievement> achievements;

  const AchievementsSection({
    super.key,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: 'THÀNH TÍCH',
            showArrow: true,
            onTap: () => {}
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: achievements.map((achievement) {
              return _AchievementItem(achievement: achievement);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final Achievement achievement;

  const _AchievementItem({required this.achievement});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Badge circle
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE7E7E7),
          ),
          child: Center(
            child: Image.asset(
              achievement.pathIcon,
              width: 84,
            ),
          ),
        ),
        // "MỚI" label
        // if (achievement.isNew)
        //   Positioned(
        //     top: -4,
        //     left: 0,
        //     right: 0,
        //     child: Center(
        //       child: Container(
        //         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        //         decoration: BoxDecoration(
        //           color: _newRed,
        //           borderRadius: BorderRadius.circular(4),
        //         ),
        //         child: const Text(
        //           'MỚI',
        //           style: TextStyle(
        //             fontSize: 9,
        //             fontWeight: FontWeight.bold,
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}