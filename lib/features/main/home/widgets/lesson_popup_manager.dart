// utils/lesson_popup_manager.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import 'app_lesson_node.dart';
import '../../../../core/widgets/app_speech_bubble.dart';
import 'lesson_node_data.dart';

class LessonPopupManager {
  OverlayEntry? _entry;
  final BuildContext _screenContext;

  LessonPopupManager(this._screenContext);

  // SỬA: Nhận Rect thay vì BuildContext
  void show({
    required Rect nodeRect,
    required LessonNodeData data,
    required VoidCallback onStart, // THÊM: Callback khi bấm "BẮT ĐẦU"
  }) {
    hide();

    final screenSize = MediaQuery.of(_screenContext).size;
    final theme = LessonNodeTheme.of(data.color);

    const bubbleWidth = 300.0;
    const tailWidth = 16.0;
    const gap = 8.0;

    final bubbleLeft = ((screenSize.width - bubbleWidth) / 2).clamp(16.0, screenSize.width - bubbleWidth - 16.0);
    final nodeCenterX = nodeRect.center.dx;
    final tailOffset = (nodeCenterX - bubbleLeft - tailWidth / 2)
        .clamp(16.0, bubbleWidth - tailWidth - 16.0).toDouble();

    final showBelow = nodeRect.bottom + 220 < screenSize.height;

    _entry = OverlayEntry(
      builder: (overlayContext) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: hide,
              child: const SizedBox.expand(),
            ),
          ),
          Positioned(
            left: bubbleLeft,
            width: bubbleWidth,
            top: showBelow ? nodeRect.bottom + gap : null,
            bottom: showBelow ? null : screenSize.height - nodeRect.top + gap,
            child: AppSpeechBubble(
              tail: showBelow ? BubbleTail.up : BubbleTail.down,
              tailOffset: tailOffset,
              fillColor: theme.background,
              borderColor: Colors.transparent,
              child: _buildPopupContent(data, theme, onStart),
            ),
          ),
        ],
      ),
    );

    Overlay.of(_screenContext).insert(_entry!);
  }

  Widget _buildPopupContent(LessonNodeData data, LessonNodeTheme theme, VoidCallback onStart) {
    return Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Bài học ${data.id}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
            Text(
              data.title,
              style: TextStyle(
                color: AppColors.textWhiteOnBackground,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text('Phần ${data.partCount}', style: const TextStyle(color: Colors.white, fontSize: 14)), // SỬA: Dùng partCount
            Text('Phần ${data.partCount}', style: const TextStyle(color: Colors.white, fontSize: 14)), // SỬA: Dùng partCount
            Text('Phần ${data.partCount}', style: const TextStyle(color: Colors.white, fontSize: 14)), // SỬA: Dùng partCount
            Text('Phần ${data.partCount}', style: const TextStyle(color: Colors.white, fontSize: 14)), // SỬA: Dùng partCount
            Text('Phần ${data.partCount}', style: const TextStyle(color: Colors.white, fontSize: 14)), // SỬA: Dùng partCount
            Text('Phần ${data.partCount}', style: const TextStyle(color: Colors.white, fontSize: 14)), // SỬA: Dùng partCount
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: AppButton(
                label: 'BẮT ĐẦU',
                backgroundColor: Colors.white,
                textColor: theme.background,
                depthColor: Colors.white.withOpacity(0.5),
                onPressed: () {
                  hide(); // Đóng popup trước
                  onStart(); // Sau đó gọi callback
                },
              ),
            )
          ],
        ),
    );
  }

  void hide() {
    _entry?.remove();
    _entry = null;
  }

  void dispose() {
    hide();
  }
}