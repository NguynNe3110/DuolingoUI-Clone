

import 'dart:async';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

enum AnswerCardStatus {
  idle,     // chưa chọn
  selected, // đang được chọn / clicking
  correct,  // đáp án đúng
  wrong,    // đáp án sai
  retry, // được phép thử lại
}

class AppAnswerCard extends StatefulWidget {

  final Widget child;
  final AnswerCardStatus status;

  // final Color? backgroundColor;
  // final Color? depthColor;
  // final Color? borderColor;

  final VoidCallback? onPressed;

  const AppAnswerCard({
    super.key,
    required this.child,
    required this.status,
    // this.depthColor = AppColors.grayBorder200, //
    // this.borderColor = AppColors.grayBorder200,
    // this.backgroundColor = AppColors.background,
    this.onPressed
  });

  @override
  State<AppAnswerCard> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppAnswerCard> {
  bool _pressed = false;
  Timer? _releaseTimer; // ← Thêm biến này

  @override
  void dispose() {
    _releaseTimer?.cancel(); // ← Cleanup khi widget bị hủy
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _releaseTimer?.cancel(); // Hủy timer cũ (nếu có)
    setState(() => _pressed = true); // Set ngay lập tức
  }

  void _handleTapUp(TapUpDetails details) {
    // Delay 100ms trước khi thả - đảm bảo mắt thấy hiệu ứng
    _releaseTimer = Timer(const Duration(milliseconds: 40), () {
      if (mounted) setState(() => _pressed = false);
    });
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _releaseTimer?.cancel();
    setState(() => _pressed = false);
  }


  Color _backgroundColor() {
    return switch(widget.status){
      AnswerCardStatus.idle => AppColors.background,
      AnswerCardStatus.selected => AppColors.blueSurface150,
      AnswerCardStatus.correct => AppColors.greenSurface250,
      AnswerCardStatus.wrong => AppColors.redSurface150,
      AnswerCardStatus.retry => AppColors.yellowSurface200,
    };
  }

  Color _textColor() {
    return switch(widget.status){
      AnswerCardStatus.idle => AppColors.textOnBackground,
      AnswerCardStatus.selected => AppColors.textBlueOnSurface150,
      AnswerCardStatus.correct => AppColors.textGreenOnSurface250,
      AnswerCardStatus.wrong => AppColors.textRedOnSurface150,
      AnswerCardStatus.retry => AppColors.textYellowOnSurface200,
    };
  }

  Color _depthColor() {
    return switch(widget.status){
      AnswerCardStatus.idle => AppColors.grayBorder200,
      AnswerCardStatus.selected => AppColors.blueBorder150,
      AnswerCardStatus.correct => AppColors.greenBorder250,
      AnswerCardStatus.wrong => AppColors.redBorder150,
      AnswerCardStatus.retry => AppColors.yellowBorder200,
    };
  }

  Color _borderColor() {
    return switch(widget.status){
      AnswerCardStatus.idle => AppColors.grayBorder200,
      AnswerCardStatus.selected => AppColors.blueBorder150,
      AnswerCardStatus.correct => AppColors.greenBorder250,
      AnswerCardStatus.wrong => AppColors.redBorder150,
      AnswerCardStatus.retry => AppColors.yellowBorder200,
    };
  }

  @override
  Widget build(BuildContext context) {
    // final palette = ButtonPalette.resolve(widget.variant, widget.isEnabled);
    // final canTap = widget.onPressed != null;
    final double _depth = 2;
    final textTheme = Theme.of(context).textTheme;
    final currentTextColor = _textColor();

    return GestureDetector(
      behavior: HitTestBehavior.opaque, // bắt sự kiện chạm ở cả vùng trống
      onTapDown: _handleTapDown,
      onTapUp:  _handleTapUp,
      onTapCancel: _handleTapCancel ,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeOut,

        alignment: Alignment.center,
        transform: Matrix4.translationValues(
          0,
          (_pressed) ? _depth : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: _backgroundColor(),
          borderRadius: BorderRadius.circular(AppRadius.r14),
          border: Border.all(color: _borderColor(), width: AppBorder.b2),
          boxShadow: [
            BoxShadow(
              color: _depthColor(),
              offset: Offset(0, (_pressed) ? 0 : _depth),
              blurRadius: 0,
            ),
          ],
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(color: currentTextColor),
          child: IconTheme(
            data: IconThemeData(color: currentTextColor),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.S16),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}