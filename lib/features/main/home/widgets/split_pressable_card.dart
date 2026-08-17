// lib/features/main/home/widgets/split_pressable_card.dart
import 'dart:async';
import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:duolingo_ui_clone/domain/entities/lesson_entities.dart';
import 'package:duolingo_ui_clone/features/main/home/widgets/app_lesson_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import 'section_card_view_data.dart';

class SplitPressableCard extends StatefulWidget {
  final SectionCardViewData data;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  const SplitPressableCard({
    super.key,
    required this.data,
    this.onLeftPressed,
    this.onRightPressed,
  });

  @override
  State<SplitPressableCard> createState() => _SplitPressableCardState();
}

class _SplitPressableCardState extends State<SplitPressableCard> {
  bool _leftPressed = false;
  bool _rightPressed = false;

  Timer? _leftReleaseTimer;
  Timer? _rightReleaseTimer;

  @override
  void dispose() {
    _leftReleaseTimer?.cancel();
    _rightReleaseTimer?.cancel();
    super.dispose();
  }

  void _handleLeftTapDown(TapDownDetails details) {
    _leftReleaseTimer?.cancel();
    setState(() => _leftPressed = true);
  }

  void _handleLeftTapUp(TapUpDetails details) {
    _leftReleaseTimer = Timer(const Duration(milliseconds: 80), () {
      if (mounted) setState(() => _leftPressed = false);
    });
    widget.onLeftPressed?.call();
  }

  void _handleLeftTapCancel() {
    _leftReleaseTimer?.cancel();
    setState(() => _leftPressed = false);
  }

  void _handleRightTapDown(TapDownDetails details) {
    _rightReleaseTimer?.cancel();
    setState(() => _rightPressed = true);
  }

  void _handleRightTapUp(TapUpDetails details) {
    _rightReleaseTimer = Timer(const Duration(milliseconds: 80), () {
      if (mounted) setState(() => _rightPressed = false);
    });
    widget.onRightPressed?.call();
  }

  void _handleRightTapCancel() {
    _rightReleaseTimer?.cancel();
    setState(() => _rightPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    //lấy themeColor từ door qua inherited
    final theme = LessonNodeTheme.of(_mapColor(widget.data.door.themeColor));
    const double depth = 3.5;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _buildLeftPiece(theme, depth)),
            _buildSeam(theme, depth),
            _buildRightPiece(theme, depth),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftPiece(LessonNodeTheme theme, double depth) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleLeftTapDown,
      onTapUp: _handleLeftTapUp,
      onTapCancel: _handleLeftTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _leftPressed ? depth : 0, 0),
        decoration: BoxDecoration(
          color: theme.background,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(AppRadius.r14),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.depth,
              offset: Offset(0, _leftPressed ? 0 : depth),
              blurRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 16),
          child: _buildLeftWidget(),
        ),
      ),
    );
  }

  Widget _buildSeam(LessonNodeTheme theme, double depth) {
    return Container(
      width: 2,
      decoration: BoxDecoration(
        color: theme.depth,
        boxShadow: [
          BoxShadow(
            color: theme.depth,
            offset: Offset(0, depth),
            blurRadius: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildRightPiece(LessonNodeTheme theme, double depth) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleRightTapDown,
      onTapUp: _handleRightTapUp,
      onTapCancel: _handleRightTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _rightPressed ? depth : 0, 0),
        decoration: BoxDecoration(
          color: theme.background,
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(AppRadius.r14),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.depth,
              offset: Offset(0, _rightPressed ? 0 : depth),
              blurRadius: 0,
            ),
          ],
        ),
        child: SizedBox(
          width: 64,
          child: Center(
            child: SizedBox(
              width: 32,
              height: 32,
              child: SvgPicture.asset(AppIcon.phonebook, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeftWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'PHẦN ${widget.data.section.number}, CỬA ${widget.data.door.number}',
          style: const TextStyle(
            color: AppColors.textOnPrimaryBlur,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.data.door.title,
          style: const TextStyle(
            color: AppColors.textWhiteOnBackground,
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
          // style: AppTextTheme.light.displayMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,

        ),
      ],
    );
  }

  static LessonNodeColor _mapColor(DomainThemeColor color) {
    return switch (color) {
      DomainThemeColor.green  => LessonNodeColor.Green,
      DomainThemeColor.blue   => LessonNodeColor.Blue,
      DomainThemeColor.red    => LessonNodeColor.Red,
      DomainThemeColor.orange => LessonNodeColor.Orange,
      DomainThemeColor.cyan   => LessonNodeColor.Cyan,
      DomainThemeColor.violet => LessonNodeColor.Violet,
      DomainThemeColor.brown  => LessonNodeColor.Brown,
      DomainThemeColor.pink   => LessonNodeColor.Pink,
      DomainThemeColor.purple => LessonNodeColor.Purple,
    };
  }
}