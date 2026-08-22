import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_answer_card.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/exercise_entities.dart';

class PickTranslationBody extends StatelessWidget {
  final Exercise exercise;
  final String? selected;
  final bool? checkedCorrect;
  final ValueChanged<String> onSelect;

  const PickTranslationBody({
    super.key,
    required this.exercise,
    required this.selected,
    required this.checkedCorrect,
    required this.onSelect,
  });

  AnswerCardStatus _statusOf(String option) {
    if (checkedCorrect != null) {
      return option == selected
          ? (checkedCorrect! ? AnswerCardStatus.correct : AnswerCardStatus.wrong)
          : AnswerCardStatus.idle;
    }
    return option == selected ? AnswerCardStatus.selected : AnswerCardStatus.idle;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        for (final option in exercise.options)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: SizedBox(
              width: double.infinity,
              child: AppAnswerCard(
                status: _statusOf(option),
                onPressed: () => onSelect(option),
                child: Text(option,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}