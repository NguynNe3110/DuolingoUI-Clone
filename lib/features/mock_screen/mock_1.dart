import 'package:duolingo_ui_clone/core/theme/app_icon.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/widgets/app_button.dart';
import 'MockScreen.dart';
class Mock1 extends StatelessWidget{
  Mock1({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        // Dùng thẳng style từ theme
        Text('DUOLINGO', style: textTheme.displayLarge),
        Text('Nhiệm vụ tháng Tám', style: textTheme.headlineMedium),
        Text('Nội dung chính', style: textTheme.bodyMedium),

        // Muốn ghi đè thêm (màu, căn lề...) thì copyWith
        Text('Ghi chú nhỏ', style: textTheme.bodySmall?.copyWith(color: Colors.grey)),

        ElevatedButton(
          onPressed: () {},
          child: const Text('Đăng nhập - Text'),
        ),

        // Muốn dùng button 2 cho nút nhỏ:
        ElevatedButton(
          style: ElevatedButton.styleFrom(textStyle: textTheme.labelMedium),
          onPressed: () {},
          child: const Text('Hủy - Text'),
        ),

        ButtonN(),

        SizedBox(height: 24,),


        Button3D(
          label: 'KIỂM TRA - Button 3D',
        ),
        SizedBox(height: 24,),

        AppButton1(label: 'KIỂM TRA',),

        SizedBox(height: 24,),



        AppButton(
          iconPath: 'assets/icons/icon_heart.svg',
          label: 'XEM NHIỆM VỤ NGAY',
          onPressed: () => {},
        ),
        SizedBox(height: 24,),

        AppButton(
          iconPath: AppIcon.home,
          label: 'XEM NHIỆM VỤ NGAY',
          variant: ButtonVariant.secondary,
          onPressed: () => {},

        ),
        SizedBox(height: 24,),

        AppButton(
          iconPath: 'assets/icons/icon_heart.svg',
          label: 'XEM NHIỆM VỤ NGAY',
          variant: ButtonVariant.danger,
          onPressed: () => {},

        ),
        SizedBox(height: 24,),

        AppButton(
          iconPath: 'assets/icons/icon_heart.svg',
          label: 'XEM NHIỆM VỤ NGAY',
          variant: ButtonVariant.neutral,
          onPressed: () => {},

        ),
        SizedBox(height: 24,),
        AppButton(
          iconPath: 'assets/icons/icon_heart.svg',
          label: 'XEM NHIỆM VỤ NGAY',
          variant: ButtonVariant.ghost,
          isEnabled: false,
          onPressed: () => {},

        ),
      ],
    );
  }
}


class ButtonN extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  const ButtonN({
    super.key,
    this.label,
    this.icon,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.isEnabled = true,
    this.isLoading = false,
    this.onPressed,
  });

  @override
  State<ButtonN> createState() => _ButtonNState();
}

class _ButtonNState extends State<ButtonN> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });

        widget.onPressed?.call();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),

        // ↓↓↓ khi nhấn thì nút đi xuống
        margin: EdgeInsets.only(top: _isPressed ? 8 : 0),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),

          boxShadow: _isPressed
              ? []
              : [
            const BoxShadow(
              color: Color(0xFF58CC02),
              spreadRadius: 2,
              offset: Offset(0, 8),
            ),
          ],
        ),

        child: ElevatedButton(
          onPressed: null, // GestureDetector xử lý

          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF46A302),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          child: Text(widget.label ?? "Button N"),
        ),
      ),
    );
  }
}

class Button3D extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;

  const Button3D({super.key, required this.label, this.onPressed});

  @override
  State<Button3D> createState() => _Button3DState();
}

class _Button3DState extends State<Button3D> {
  static const double _depth = 4;
  bool _pressed = false;

  void _setPressed(bool value) {
    if (mounted && _pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        widget.onPressed?.call();
      },
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 70),
        curve: Curves.easeOut,
        height: 56,
        alignment: Alignment.center,
        // Mặt nút trượt xuống đúng bằng độ dày đế khi nhấn
        transform: Matrix4.translationValues(0, _pressed ? _depth : 0, 0),
        decoration: BoxDecoration(
          color: _pressed ? const Color(0xFF3F8A28) : const Color(0xFF4C9A32),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1B7A1B), // đế sẫm màu
              offset: Offset(0, _pressed ? 0 : _depth), // hết nhấn lại nhô đế lên
              blurRadius: 0, // = 0: bóng cứng => nhìn thành khối 3D
            ),
          ],
        ),
        child: Text(
          widget.label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}



class AppButton1 extends StatefulWidget {
  final String label;
  final String? iconPath; // icon
  final Color? color;
  final Color? depthColor;
  final Color? textColor;

  final TextStyle? textStyle;

  final String isState; // trạng thái

  final Color? borderColor;
  //final double độ dày viền
  final double? height;
  final double? width;

  final VoidCallback? onPressed;

  const AppButton1({
    super.key,
    required this.label, //
    this.iconPath,
    this.color, //
    this.depthColor, //
    this.textColor,
    this.borderColor,

    this.textStyle,

    this.isState = 'enable',

    this.height,
    this.width,
    this.onPressed
  });

  @override
  State<AppButton1> createState() => _AppButton1State();
}

class _AppButton1State extends State<AppButton1> {
  static const double _depth = 4;
  bool _pressed = false;


  void _setPressed(bool value) {
    if (mounted && _pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) {
        _setPressed(false);
        widget.onPressed?.call();
      },
      onTapCancel: () => _setPressed(false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeOut,
        height: widget.height ?? 44,
        alignment: Alignment.center,
        // Mặt nút trượt xuống đúng bằng độ dày đế khi nhấn

        transform: Matrix4.translationValues(0, _pressed ? _depth : 0, 0),

        decoration: BoxDecoration(

          color: widget.color ?? AppColors.duoGreen ,

          borderRadius: BorderRadius.circular(AppRadius.md), //10

          boxShadow: [
            BoxShadow(
              color: widget.depthColor ?? AppColors.duoGreenDark, // đế sẫm màu

              offset: Offset(0, _pressed ? 0 : _depth), // hết nhấn lại nhô đế lên

              blurRadius: 0, // = 0: bóng cứng => nhìn thành khối 3D
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.iconPath != null) ...[
              SvgPicture.asset(
                widget.iconPath!,
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: widget.textStyle ??
                  textTheme.labelMedium?.copyWith(
                    color: widget.textColor ?? Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
