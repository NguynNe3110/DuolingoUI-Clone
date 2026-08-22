import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatCardResult extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final String value;
  final String pathIcon;

  StatCardResult({
    super.key,
    required this.backgroundColor,
    required this.label,
    required this.value,
    required this.pathIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:EdgeInsetsGeometry.symmetric(vertical: 2),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.1,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    pathIcon,
                  width: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  value,
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}