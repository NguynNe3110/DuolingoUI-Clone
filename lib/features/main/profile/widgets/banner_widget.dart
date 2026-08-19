import 'package:flutter/material.dart';

import '../../../../core/theme/app_icon.dart';

class BannerWidget extends StatelessWidget {

  const BannerWidget();

  @override
  Widget build(BuildContext context) {
    return _buildBanner();
  }

  Widget _buildBanner() {
    return Container(
      height: 180,
      width: double.infinity,
      child: Image.asset(
        AppIcon.bannerSelf,
        fit: BoxFit.fill,
      ),
    );
  }
}