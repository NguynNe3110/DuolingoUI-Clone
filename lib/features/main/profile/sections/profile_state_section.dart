import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_icon.dart';
import '../bloc/profile_state.dart';

const Color _textGrayOnBackground = AppColors.textGrayOnBackground;
const Color _textBlackOnBackground = AppColors.textBlackOnBackground;

class ProfileStateSection extends StatefulWidget {
  final ProfileState _state;

  const ProfileStateSection({
    super.key,
    required this._state,

  });

  @override
  State<StatefulWidget> createState() {
    return ProfileStateSectionState();
  }
}

class ProfileStateSectionState extends State<ProfileStateSection> {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandleRow(widget._state),
          SizedBox(height: 16,),
          _buildStatsRow(widget._state),
          SizedBox(height: 16,),

          _buildAddFriendButton(),
        ],
      ),
    );
  }



  Widget _buildHandleRow(ProfileState state) {
    return Text(
        '${state.handle} · THAM GIA TỪ ${state.joinYear}',
        style: TextStyle(fontSize: 14, color: _textGrayOnBackground, fontWeight: FontWeight.w800),
    );
  }

  Widget _buildStatsRow(ProfileState state) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Courses
          Expanded(
            child: InkWell(
              onTap: () => { },// xu ly
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        AppIcon.flagUnitedState,
                        width: 20,
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '+5',
                          style: TextStyle(fontSize: 12, color: _textGrayOnBackground),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Khóa học',
                    style: TextStyle(fontSize: 14, color: _textGrayOnBackground),
                  ),
                ],
              ),
            ),
          ),
          // Following
          Expanded(
            child: InkWell(
              onTap: () => {},

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    '${state.followingCount}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _textBlackOnBackground
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Đang theo dõi',
                    style: TextStyle(fontSize: 14, color: _textGrayOnBackground),
                  ),
                ],
              ),
            ),
          ),
          // Followers
          Expanded(
            child: InkWell(
              onTap: () => {},

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.followerCount}',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _textBlackOnBackground
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Người theo dõi',
                    style: TextStyle(fontSize: 14, color: _textGrayOnBackground),
                  ),
                ],
              ),
            ),
          ),
        ],
    );
  }

  Widget _buildAddFriendButton() {
    return AppButton(
      label: 'THÊM BẠN BÈ',
      iconPath: AppIcon.inviteDisable,
      onPressed: () => {},
      variant: ButtonVariant.neutral,
    );
  }
}