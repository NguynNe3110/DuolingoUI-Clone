import 'package:duolingo_ui_clone/data/mock_data/mock_header_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';
import '../../../../core/theme/app_text_theme.dart';

/// Widget dùng chung – tương đương @Composable fun HeaderItem(...) bên Kotlin
class HeaderItem extends StatelessWidget {
  const HeaderItem({
    super.key,
    required this.icon,
    required this.value,
    required this.onTap,
    this.iconWidth = 18,
    this.valueColor,
  });

  final String icon;
  final String value;
  final VoidCallback onTap;
  final double iconWidth;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12), // tap target >= 48dp
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon, width: iconWidth),
            const SizedBox(width: 8),
            Text(
              value,
              style: AppTextTheme.light.labelLarge?.copyWith(
                color: valueColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onFlagTap,
    required this.onStreakTap,
    required this.onGemTap,
    required this.onEnergyTap,
  });

  final VoidCallback onFlagTap;
  final VoidCallback onStreakTap;
  final VoidCallback onGemTap;
  final VoidCallback onEnergyTap;

  @override
  Widget build(BuildContext context) {
    // Giống collectAsStateWithLifecycle() bên Kotlin: UI tự rebuild khi state đổi
    // return BlocBuilder<UserStatsCubit, UserStatsState>(
    //   builder: (context, state) {
    //     final s = state.stats;
    //     return Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceAround,
    //       children: [
    //         HeaderItem(icon: AppIcon.flagFrench, iconWidth: 24,
    //             value: '${s.courseXp}', onTap: onFlagTap),
    //         HeaderItem(icon: AppIcon.streak, value: '${s.streak}',
    //             valueColor: AppColors.duoOrange, onTap: onStreakTap),
    //         HeaderItem(icon: AppIcon.gem, value: '${s.gems}',
    //             valueColor: AppColors.duoBlue, onTap: onGemTap),
    //         HeaderItem(icon: AppIcon.battery, iconWidth: 32, value: '${s.energy}',
    //             valueColor: AppColors.duoPink, onTap: onEnergyTap),
    //       ],
    //     );
    //   },
    // );

    // final a = MockHeaderHome;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grayBorder200, width: 2), )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HeaderItem(
              icon: AppIcon.flagFrance,
              iconWidth: 24,
              value: '${MockHeaderHome.courseXp}',
              onTap: onFlagTap
          ),
          HeaderItem(
              icon: AppIcon.streak,
              value: '${MockHeaderHome.streak}',
              valueColor: AppColors.duoOrange,
              onTap: onStreakTap
          ),
          HeaderItem(
              icon: AppIcon.gem,
              value: '${MockHeaderHome.gems}',
              valueColor: AppColors.duoBlue,
              onTap: onGemTap
          ),
          HeaderItem(
              icon: AppIcon.battery,
              iconWidth: 32,
              value: '${MockHeaderHome.energy}',
              valueColor: AppColors.duoPink,
              onTap: onEnergyTap
          ),
        ],
      ),
    );


  }
}