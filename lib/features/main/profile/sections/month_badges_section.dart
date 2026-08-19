import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/section_header_widget.dart';

class MonthlyBadgesSection extends StatelessWidget {
  final List<MonthlyBadge> monthlyBadges;

  const MonthlyBadgesSection({
    super.key,
    required this.monthlyBadges,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: 'HUY HIỆU THỬ THÁCH THÁNG',
            showArrow: true,
            onTap: () => {},
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: monthlyBadges.map((badge) {
              return _MonthlyBadgeItem(badge: badge);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _MonthlyBadgeItem extends StatelessWidget {
  final MonthlyBadge badge;

  const _MonthlyBadgeItem({required this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: badge.isUnlocked
      //       ? const Color(0xFFE7E7E7)
      //       : const Color(0xFFE7E7E7),
      // ),
      child: Center(
        child: Image.asset(
          badge.pathIcon,
          width: 88,
        ),
      ),
    );
  }
}