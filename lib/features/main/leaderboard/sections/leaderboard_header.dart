
import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../widgets/trophy_icon.dart';

class LeaderboardHeader extends StatelessWidget {
  final bool elevated;

  const LeaderboardHeader({required this.elevated});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Giải đấu Lam Ngọc',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3C3C3C),
              ),
            ),
          ),
           Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcon.timeDisable,
                  width: 18,
                ),
                SizedBox(width: 6),
                Text(
                  '5 NGÀY',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    color: AppColors.textGrayOnBackground,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 96,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                TrophyIcon(pathIcon: AppIcon.imgTrophyCopper),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophySliver),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyGold),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyTurquoise, isCurrent: true,),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyBlock),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyBlock),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyBlock),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyBlock),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyBlock),              // đồng
                TrophyIcon(pathIcon: AppIcon.imgTrophyBlock),              // đồng

              ],
            ),
          ),

          // viền chỉ hiện khi cuộn
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            color: elevated ? AppColors.grayBorder200 : Colors.transparent,
          ),
        ],
      ),
    );
  }
}