import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';

/// Huy chương top 3 / số hạng thường
class RankBadge extends StatelessWidget {
  final int rank;

  const RankBadge({required this.rank});

  @override
  Widget build(BuildContext context) {
    if (rank <= 3) {
      return Image.asset(
        AppIcon.medalForRank(rank),
        width: 26,
        height: 26,
      );
    }
    return Text(
      '$rank',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textGreenOnSurface200,
      ),
    );
  }
}