import 'package:duolingo_ui_clone/core/widgets/app_progress_linear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_icon.dart';


class HeaderSection extends StatelessWidget {
  const HeaderSection();

  @override
  Widget build(BuildContext context) {
    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      color: const Color(0xFF4CA447),
      padding: EdgeInsets.fromLTRB(24, topPadding + 24, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nhiệm vụ tháng Tám',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset(
                AppIcon.timeDisable,
                width: 20,
              ),
              SizedBox(width: 6),
              Text(
                '14 NGÀY',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 20),

          // 🐻 Kỹ thuật câu trước: Stack + Positioned
          // Gấu khai báo TRƯỚC → nằm DƯỚI → card trắng đè lên thân dưới
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -45,
                right: 12,
                child: SvgPicture.asset(
                  AppIcon.duoBeginner,
                  width: 96,
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 24),
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Kiếm 20 điểm nhiệm vụ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(height: 14),

                    AppProgressLinear(
                      progress: 0.1,
                      hint: '2 / 20',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}