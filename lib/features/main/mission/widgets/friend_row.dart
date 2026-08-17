import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// 1 dòng bạn bè: ● Tên ... X KN
class FriendRow extends StatelessWidget {
  final Color dotColor;
  final String name;
  final String score;

  const FriendRow({
    required this.dotColor,
    required this.name,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        const Spacer(),
        Text(
          score,
          style: const TextStyle(fontSize: 16, color: Color(0xFF8A8A8A)),
        ),
      ],
    );
  }
}