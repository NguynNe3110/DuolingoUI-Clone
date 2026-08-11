import 'dart:async';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppLessonNode extends StatefulWidget {
  final LessonNodeType lessonType;
  final LessonNodeColor unitColor;
  final bool isLocked;

  final double size;
  final double aspectRatio;
  final double depth;
  final double shineInset;
  final VoidCallback? onPressed;
  
  const AppLessonNode({
    super.key,
    required this.lessonType,
    required this.unitColor,
    this.isLocked = false,
    this.size = 70,
    this.aspectRatio = 1.1,
    this.depth = 8,
    this.shineInset = 6,
    this.onPressed,
  });

  @override
  State<AppLessonNode> createState() => _AppLessonNodeState();
}

class _AppLessonNodeState extends State<AppLessonNode> {
  bool _pressed = false;
  Timer? _releaseTimer;

  @override
  void dispose() {
    _releaseTimer?.cancel();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _releaseTimer?.cancel();
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    _releaseTimer = Timer(const Duration(milliseconds: 80), () {
      if (mounted) setState(() => _pressed = false);
    });
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _releaseTimer?.cancel();
    setState(() => _pressed = false);
  }



  @override
  Widget build(BuildContext context) {
    // lay mau
    final theme = LessonNodeTheme.of(widget.unitColor);

    // lay pathIcon
    final iconPath = widget.isLocked
        ? LessonNodeIcon.locked(widget.lessonType)
        : LessonNodeIcon.of(widget.lessonType, widget.unitColor);
    final Color shineColor = Color(0x4DFFFFFF);
    
    return Align(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          curve: Curves.easeOut,
          width: widget.size * widget.aspectRatio,
          height: widget.size,
          transform: Matrix4.translationValues(
            0,
            (_pressed) ? widget.depth : 0,
            0,
          ),

          // Dùng ShapeDecoration + OvalBorder để vẽ Elip thực sự
          decoration: ShapeDecoration(
            color: widget.isLocked ? AppColors.graySurface200 : theme.background,
            shape: const OvalBorder(), // Vẽ elip ôm trọn width & height
            shadows: [
              BoxShadow(
                color: widget.isLocked ? AppColors.grayBorder300 : theme.depth,
                offset: Offset(0, (_pressed) ? 0 : widget.depth),
                blurRadius: 0,
              ),
            ],
          ),

          //  ClipOval ở đây để cắt lớp bóng (shine) và icon cho gọn vào trong elip
          child: ClipOval(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Lớp bóng chéo — lùi vào trong shineInset để chừa viền
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(widget.shineInset),
                    child: ClipOval(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [
                              0.0, 0.1,
                              0.1, 0.38,
                              0.38, 0.58,
                              0.58, 0.78,
                              0.78, 1.0
                            ],

                            colors: [
                              Colors.transparent, Colors.transparent,
                              shineColor, shineColor,
                              Colors.transparent, Colors.transparent,
                              shineColor, shineColor,
                              Colors.transparent, Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  iconPath,
                  width: widget.size * 0.55, // Căn chỉnh kích thước icon
                  height: widget.size * 0.55,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum LessonNodeColor {
  Cyan, Red, Green, Orange, Violet,
  Blue, Brown, Pink, Purple, Default
}

enum LessonNodeType {
  headphone, //listening,
  book, //reading,
  video, //calling,
  weight, //practices,
  star, //review
}

class LessonNodeTheme {
  final Color background;
  final Color depth;
  const LessonNodeTheme(this.background, this.depth);

  static LessonNodeTheme of(LessonNodeColor color) {
    return switch (color) {
      LessonNodeColor.Cyan => const LessonNodeTheme(AppColors.duoCyan, AppColors.duoCyanDark),
      LessonNodeColor.Red => const LessonNodeTheme(AppColors.duoRed, AppColors.duoRedDark),
      LessonNodeColor.Green => const LessonNodeTheme(AppColors.duoGreen, AppColors.duoGreenDark),
      LessonNodeColor.Orange => const LessonNodeTheme(AppColors.duoOrange, AppColors.duoOrangeDark),
      LessonNodeColor.Violet => const LessonNodeTheme(AppColors.duoViolet, AppColors.duoVioletDark),
      LessonNodeColor.Blue => const LessonNodeTheme(AppColors.duoBlue, AppColors.duoBlueDark),
      LessonNodeColor.Brown => const LessonNodeTheme(AppColors.duoBrown, AppColors.duoBrownDark),
      LessonNodeColor.Pink => const LessonNodeTheme(AppColors.duoPink, AppColors.duoPinkDark),
      LessonNodeColor.Purple => const LessonNodeTheme(AppColors.duoPurple, AppColors.duoPurpleDark),
      LessonNodeColor.Default => const LessonNodeTheme(AppColors.graySurface200, AppColors.grayBorder300), // Fallback
    };
  }
}

class LessonNodeIcon {
  static String of(LessonNodeType type, LessonNodeColor color) {
    return switch (type) {
      LessonNodeType.book => switch (color) {
        LessonNodeColor.Blue => AppIcon.bookBlue,
        LessonNodeColor.Brown => AppIcon.bookBrown,
        LessonNodeColor.Cyan => AppIcon.bookCyan,
        LessonNodeColor.Green => AppIcon.bookGreen,
        LessonNodeColor.Orange => AppIcon.bookOrange,
        LessonNodeColor.Pink => AppIcon.bookPink,
        LessonNodeColor.Violet => AppIcon.bookViolet,
        LessonNodeColor.Purple => AppIcon.bookPurple,
        LessonNodeColor.Red => AppIcon.bookRed,
        LessonNodeColor.Default => AppIcon.bookDefault,
      },
      LessonNodeType.headphone => switch (color) {
        LessonNodeColor.Blue => AppIcon.headphoneBlue,
        LessonNodeColor.Cyan => AppIcon.headphoneCyan,
        LessonNodeColor.Green => AppIcon.headphoneGreen,
        LessonNodeColor.Orange => AppIcon.headphoneOrange,
        LessonNodeColor.Pink => AppIcon.headphonePink,
        LessonNodeColor.Purple => AppIcon.headphonePurple,
        LessonNodeColor.Red => AppIcon.headphoneRed,
        LessonNodeColor.Violet => AppIcon.headphoneViolet,
      // Các màu còn lại hoặc Default sẽ fallback về Default
        _ => AppIcon.headphoneDefault,
      },
      LessonNodeType.video => switch (color) {
        LessonNodeColor.Blue => AppIcon.videoBlue,
        LessonNodeColor.Brown => AppIcon.videoBrown,
        LessonNodeColor.Cyan => AppIcon.videoCyan,
        LessonNodeColor.Green => AppIcon.videoGreen,
        LessonNodeColor.Orange => AppIcon.videoOrange,
        LessonNodeColor.Pink => AppIcon.videoPink,
        LessonNodeColor.Purple => AppIcon.videoPurple,
        LessonNodeColor.Red => AppIcon.videoRed,
        LessonNodeColor.Violet => AppIcon.videoViolet,
        _ => AppIcon.videoDefault,
      },
      LessonNodeType.weight => switch (color) {
        LessonNodeColor.Blue => AppIcon.weightBlue,
        LessonNodeColor.Brown => AppIcon.weightBrown,
        LessonNodeColor.Cyan => AppIcon.weightCyan,
        LessonNodeColor.Green => AppIcon.weightGreen,
        LessonNodeColor.Orange => AppIcon.weightOrange,
        LessonNodeColor.Pink => AppIcon.weightPink,
        LessonNodeColor.Purple => AppIcon.weightPurple,
        LessonNodeColor.Red => AppIcon.weightRed,
        LessonNodeColor.Violet => AppIcon.weightViolet,
        _ => AppIcon.weightDefault,
      },
      LessonNodeType.star => AppIcon.starDefault, // Star chỉ có 1 màu default
    };
  }

  static String locked(LessonNodeType type) {
    // Giả sử bài khóa thì dùng icon default (màu xám/trắng)
    return switch (type) {
      LessonNodeType.book => AppIcon.bookDefault,
      LessonNodeType.headphone => AppIcon.headphoneDefault,
      LessonNodeType.video => AppIcon.videoDefault,
      LessonNodeType.weight => AppIcon.weightDefault,
      LessonNodeType.star => AppIcon.starDefault,
    };
  }
}