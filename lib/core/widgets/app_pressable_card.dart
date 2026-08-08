

import 'dart:async';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class AppPressableCard extends StatefulWidget {

  final Widget widget;
  final Color? backgroundColor;

  final Color? depthColor;
  final Color? borderColor;

  final VoidCallback? onPressed;

  const AppPressableCard({
    super.key,
    required this.widget,

    this.depthColor = AppColors.grayBorder200, //
    this.borderColor = AppColors.grayBorder200,
    this.backgroundColor = AppColors.background,
    this.onPressed
  });

  @override
  State<AppPressableCard> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppPressableCard> {
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
    _releaseTimer = Timer(const Duration(milliseconds: 80), () {
      if (mounted) setState(() => _pressed = false);
    });
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _releaseTimer?.cancel();
    setState(() => _pressed = false);
  }

  double _calculateAutoDepth(Color depthColor) {
    if (depthColor == AppColors.grayBorder200 ||
        depthColor == Colors.transparent) {
      return 1.9;
    }

    return 3.5;
  }

  @override
  Widget build(BuildContext context) {
    // final palette = ButtonPalette.resolve(widget.variant, widget.isEnabled);
    // final canTap = widget.onPressed != null;
    final textTheme = Theme.of(context).textTheme;
    final _depth = _calculateAutoDepth(widget.depthColor!);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp:  _handleTapUp,
      onTapCancel: _handleTapCancel ,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,

        alignment: Alignment.center,
        transform: Matrix4.translationValues(
          0,
          (_pressed) ? _depth : 0,
          0,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.r14),
          border: widget.borderColor != null
              ? Border.all(color: widget.borderColor!, width: 1.5)
              : null,
          boxShadow: widget.depthColor == Colors.transparent
              ? null
              : [
            BoxShadow(
              color: widget.depthColor ?? AppColors.grayBorder200,
              offset: Offset(0, (_pressed) ? 0 : _depth),
              blurRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.S16),
          child: widget.widget,
        )
      ),
    );
  }
}