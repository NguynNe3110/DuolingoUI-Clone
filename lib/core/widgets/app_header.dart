import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


class AppHeader extends StatefulWidget {
  final Widget child;
  final bool isTransfer;
  final Color backgroundColor;
  final Color? transferBackgroundColor;
  final Color borderColor;
  final Color? transferBorderColor;

  final ScrollController? scrollController;

  const AppHeader({
    super.key,
    required this.child,
    this.isTransfer = false,
    this.backgroundColor = AppColors.background,
    this.transferBackgroundColor,
    this.borderColor = AppColors.grayBorder200,
    this.transferBorderColor,
    this.scrollController,
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    // Đăng ký lắng nghe sự kiện cuộn nếu có controller
    if (widget.scrollController != null) {
      widget.scrollController!.addListener(_onScroll);
    }
  }

  void _onScroll() {
    // Ngưỡng 2.0 để tránh bị flicker (nhấp nháy) do sai số thập phân khi offset = 0.0
    final bool hasScrolled = widget.scrollController!.offset > 2.0;

    // Chỉ gọi setState khi trạng thái thực sự thay đổi để tối ưu performance
    if (hasScrolled != _isScrolled) {
      setState(() {
        _isScrolled = hasScrolled;
      });
    }
  }

  @override
  void dispose() {
    // Hủy đăng ký lắng nghe để tránh memory leak
    if (widget.scrollController != null) {
      widget.scrollController!.removeListener(_onScroll);
    }
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   //  màu nền hiện tại
  //   Color currentBgColor = widget.backgroundColor;
  //   if (widget.isTransfer && _isScrolled) {
  //     currentBgColor = widget.transferBackgroundColor ?? widget.backgroundColor;
  //   }
  //
  //   // màu border hiện tại
  //   Color currentBorderColor = widget.borderColor;
  //   if (widget.isTransfer && _isScrolled) {
  //     currentBorderColor = widget.transferBorderColor ?? widget.borderColor;
  //   }
  //
  //   return AnimatedContainer(
  //     duration: const Duration(milliseconds: 200), //
  //     decoration: BoxDecoration(
  //       color: currentBgColor,
  //       // Luôn khai báo Border, chỉ thay đổi color từ transparent sang màu thật để animate mượt
  //       border: Border(
  //         bottom: BorderSide(
  //           color: _isScrolled ? currentBorderColor : currentBorderColor.withOpacity(0.0),
  //           width: 2,
  //         ),
  //       ),
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: widget.child,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          color: _isScrolled
              ? (widget.transferBackgroundColor ?? widget.backgroundColor)
              : widget.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: widget.child,
        ),

        // Border riêng
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: _isScrolled ? 1.0 : 0.0,
          child: Container(
            height: 2,
            color: widget.transferBorderColor ?? widget.borderColor,
          ),
        ),
      ],
    );
  }
}