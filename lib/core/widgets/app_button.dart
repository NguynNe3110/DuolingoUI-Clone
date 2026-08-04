import 'dart:async';

import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class AppButton extends StatefulWidget {
  final String label;
  final String? iconPath; // icon

  // final Color? color;
  // final Color? depthColor;
  // final Color? textColor;
  final ButtonVariant variant; // kieu
  final bool isEnabled; // trạng thái

  final TextStyle? textStyle;


  final Color? borderColor;
  //final double độ dày viền
  final double? height;
  final double? width;

  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.label, //
    this.iconPath,

    // this.color, //
    // this.depthColor, //
    // this.textColor,
    this.variant = ButtonVariant.primary,
    this.isEnabled = true,
    // this.isState = 'enable',

    this.borderColor,

    this.textStyle,


    this.height,
    this.width,
    this.onPressed
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  static const double _depth = 3.5;
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
    final palette = ButtonPalette.resolve(widget.variant, widget.isEnabled);
    final canTap = widget.isEnabled && widget.onPressed != null;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: canTap ? _handleTapDown : null,
      onTapUp: canTap ? _handleTapUp : null,
      onTapCancel: canTap ? _handleTapCancel : null,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 10),
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
          color: palette.backgroundColor,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: palette.borderColor != null
              ? Border.all(color: palette.borderColor!, width: 1.5)
              : null,
          boxShadow: palette.depthColor == Colors.transparent
              ? null
              : [
            BoxShadow(
              color: palette.depthColor,
              offset: Offset(0, (_pressed && canTap) ? 0 : _depth),
              blurRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.iconPath != null) ...[
              SvgPicture.asset(widget.iconPath!, width: 20, height: 20),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: widget.textStyle ??
                  textTheme.labelMedium?.copyWith(color: palette.textColor),
            ),
          ],
        ),
      ),
    );
  }
}

enum ButtonVariant {
  primary,    // xanh lá (hành động chính)
  danger,     // đỏ (trả lời sai, xoá)
  secondary,  // xanh dương (hành động phụ)
  neutral,    // trắng/xám (huỷ, back)
  ghost,      // trong suốt (link, text button)
}

class ButtonPalette {
  final Color backgroundColor;
  final Color depthColor;
  final Color textColor;
  final Color? borderColor;

  ButtonPalette({
    required this.backgroundColor,
    required this.depthColor,
    required this.textColor,
    this.borderColor,
  });

  static ButtonPalette resolve(ButtonVariant variant, bool enabled) {
    switch (variant) {
      case ButtonVariant.primary:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.duoGreen      : AppColors.duoGreen.withOpacity(0.4),
          depthColor:      enabled ? AppColors.duoGreenDark  : AppColors.duoGreenDark.withOpacity(0.4),
          textColor:       Colors.white,
        );

      case ButtonVariant.danger:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.duoRed : AppColors.duoRed.withOpacity(0.4),
          depthColor:      enabled ? AppColors.duoRedDark : AppColors.duoRedDark.withOpacity(0.4),
          textColor:       Colors.white,
        );

      case ButtonVariant.secondary:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.duoBlue : AppColors.duoBlue.withOpacity(0.4),
          depthColor:      enabled ? AppColors.duoBlueDark : AppColors.duoBlueDark.withOpacity(0.4),
          textColor:       Colors.white,
        );

      case ButtonVariant.neutral:
        return ButtonPalette(
          backgroundColor: enabled ? AppColors.background    : AppColors.background.withOpacity(0.5),
          depthColor:      enabled ? AppColors.disabledText : const Color(0xFFBDBDBD).withOpacity(0.4),
          textColor:       enabled ? AppColors.borderDark    : Colors.black38,
          borderColor:     enabled ? AppColors.disabledText : null,
        );

      case ButtonVariant.ghost:
        return ButtonPalette(
          backgroundColor: AppColors.disabledBg,
          depthColor:      Colors.transparent,
          textColor:       AppColors.background,
        );
    }
  }
}