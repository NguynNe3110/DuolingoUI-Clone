
import 'package:duolingo_ui_clone/core/theme/app_colors.dart';
import 'package:duolingo_ui_clone/core/theme/app_icon.dart';
import 'package:duolingo_ui_clone/core/theme/app_images.dart';
import 'package:duolingo_ui_clone/core/theme/app_spacing.dart';
import 'package:duolingo_ui_clone/core/theme/app_text_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AfterSplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.background,
      body: Padding(

        padding: EdgeInsets.all(AppSpacing.S16),
            child: Column(

              children: [
                Expanded(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.duo_after_splash,
                          width: 100,
                        ),
                        SizedBox(height: AppSpacing.S16,),

                        SvgPicture.asset(AppIcon.logoTextGreen, width: 120,),
                        SizedBox(height: AppSpacing.S8  ,),

                        Text('Học miễn phí. Suốt đời',
                          style: AppTextTheme.light.titleSmall//.copyWith(color: AppColors.textGrayOnBackground),
                        ),
                      ],
                    )
                ),

                Column(
                  children: [
                    AppButton(
                      label: 'BẮT ĐẦU NGAY',
                      onPressed: () => {},
                      textColor: AppColors.background,
                    ),

                    SizedBox(height: AppSpacing.S16,),

                    AppButton(
                      label: 'TÔI ĐÃ CÓ TÀI KHOẢN',
                      onPressed: () => {
                        context.pushNamed(
                          'login',
                          // pathParameters: {'id': '123'}, // Truyền param vào URL
                          // extra: {'data': 'some_object'}, // Truyền object phức tạp (không hiển thị trên URL)
                        )
                      },
                      backgroundColor: AppColors.background,
                      textColor: AppColors.duoGreen,
                      borderColor: AppColors.grayBorder200,
                      depthColor: AppColors.grayBorder200,
                    ),
                  ],
                ),
                SizedBox(height: 24,)
              ],
            )
      ),
    );
  }
}