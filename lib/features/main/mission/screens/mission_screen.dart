import 'package:duolingo_ui_clone/core/widgets/app_progress_linear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icon.dart';
import '../sections/daily_misson_section.dart';
import '../sections/friend_mission_section.dart';
import '../sections/header_section.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfffffd),
      body: Column(
        children: [
          const HeaderSection(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FriendMissionSection(),
                  _SectionDivider(),
                  DailyMissionSection(),
                  SizedBox(height: 32),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}


class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Divider(thickness: 2, color: Color(0xFFE3E3E3)),
    );
  }
}