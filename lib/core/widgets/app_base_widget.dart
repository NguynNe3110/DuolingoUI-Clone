import 'dart:async';

import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class AppBaseWidget extends StatefulWidget {
  final String label;
  final String? iconPath; // icon

  // final Color? color;
  // final Color? depthColor;
  // final Color? textColor;
  // final ButtonVariant variant; // kieu
  final bool isEnabled; // trạng thái

  final TextStyle? textStyle;


  final Color? borderColor;
  //final double độ dày viền
  final double? height;
  final double? width;

  final VoidCallback? onPressed;

  const AppBaseWidget({
    super.key,
    required this.label, //
    this.iconPath,

    // this.color, //
    // this.depthColor, //
    // this.textColor,
    // this.variant = ButtonVariant.primary,
    this.isEnabled = true,
    // this.isState = 'enable',

    this.borderColor,

    this.textStyle,


    this.height,
    this.width,
    this.onPressed
  });

  @override
  State<AppBaseWidget> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppBaseWidget> {
  static const double _depth = 4;
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

  @override
  Widget build(BuildContext context) {
    // final palette = ButtonPalette.resolve(widget.variant, widget.isEnabled);
    final canTap = widget.isEnabled && widget.onPressed != null;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: canTap ? _handleTapDown : null,
      onTapUp: canTap ? _handleTapUp : null,
      onTapCancel: canTap ? _handleTapCancel : null,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 80),
        curve: Curves.easeOut,
        height: widget.height ?? 44,
        width: widget.width,
        alignment: Alignment.center,
        transform: Matrix4.translationValues(
          0,
          (_pressed && canTap) ? _depth : 0,
          0,
        ),
        decoration: BoxDecoration(
          // color: palette.backgroundColor,
          // borderRadius: BorderRadius.circular(AppRadius.md),
          // border: palette.borderColor != null
          //     ? Border.all(color: palette.borderColor!, width: 1.5)
          //     : null,
          // boxShadow: palette.depthColor == Colors.transparent
          //     ? null
          //     : [
          //   BoxShadow(
          //     color: palette.depthColor,
          //     offset: Offset(0, (_pressed && canTap) ? 0 : _depth),
          //     blurRadius: 0,
          //   ),
          // ],
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          // children: [
          //   if (widget.iconPath != null) ...[
          //     SvgPicture.asset(widget.iconPath!, width: 20, height: 20),
          //     const SizedBox(width: 8),
          //   ],
          //   Text(
          //     widget.label,
          //     style: widget.textStyle ??
          //         textTheme.labelMedium?.copyWith(color: palette.textColor),
          //   ),
          // ],
        ),
      ),
    );
  }
}