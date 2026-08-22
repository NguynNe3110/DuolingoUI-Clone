import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_icon.dart';
import 'package:duolingo_ui_clone/core/widgets/app_answer_card.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/exercise_entities.dart';

class PickImageBody extends StatelessWidget {
  final Exercise exercise;
  final String? selected;
  final bool? checkedCorrect;
  final ValueChanged<String> onSelect;

  const PickImageBody({
    super.key,
    required this.exercise,
    required this.selected,
    required this.checkedCorrect,
    required this.onSelect,
  });

  AnswerCardStatus _statusOf(String option) {
    if (checkedCorrect != null) {
      return option == selected
          ? (checkedCorrect!
                ? AnswerCardStatus.correct
                : AnswerCardStatus.wrong)
          : AnswerCardStatus.idle;
    }
    return option == selected
        ? AnswerCardStatus.selected
        : AnswerCardStatus.idle;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.73,
        children: [
          for (var i = 0; i < exercise.options.length; i++)
            AppAnswerCard(
              status: _statusOf(exercise.options[i]),
              onPressed: () => onSelect(exercise.options[i]),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: _ImageMock(asset: exercise.imageAssets?[i] ?? ''),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exercise.options[i],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
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

/// TODO: thay bằng SvgPicture.asset(asset)
class _ImageMock extends StatelessWidget {
  final String asset;
  const _ImageMock({required this.asset});

  String _resolveAsset() {
    return switch (asset) {
      'sugar.svg' => AppIcon.lessonSuggar,
      'milk.svg' => AppIcon.lessonMilk,
      'tea.svg' => AppIcon.lessonTea,
      'coffee.svg' => AppIcon.lessonCafe,
      '' => AppIcon.lessonTea,
      _ => asset,
    };
  }

  @override
  Widget build(BuildContext context) {
    final resolvedAsset = _resolveAsset();
    return Image.asset(
      resolvedAsset,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(
        Icons.image_outlined,
        size: 90,
        color: AppColors.grayBorder200,
      ),
    );
  }
}
