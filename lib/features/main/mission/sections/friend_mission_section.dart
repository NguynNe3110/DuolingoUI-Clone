import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:duolingo_ui_clone/core/widgets/app_progress_linear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../widgets/friend_row.dart';
import '../widgets/section_header.dart';


class FriendMissionSection extends StatelessWidget {
  const FriendMissionSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'NHIỆM VỤ BẠN BÈ', timeLabel: '3 NGÀY'),
          const SizedBox(height: 16),

          // // Ảnh banner bạn bè
          // Container(
          //   height: 160,
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: const Color(0xFFCDE6C0),
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: const Icon(
          //     Icons.people_alt_rounded,
          //     size: 72,
          //     color: Color(0xFF86B977),
          //   ),
          // ),
          Container(
            // decoration: BoxDecoration(
            //   color: const Color(0xFFCDE6C0),
            //   borderRadius: BorderRadius.circular(16),
            // ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                  AppIcon.bannerFriend,
                  width: double.infinity,
                  // height: 42,
                  fit: BoxFit.cover// contain
              ),
            )
          ),
          const SizedBox(height: 20),

          const Text(
            'Kiếm đủ 150 KN',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: AppProgressLinear(progress: 0.2, hint: '5 / 20',)),
              SizedBox(width: 16),
              Image.asset(
                AppIcon.chestFriend,
                width: 48,
              )
            ],
          ),
          const SizedBox(height: 20),

          const FriendRow(
            dotColor: Color(0xFF4CA447),
            name: 'Bạn',
            score: '0 KN',
          ),
          const SizedBox(height: 14),
          const FriendRow(
            dotColor: Color(0xFF1E5C1F),
            name: 'Phương',
            score: '11 KN',
          ),
          const SizedBox(height: 24),


          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'NHẮC NHẸ',
                  iconPath: AppIcon.gem,
                  variant: ButtonVariant.neutral,

                  onPressed: () => {},
                )
              ),
              SizedBox(width: 12),
              Expanded(
                  child: AppButton(
                    label: 'TẶNG QUÀ',
                    iconPath: AppIcon.heart,
                    variant: ButtonVariant.neutral,
                    onPressed: () => {},

                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}