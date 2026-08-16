// lib/features/main/home/widgets/lesson_node_data.dart

import 'package:flutter/cupertino.dart';
import 'app_lesson_node.dart';
import 'oval_progress_ring.dart';

enum LessonNodeStatus { locked, learnAhead, current, done }

class LessonNodeData {
  final int id;
  final LessonNodeType type;
  final LessonNodeColor color;
  final LessonNodeStatus status;
  final double progress;
  final int partCount;
  final String title;

  const LessonNodeData({
    required this.id,
    required this.type,
    required this.color,
    required this.status,
    this.progress = 0.0,
    this.partCount = 4,
    required this.title,
  });
}

class LessonNodeTile extends StatefulWidget {
  final LessonNodeData data;

  // SỬA: Callback trả về Rect thay vì BuildContext
  // Rect là immutable data, không leak context
  final void Function(LessonNodeData data, Rect nodeRect) onTap;

  const LessonNodeTile({super.key, required this.data, required this.onTap});

  @override
  State<LessonNodeTile> createState() => _LessonNodeTileState();
}

class _LessonNodeTileState extends State<LessonNodeTile> with SingleTickerProviderStateMixin {
  // Hằng số layout — NGUỒN SỰ THẬT DUY NHẤT về hình học node + ring
  static const double _nodeSize = 58;
  static const double _nodeAspectRatio = 1.25;
  static const double _nodeDepth = 8; // PHẢI trùng depth của AppLessonNode (phần bóng 3D)
  static const double _ringPadding = 6; // khoảng hở node -> ring
  static const double _ringStroke = 7;

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

  // SỬA: Hàm lấy Rect của node
  Rect _getNodeRect() {
    final box = context.findRenderObject()! as RenderBox;
    return box.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final isCurrent = widget.data.status == LessonNodeStatus.current;
    final isLocked = widget.data.status == LessonNodeStatus.locked;
    final isLearnAhead = widget.data.status == LessonNodeStatus.learnAhead;
    final theme = LessonNodeTheme.of(widget.data.color);

    final nodeWidth = _nodeSize * _nodeAspectRatio;

    // Ring phải bao TRỌN node kể cả phần bóng depth.
    // inset = khoảng hở + nửa nét vẽ (painter deflate stroke/2 rồi)
    final inset = _ringPadding + _ringStroke / 2;
    final totalWidth  = _nodeSize * _nodeAspectRatio + inset * 2;
    final totalHeight = _nodeSize + _nodeDepth + inset * 2;

    return SizedBox(
      width: totalWidth,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (isCurrent)
            Positioned.fill(
              // ✅ SỬA: pulse CHỈ ring, node đứng yên
              child: AnimatedBuilder(
                animation: _pulseCtrl,
                builder: (context, child) {
                  final t = Curves.easeInOut.transform(_pulseCtrl.value);
                  return Transform.scale(scale: 1 + 0.06 * t, child: child);
                },
                child: RepaintBoundary(
                  child: OvalProgressRing(
                    progress: widget.data.progress,
                    segments: widget.data.partCount,
                    fillColor: theme.background,
                    strokeWidth: _ringStroke,
                  ),
                ),
              ),
            ),

          // ✅ SỬA: đặt node bằng Positioned để 4 phía cách đều ring
          // (căn giữa Stack sẽ lệch vì bóng depth trồi xuống dưới)
          Positioned(
            left: inset,
            top: inset,
            child: AppLessonNode(
              lessonType: widget.data.type,
              isLocked: isLocked,
              isLearnAhead: isLearnAhead,
              size: _nodeSize,
              aspectRatio: _nodeAspectRatio,
              depth: _nodeDepth,
              onPressed: () => widget.onTap(widget.data, _getNodeRect()),
            ),
          ),
        ],
      ),
    );
  }
}