import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_icon.dart';

class BoostFab extends StatelessWidget {
  const BoostFab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // mở màn hình "Ghép từ siêu tốc"
      },
      child: Image.asset(
        AppIcon.imgFABLeaderboard,
        width: 64,
      ),
    );
  }
      // child: Column(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     SvgPlaceholder(icon: Icons.bolt_rounded, size: 56, color: Color(0xFFEF4444)),
      //     SizedBox(height: 2),
      //     Container(
      //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      //       decoration: BoxDecoration(
      //         color: Color(0xFFEF4444),
      //         borderRadius: BorderRadius.all(Radius.circular(16)),
      //       ),
      //       child: Text(
      //         '+360 KN',
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.w800,
      //           fontSize: 14,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),

}

//
// FloatingActionButton( các thuôc tinh của FAB
// onPressed: () {},
// backgroundColor: Colors.transparent,
// elevation: 0,
// highlightElevation: 0,   // bóng khi NHẤN
// focusElevation: 0,       // bóng khi focus (bàn phím)
// hoverElevation: 0,       // bóng khi hover (chuột)
// disabledElevation: 0,
// splashColor: Colors.transparent, // tắt luôn ripple tròn
// child: Image.asset(AppIcon.imgFABLeaderboard, width: 64),
// )