

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InGroupTextField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType? keyboardType;

  const InGroupTextField({
    super.key,
    this.hint,
    this.controller,
    this.isPassword = false,
    this.keyboardType,
  });

  @override
  State<InGroupTextField> createState() {
    return _InGroupTextField();
  }
}

class _InGroupTextField extends State<InGroupTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && _obscure, // ***
      keyboardType: widget.keyboardType, // loại bàn phím
      style: TextStyle(color: AppColors.textPrimary, fontSize: 16),// style chữ người nhập
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.disabledText, fontSize: 16),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.S16,
          vertical: AppSpacing.S12,
        ), //prefixIcon - icon nằm bên phải textField
        suffixIcon: widget.isPassword //Là widget nằm bên phải TextField.
            ? IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.duoBlue,
                ),

              )
            :null,

      ),
    );
  }
}

class AppGroupInputField extends StatelessWidget {
  final List<Widget> children;
  final Color borderColor;
  final double radius;

  const AppGroupInputField({
    super.key,
    required this.children,
    this.borderColor = AppColors.grayBorder200,
    this.radius = AppRadius.r14
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];
    for(var i = 0; i < children.length; i++) {
      rows.add(children[i]);
      if(i < children.length - 1 ) {
        rows.add(
          Divider(height: 1, thickness: 2, color: borderColor)
        );
      }
    }

    return Container(
      clipBehavior: Clip.antiAlias, // Cắt phần tràn của con theo bo góc
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2 ),
        borderRadius: BorderRadius.circular(radius),

      ),
      child: Column(children: rows),
    );
  }

}