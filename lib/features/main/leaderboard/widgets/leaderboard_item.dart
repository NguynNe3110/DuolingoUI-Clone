import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/features/main/leaderboard/widgets/rank_bagde.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/entities/leaderboard_user.dart';


class LeaderboardItem extends StatelessWidget {
  final LeaderboardUser user;

  const LeaderboardItem({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ⭐ Highlight dòng của chính bạn
      color: user.isMe ? AppColors.greenSurface200 : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 28, child: RankBadge(rank: user.rank)),
          const SizedBox(width: 10),
          _Avatar(user: user),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textOnBackground,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      user.course,
                      width: 18,
                    ),
                    if (user.courseGrade > 0) ...[
                      const SizedBox(width: 6),
                      Text(
                        '${user.courseGrade}',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGrayOnBackground,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${user.kn} KN',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: user.isMe ? AppColors.textGreenOnSurface200 : AppColors.textGrayOnBackground,
            ),
          ),
        ],
      ),
    );
  }
}

// dùng stack để vẽ trạng thái hđ
class _Avatar extends StatelessWidget {
  final LeaderboardUser user;

  const _Avatar({required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          user.avatar,
          width: 48,
        ),
        if(user.isActive)
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.duoGreen,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.greenSurface200, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}