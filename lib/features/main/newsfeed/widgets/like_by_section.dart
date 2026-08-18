import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/material.dart';

// Widget hiển thị người thích (Avatar chồng lên nhau)
class LikedBySection extends StatelessWidget {
  final List<String> names;

  const LikedBySection({required this.names});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Stack để xếp chồng Avatar
        SizedBox(
          width: names.length >= 3 ? 60 : 20, // Đủ rộng cho 3 avatar chồng lên nhau
          height: 24,
          child: Stack(
            children: List.generate(names.length > 3 ? 3 : names.length, (index) {
              return Positioned(
                left: index * 16.0, // Dịch chuyển sang phải, chồng lên nhau
                child: Image.asset(
                  AppIcon.avatar,
                  width: 24,
                )
              );
            }),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "${names.first} và nhiều người khác đã thích",
            style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}