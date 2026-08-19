import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';


const Color _textGrayOnBackground = AppColors.textGrayOnBackground;


class SectionHeaderWidget extends StatelessWidget {
  final String title;

  final bool? showArrow;
  final VoidCallback? onTap;

  const SectionHeaderWidget({
    required this.title,
    this.onTap,
    this.showArrow = false,

  });
  @override
  Widget build(BuildContext context) {
    return _sectionHeader(
      title,
      showArrow: showArrow!,
      onTap: onTap,
    );
  }

  Widget _sectionHeader(
      String title, {
        bool showArrow = false,
        VoidCallback? onTap,
      }) {
    final content = Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: _textGrayOnBackground,
            letterSpacing: 0.01,
          ),
        ),
        if (showArrow) const Spacer(),
        if (showArrow)
          const Icon(Icons.chevron_right, size: 20, color: _textGrayOnBackground),
      ],
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, child: content);
    }
    return content;
  }
}

// Widget _sectionHeader( // casch khai bao hay
//     String title, {
//       bool showArrow = false,
//       VoidCallback? onTap,
//     }) {
//   final content = Row(
//     children: [
//       Text(
//         title,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.bold,
//           color: _textGray,
//           letterSpacing: 1.0,
//         ),
//       ),
//       if (showArrow) const Spacer(),
//       if (showArrow)
//         const Icon(Icons.chevron_right, size: 20, color: _textGray),
//     ],
//   );
//
//   if (onTap != null) {
//     return InkWell(onTap: onTap, child: content);
//   }
//   return content;
// }