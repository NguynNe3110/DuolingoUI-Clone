import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_icon.dart';
import '../../core/theme/app_radius.dart';
import 'mock_1.dart';

class Mockscreen extends StatelessWidget {
  Mockscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MockData();
  }
}

class MockData extends StatelessWidget {
  MockData({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(

        backgroundColor: const Color(0xFFABFFF8),
        title: const Text('Mock Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(

              children: [
                // gồm 1 vài text và button
                // Mock1(),
                AppButton(
                  iconPath: AppIcon.home,
                  label: 'XEM NHIỆM VỤ NGAY',
                  variant: ButtonVariant.secondary,
                  onPressed: () => {},

                ),


                SizedBox(height: 12,),


                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Color(0xFFBBECFD),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF8EDFFF),
                      width: 2,
                    ),
                  ),
                  child: SvgPicture.asset(
                    AppIcon.home,
                    width: 24,
                    height: 24,
                  ),
                ),

                Container(
                  child: Image.asset('assets/images/duolingo.png',
                  width: 400,),

                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
