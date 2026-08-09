import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../theme/app_border.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';

/// Hướng của đuôi bong bóng
enum BubbleTail { none, down, up, left, right }

/// Bong bóng thoại kiểu Duolingo: thân bo góc + đuôi hợp nhất
/// thành MỘT path liên tục => viền liền mạch, không "mối nối".
class AppSpeechBubble extends StatelessWidget {
  const AppSpeechBubble({
    super.key,
    required this.child,
    this.tail = BubbleTail.down,
    /// Khoảng cách từ mép đầu (trái với down/up, trên với left/right)
    /// tới chân trái của đuôi. null => đuôi tự căn giữa.
    this.tailOffset,
    this.fillColor = AppColors.background,
    this.borderColor = AppColors.grayBorder200,
    this.borderWidth = AppBorder.b2,
    this.radius = AppRadius.r16,
    this.tailWidth = 16,
    this.tailHeight = 10,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSpacing.S16, vertical: AppSpacing.S12),
  });

  final Widget child;
  final BubbleTail tail;
  final double? tailOffset;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double tailWidth;
  final double tailHeight;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    // Chừa chỗ cho đuôi ở đúng cạnh, để đuôi không đè lên text
    final tailSpace = switch (tail) {
      BubbleTail.down  => EdgeInsets.only(bottom: tailHeight),
      BubbleTail.up    => EdgeInsets.only(top: tailHeight),
      BubbleTail.left  => EdgeInsets.only(left: tailHeight),
      BubbleTail.right => EdgeInsets.only(right: tailHeight),
      BubbleTail.none  => EdgeInsets.zero,
    };

    //CustomPaint CÓ child thì size = size của child
    return CustomPaint(
      painter: _BubblePainter(
        tail: tail,
        tailOffset: tailOffset,
        fillColor: fillColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        radius: radius,
        tailWidth: tailWidth,
        tailHeight: tailHeight,
      ),
      child: Padding(padding: padding + tailSpace, child: child),
    );
  }
}

class _BubblePainter extends CustomPainter {
  const _BubblePainter({
    required this.tail,
    required this.tailOffset,
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
    required this.radius,
    required this.tailWidth,
    required this.tailHeight,
  });

  final BubbleTail tail;
  final double? tailOffset;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double tailWidth;
  final double tailHeight;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    // Kích thước trong không gian "chuẩn" (đuôi chĩa XUỐNG).
    // Các hướng khác = xoay canvas (giống hệt Canvas Android: save/rotate/restore).
    double cw, ch;
    switch (tail) {
      case BubbleTail.down || BubbleTail.none:
        cw = size.width; ch = size.height;
      case BubbleTail.up:
        cw = size.width; ch = size.height;
        canvas.translate(size.width, size.height);
        canvas.rotate(math.pi);
      case BubbleTail.left:
        cw = size.height; ch = size.width;
        canvas.translate(size.width, 0);
        canvas.rotate(math.pi / 2);
      case BubbleTail.right:
        cw = size.height; ch = size.width;
        canvas.translate(0, size.height);
        canvas.rotate(-math.pi / 2);
    }

    final path = _buildPath(cw, ch);
    canvas.drawPath(path, Paint()..color = fillColor);
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..strokeJoin = StrokeJoin.round, // đầu đuôi bo nhẹ, không nhọn hoắt
    );
    canvas.restore();
  }

  /// MỘT path liên tục: viền đi dọc đáy, nhúng xuống đuôi rồi đi tiếp
  /// => không có đường kẻ cắt ngang chân đuôi (không mối nối).
  Path _buildPath(double w, double h) {
    if (tail == BubbleTail.none) {
      return Path()
        ..addRRect(RRect.fromRectAndRadius(
            Offset.zero & Size(w, h), Radius.circular(radius)));
    }

    final bodyH = h - tailHeight; // thân (không tính đuôi)
    final r = math.min(radius, math.min(w, bodyH) / 2);
    final tx = (tailOffset ?? (w - tailWidth) / 2)
        .clamp(0.0, math.max(0.0, w - tailWidth))
        .toDouble();

    return Path()
      ..moveTo(r, 0)
      ..lineTo(w - r, 0)                                  // cạnh trên
      ..quadraticBezierTo(w, 0, w, r)                     // góc trên-phải
      ..lineTo(w, bodyH - r)                              // cạnh phải
      ..quadraticBezierTo(w, bodyH, w - r, bodyH)         // góc dưới-phải
      ..lineTo(tx + tailWidth, bodyH)                     // → chân phải đuôi
      ..lineTo(tx + tailWidth / 2, bodyH + tailHeight)    // ↓ đỉnh đuôi
      ..lineTo(tx, bodyH)                                 // ↑ chân trái đuôi
      ..lineTo(r, bodyH)
      ..quadraticBezierTo(0, bodyH, 0, bodyH - r)         // góc dưới-trái
      ..lineTo(0, r)                                      // cạnh trái
      ..quadraticBezierTo(0, 0, r, 0)                     // góc trên-trái
      ..close();
  }

  @override
  bool shouldRepaint(covariant _BubblePainter old) =>
      old.tail != tail || old.tailOffset != tailOffset ||
          old.fillColor != fillColor || old.borderColor != borderColor ||
          old.borderWidth != borderWidth || old.radius != radius ||
          old.tailWidth != tailWidth || old.tailHeight != tailHeight;
}