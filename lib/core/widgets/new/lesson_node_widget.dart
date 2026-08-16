import 'dart:async';

import 'package:duolingo_ui_clone/core/widgets/new/pulse_scale.dart';
import 'package:duolingo_ui_clone/core/widgets/new/segmented_progress_ring.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lesson_node.dart';

class LessonNodeWidget extends StatelessWidget {
  const LessonNodeWidget({super.key, required this.node, required this.onTap});

  final LessonNode node;
  final void Function(BuildContext nodeContext) onTap;

  @override
  Widget build(BuildContext context) {
    final isCurrent = node.status == LessonStatus.current;

    return SizedBox(
      width: 88, height: 88,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Điều kiện nằm NGAY tại cây widget: node không current
          // => PulseScale không được build => không có controller => không leak.
          if (isCurrent)
            PulseScale(
              child: SegmentedProgressRing(
                  progress: node.progress, segments: node.segments),
            ),
          _NodeButton(node: node, onPressed: () => onTap(context)),
        ],
      ),
    );
  }
}

class _NodeButton extends StatefulWidget {
  const _NodeButton({required this.node, required this.onPressed});
  final LessonNode node;
  final VoidCallback onPressed;
  @override
  State<_NodeButton> createState() => _NodeButtonState();
}

class _NodeButtonState extends State<_NodeButton> {
  static const double _depth = 3.5;
  bool _pressed = false;
  Timer? _releaseTimer;

  @override
  void dispose() { _releaseTimer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final locked = widget.node.status == LessonStatus.locked;
    final bg     = locked ? const Color(0xFFE5E5E5) : const Color(0xFF58CC02);
    final depthC = locked ? const Color(0xFFCFCFCF) : const Color(0xFF46A302);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_, ) { _releaseTimer?.cancel(); setState(() => _pressed = true); },
      onTapUp: (_, ) {
        _releaseTimer = Timer(const Duration(milliseconds: 40),
                () { if (mounted) setState(() => _pressed = false); });
        widget.onPressed();
      },
      onTapCancel: () { _releaseTimer?.cancel(); setState(() => _pressed = false); },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeOut,
        width: 62, height: 62,
        transform: Matrix4.translationValues(0, _pressed ? _depth : 0, 0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bg,
          boxShadow: [BoxShadow(
            color: depthC, blurRadius: 0,
            offset: Offset(0, _pressed ? 0 : _depth), // "cạnh 3D"
          )],
        ),
        child: Icon(widget.node.icon, size: 30,
            color: locked ? const Color(0xFFAFAFAF) : Colors.white),
      ),
    );
  }
}