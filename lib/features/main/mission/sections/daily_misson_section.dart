import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../../../../core/widgets/app_progress_linear.dart';
import '../widgets/section_header.dart';

class DailyMissionSection extends StatelessWidget {
  const DailyMissionSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SectionHeader(title: 'NHIỆM VỤ HẰNG NGÀY', timeLabel: '5 GIỜ'),
          SizedBox(height: 24),
          _MissionItem(title: 'Kiếm 20 KN',progress: 0.2, pathIcon: AppIcon.chestWood,hint: '4 / 20',),
          SizedBox(height: 28),
          _MissionItem(title: 'Hoàn thành 3 bài nghe',progress: 0.33, pathIcon: AppIcon.chestGold, hint: '1 / 3'),
          SizedBox(height: 28),
          _MissionItem(title: 'Đạt 2 bài học đúng 90%',progress: 0.5, pathIcon: AppIcon.chestLegend, hint: '1 / 2'),
        ],
      ),
    );
  }
}

class _MissionItem extends StatelessWidget {
  final String title;
  final double progress;
  final String pathIcon;
  final String hint;

  const _MissionItem({
    required this.title,
    required this.progress,
    required this.pathIcon,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 8),
              AppProgressLinear(
                progress: progress,
                hint: hint,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Image.asset(
          pathIcon,
          width: 48,
          height: 48,
        ),
      ],
    );
  }
}