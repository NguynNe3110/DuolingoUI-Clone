// widgets/oval_progress_ring.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';

class OvalProgressRing extends StatelessWidget {
  const OvalProgressRing({
    super.key,
    required this.progress,      // 0..1
    this.segments = 4,
    this.strokeWidth = 8,
    this.gapDegrees = 20,
    required this.fillColor,
    this.trackColor = const Color(0xFFE4E4E4),
  });

  final double progress;
  final int segments;
  final double strokeWidth;
  final double gapDegrees;
  final Color fillColor;
  final Color trackColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite, // fix có size thì mới render đc
      painter: _OvalRingPainter(
        progress: progress, segments: segments, strokeWidth: strokeWidth,
        gapDegrees: gapDegrees, fillColor: fillColor, trackColor: trackColor,
      ),
    );
  }
}

class _OvalRingPainter extends CustomPainter {
  _OvalRingPainter({
    required this.progress, required this.segments,
    required this.strokeWidth, required this.gapDegrees,
    required this.fillColor, required this.trackColor,
  });

  final double progress, strokeWidth, gapDegrees;
  final int segments;
  final Color fillColor, trackColor;

  static double _rad(double deg) => deg * math.pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    // Rect bao elip, co vào trong nửa strokeWidth để nét vẽ không bị cắt
    final rect = Offset.zero & Size(size.width, size.height);
    final ovalRect = rect.deflate(strokeWidth / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final segSweep = (360 - segments * gapDegrees) / segments;
    final progressAngle = -90 + progress.clamp(0.0, 1.0) * 360;

    double start = -80; // đỉnh elip, xuôi chiều kim đồng hồ
    for (int i = 0; i < segments; i++) {
      final end = start + segSweep;

      // Track (xám)
      paint.color = trackColor;
      canvas.drawArc(ovalRect, _rad(start), _rad(segSweep), false, paint);

      // Fill (màu unit) — chỉ vẽ phần progress đã đi qua
      final fillEnd = math.min(progressAngle, end);
      if (fillEnd - start > 0.5) {
        paint.color = fillColor;
        canvas.drawArc(ovalRect, _rad(start), _rad(fillEnd - start), false, paint);
      }
      start = end + gapDegrees;
    }
  }

  @override
  bool shouldRepaint(covariant _OvalRingPainter old) =>
      old.progress != progress || old.segments != segments ||
          old.strokeWidth != strokeWidth || old.fillColor != fillColor ||
          old.trackColor != trackColor;
}