// features/main/home/layout/section_scroll_tracker.dart
import 'package:flutter/widgets.dart';


/// Theo dõi các anchor (mốc vị trí) trên cây cuộn.
/// activeIndex = index của anchor CUỐI CÙNG đã vượt lên trên ngưỡng.
class SectionScrollTracker {
  SectionScrollTracker({required this.controller, this.threshold = 150});

  final ScrollController controller;
  double threshold;

  final ValueNotifier<int> activeIndex = ValueNotifier(0);
  final List<GlobalKey> _anchors = [];

  void attachAnchors(List<GlobalKey> keys) {
    _anchors
      ..clear()
      ..addAll(keys);
    WidgetsBinding.instance.addPostFrameCallback((_) => _recompute());
  }

  void start() => controller.addListener(_recompute);

  void dispose() {
    controller.removeListener(_recompute);
    activeIndex.dispose();
  }

  void _recompute() {
    var active = 0;
    for (var i = 0; i < _anchors.length; i++) {
      final ctx = _anchors[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      if (box.localToGlobal(Offset.zero).dy < threshold) active = i;
    }
    if (activeIndex.value != active) activeIndex.value = active;
  }
}