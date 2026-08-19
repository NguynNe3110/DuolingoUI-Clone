import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';
import '../bloc/profile_state.dart';
import '../widgets/section_header_widget.dart';

const Color _textGrayOnBackground = AppColors.textGrayOnBackground;
const Color _textBlackOnBackground = AppColors.textBlackOnBackground;


class ProfileOverviewSection extends StatefulWidget {
  final ProfileState _state;

  const ProfileOverviewSection({
    super.key,
    required this._state,

  });

  @override
  State<ProfileOverviewSection> createState() {
    return ProfileOverviewSectionState();
  }
}

class ProfileOverviewSectionState extends State<ProfileOverviewSection> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOverviewSection(widget._state),

      ],
    );
  }

  Widget _buildOverviewSection(ProfileState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: 'TỔNG QUAN',
          ),
          const SizedBox(height: 16),
          // Row 1: Streak + Course Level
          Row(
            children: [
              Expanded(
                child: _overviewItem(
                  pathIcon: AppIcon.streak,
                  text: '${state.streakDays} ngày',
                ),
              ),
              Expanded(
                child: _overviewItem(
                  pathIcon: AppIcon.flagUnitedState,
                  text: '${state.courseLevel}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Row 2: League + XP
          Row(
            children: [
              Expanded(
                child: _overviewItem(
                  pathIcon: AppIcon.trophyGold,
                  text: state.league,
                ),
              ),
              Expanded(
                child: _overviewItem(
                  pathIcon: AppIcon.lightning,
                  text: '${state.xp} KN',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewItem({
    required String pathIcon,
    required String text,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
            pathIcon,
          width: 20,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 16, color: _textBlackOnBackground, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}