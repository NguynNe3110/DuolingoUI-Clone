import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class TrophyIcon extends StatelessWidget {
  final bool isCurrent;
  final String pathIcon;

  const TrophyIcon({required this.pathIcon, this.isCurrent = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Image.asset(
        pathIcon,
        width: isCurrent ? 96 : 64,
      ),
    );
  }
}
