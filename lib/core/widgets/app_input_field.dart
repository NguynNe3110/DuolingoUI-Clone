


import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_border.dart';
import '../theme/app_colors.dart';

class AppInputField extends StatefulWidget {

  final Color borderColor;
  final double borderValue;
  final String? hint;
  final TextEditingController controller;

  const AppInputField({
    super.key,
    this.borderColor = AppColors.duoBlue,
    this.borderValue = AppBorder.b2,
    this.hint,
    required this.controller,
  });

  @override
  State<AppInputField> createState() {
    return _AppInputField();
  }
}

class _AppInputField extends State<AppInputField> {
  final FocusNode _focusNode = FocusNode();

  void _onFocusChange() => setState(() {});
  void _onTextChanged() => setState(() {});

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_onFocusChange);
    widget.controller?.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();

    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  bool get _showIcon {
    return _focusNode.hasFocus && widget.controller.text.isNotEmpty;
  }


  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: widget.controller,
      style: TextStyle(color: AppColors.textPrimary, fontSize: 16),// style chữ người nhập
      focusNode: _focusNode,
      decoration: InputDecoration(
          hintText: widget.hint ?? "",
          hintStyle: TextStyle(color: AppColors.disabledText, fontSize: 16),
          border: InputBorder.none, // loai bo vien mac dinh cua input
          contentPadding: EdgeInsets.symmetric( //
              horizontal: AppSpacing.S16,
              vertical: AppSpacing.S12
          ),
          // suffix: _showIcon ? SvgPicture.asset(AppIcon.closeCircle) : null , // sufix nhận vào widget, k tối ưu với icon
          suffixIcon: _showIcon ? IconButton(
            onPressed: () {
              widget.controller.clear(); // Xóa text
              // Controller clear sẽ tự trigger listener -> setState -> _showIcon = false
            },
            icon: SvgPicture.asset(
              AppIcon.closeCircle,
              width: 24,
              height: 24,
              // colorFilter: const ColorFilter.mode(AppColors.disabledText, BlendMode.srcIn), // nếu cần đổi màu SVG
            ),
          ) : null ,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.grayBorder200,
                width: widget.borderValue
            ),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.borderColor,
                width: widget.borderValue
            ),
            borderRadius: BorderRadius.circular(AppRadius.r14),
          )
      ),
    );

  }
}