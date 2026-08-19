import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileHeaderSection extends StatefulWidget {

  final ScrollController _scrollController;
  final Color backgroundColor;
  final Color backgroundTransfer;
  final Color borderColor;
  final Color? borderColorTransfer;
  final bool isPastBanner;

  const ProfileHeaderSection({
    super.key,
    required this._scrollController,
    required this.backgroundColor,
    required this.borderColor,
    this.backgroundTransfer = AppColors.background,
    this.borderColorTransfer = AppColors.grayBorder200,
    required this.isPastBanner,

  });

  @override
  State<ProfileHeaderSection> createState() => ProfileHeaderState();
}

class ProfileHeaderState extends State<ProfileHeaderSection>{

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      scrollController: widget._scrollController,

      backgroundColor: !widget.isPastBanner ? widget.backgroundColor : widget.backgroundTransfer,
      // transferBackgroundColor: widget.backgroundTransfer,
      borderColor: widget.borderColor,
      transferBorderColor: widget.borderColorTransfer,

      child: Row(
        children: [
          Expanded(
            child: Text(
              'T Nguyên<3',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: AppColors.textBlackOnBackground,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => {},
            child: SvgPicture.asset(
              AppIcon.shareDisable,
              width: 20,
            ),
          ),

          IconButton(
            icon:
            const Icon(Icons.settings_outlined, size: 30, color: AppColors.textBlackOnBackground, ),
            onPressed: () => {},
            padding: const EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }
}
