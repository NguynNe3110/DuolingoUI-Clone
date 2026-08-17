// features/main/home/layout/path_door.dart
import 'package:flutter/material.dart';
import 'path_layout_engine.dart';

class PathDoor extends StatelessWidget {
  const PathDoor({
    super.key,
    required this.offsets,
    required this.children,
    this.a = 52,
    this.b = 92,
    this.rowHeight = 112,
  });

  final List<int> offsets;
  final List<Widget> children;
  final double a, b, rowHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < children.length; i++)
          SizedBox(
            height: rowHeight,
            child: Center(
              child: Transform.translate(
                offset: Offset(PathLayoutEngine.toDx(offsets[i], a, b), 0),
                child: children[i],
              ),
            ),
          ),
      ],
    );
  }
}