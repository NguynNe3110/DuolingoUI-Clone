// widgets/lesson_node_tile.dart
import 'package:flutter/cupertino.dart';

import 'app_lesson_node.dart';
import 'oval_progress_ring.dart';

enum LessonNodeStatus { locked, current, done }

class LessonNodeData {
  final int id;
  final LessonNodeType type;
  final LessonNodeColor color; // Data model vẫn cần lưu màu để popup biết đường vẽ
  final LessonNodeStatus status;
  final double progress;
  final int segments;

  const LessonNodeData({
    required this.id,
    required this.type,
    required this.color,
    required this.status,
    this.progress = 0.0,
    this.segments = 4,
  });
}

class LessonNodeTile extends StatefulWidget {
  final LessonNodeData data;
  // Callback trả về BuildContext của chính node đó để Popup tính tọa độ
  final void Function(BuildContext nodeContext, LessonNodeData data) onTap;

  const LessonNodeTile({super.key, required this.data, required this.onTap});

  @override
  State<LessonNodeTile> createState() => _LessonNodeTileState();
}

class _LessonNodeTileState extends State<LessonNodeTile> with SingleTickerProviderStateMixin {
  late final AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    if (widget.data.status == LessonNodeStatus.current) _pulseCtrl.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant LessonNodeTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    final wasCurrent = oldWidget.data.status == LessonNodeStatus.current;
    final isCurrent = widget.data.status == LessonNodeStatus.current;
    if (wasCurrent != isCurrent) {
      isCurrent ? _pulseCtrl.repeat(reverse: true) : _pulseCtrl.stop();
    }
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.data.status == LessonNodeStatus.current;
    final isLocked = widget.data.status == LessonNodeStatus.locked;
    final theme = LessonNodeTheme.of(widget.data.color);

    const nodeSize = 70.0;
    const aspectRatio = 1.1;
    const ringPadding = 8.0;
    const ringStroke = 5.0;

    final totalWidth = nodeSize * aspectRatio + ringPadding * 2 + ringStroke;
    final totalHeight = nodeSize + ringPadding * 2 + ringStroke;

    Widget content = SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          if (isCurrent)
            Positioned.fill(
              child: RepaintBoundary(
                child: OvalProgressRing(
                  progress: widget.data.progress,
                  segments: widget.data.segments,
                  fillColor: theme.background,
                  strokeWidth: ringStroke,
                ),
              )
            ),

          Builder( //here
            builder: (nodeCtx) {
              return AppLessonNode(
                lessonType: widget.data.type,
                isLocked: isLocked,
                size: nodeSize,
                aspectRatio: aspectRatio,
                // voidcallback là ham nhan khong tham so duoc khai bao o app_lesson_node, vi the o day phai la k tham so
                onPressed: () => widget.onTap(nodeCtx, widget.data), // nhưng muốn lấy context? thế nên ta cần phải bọc nó ở trong builder để lấy context
              );
            },
          ),
        ],
      ),
    );

    if (!isCurrent) return content;

    return AnimatedBuilder(
      animation: _pulseCtrl,
      child: content,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_pulseCtrl.value);
        return Transform.scale(scale: 1 + 0.06 * t, child: child);
      },
    );
    // return content; mock test
  }
}