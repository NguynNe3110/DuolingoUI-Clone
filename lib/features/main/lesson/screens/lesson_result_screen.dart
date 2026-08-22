import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_icon.dart';
import '../../../../core/widgets/app_button.dart';
import '../widgets/stat_card_result.dart';

class LessonResultScreen extends StatelessWidget {
  final int totalExercises;
  final int correctCount;
  final int energy;

  const LessonResultScreen({
    super.key,
    this.totalExercises = 0,
    this.correctCount = 0,
    this.energy = 0,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = totalExercises > 0
        ? ((correctCount / totalExercises) * 100).round()
        : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),

                    Image.asset(AppIcon.imageDuoResult, width: 260),

                    const SizedBox(height: 16),

                    const Text(
                      'Hoàn thành bài học!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFFF9600),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Row(
                      children: [
                        Expanded(
                          child: StatCardResult(
                            label: 'TỔNG ĐIỂM KN',
                            value: '${correctCount * 5}',
                            pathIcon: AppIcon.lightning,
                            backgroundColor: AppColors.duoYellow,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: StatCardResult(
                            label: 'TỐT',
                            value: '$accuracy%',
                            pathIcon: AppIcon.target,

                            backgroundColor: AppColors.duoGreen,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: StatCardResult(
                            label: 'NĂNG LƯỢNG',
                            value: '$energy',
                            pathIcon: AppIcon.heart,

                            backgroundColor: AppColors.duoBlue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  AppButton(
                    onPressed: () => {},
                    variant: ButtonVariant.neutral,
                    iconPath: AppIcon.share,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      label: 'HOÀN THÀNH',
                      onPressed: () => context.go('/home'),
                      variant: ButtonVariant.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
