import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_icon.dart';
import 'package:duolingo_ui_clone/core/widgets/app_button.dart';
import 'package:duolingo_ui_clone/core/widgets/app_duo_sentence.dart';
import 'package:duolingo_ui_clone/core/widgets/app_speech_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../domain/entities/exercise_entities.dart';
import 'match_body.dart';
import 'pick_image_body.dart';
import 'pick_translation_body.dart';
import 'result_sheet.dart';
import 'translate_body.dart';

class ExercisePage extends StatefulWidget {
  final Exercise exercise;
  final ValueChanged<bool> onDone;

  const ExercisePage({super.key, required this.exercise, required this.onDone});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sheetCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  Object? _answer; // String? (pick*) | List<String> (translate)
  bool? _checked; // null = chưa kiểm tra

  bool get _hasAnswer {
    final a = _answer;
    if (a is List<String>) return a.isNotEmpty;
    return a != null;
  }

  bool _evaluate() {
    if (widget.exercise.type == ExerciseType.match) {
      return _answer == true;
    }
    final a = _answer;
    if (a is List<String>) return a.join(' ') == widget.exercise.correct;
    return a == widget.exercise.correct;
  }

  void _check() {
    setState(() => _checked = _evaluate());
    _sheetCtrl.forward();
  }

  @override
  void dispose() {
    _sheetCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: _checked != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildQuestionHeader(),
              const SizedBox(height: AppSpacing.S16),
              Expanded(child: _buildBody()),
              _buildCheckBar(),
            ],
          ),
        ),
        if (_checked != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                  .animate(
                    CurvedAnimation(parent: _sheetCtrl, curve: Curves.easeOut),
                  ),
              child: ResultSheet(
                isCorrect: _checked!,
                correctAnswer: widget.exercise.correct,
                onContinue: () => widget.onDone(_checked!),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuestionHeader() {
    final e = widget.exercise;
    final title = switch (e.type) {
      ExerciseType.translate => 'Dịch câu này',
      ExerciseType.pickTranslation => 'Chọn bản dịch đúng',
      ExerciseType.pickImage => 'Chọn hình ảnh đúng',
      ExerciseType.match => 'Ghép các cặp từ',
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (e.isNewWord)
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcon.newWordInLesson,
                    width: 20,
                  ),
                  // Icon(Icons.auto_awesome, size: 18, color: Color(0xFF8A5CF6)),
                  SizedBox(width: 6),
                  Text(
                    'TỪ VỰNG MỚI',
                    style: TextStyle(
                      color: Color(0xFF8A5CF6),
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      letterSpacing: 0.1
                    ),
                  ),
                ],
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: AppColors.textOnBackground,
            ),
          ),
          // const SizedBox(height: AppSpacing.S12),

          // ── Bài chọn hình: loa + dotText (DuoWord tím, gạch nét đứt) ──
          if (e.type == ExerciseType.pickImage)
            Row(
              children: [
                AppButton(
                  iconPath: AppIcon.volumeOnWhite ,
                  variant: ButtonVariant.secondary,
                  widthIcon: 20,
                  // width: 62,
                  height: 48,
                ),
                // IconButton(
                //   onPressed: () {
                //   },
                //   icon: const Icon(
                //     Icons.volume_up_rounded,
                //     size: 40,
                //     color: Color(0xFF1CB0F6),
                //   ),
                // ),
                const SizedBox(width: 8),
                DuoWord(
                  // ← dotText
                  word: e.prompt,
                  revealed: true,
                  tappable: true,
                  meanings: e.meanings[e.prompt] ?? const [],
                  revealedColor: const Color(0xFF8A5CF6),
                  lineColor: const Color(0xFFC9A6F5),
                ),
              ],
            )
          // ── Bài dịch / chọn bản dịch: nhân vật + bubble chứa dotText ──
          else if (e.type == ExerciseType.match)
            const SizedBox.shrink()
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _CharacterMock(asset: e.characterAsset),
                const SizedBox(width: 12),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: AppSpeechBubble(
                    tail: BubbleTail.left,
                    child: AppDuoSentence(
                      text: e.prompt,
                      meanings: e.meanings,
                      // chọn bản dịch: câu tĩnh, chữ trơn | dịch: từng từ reveal + gạch nét đứt
                      revealAll: e.type == ExerciseType.pickTranslation,
                      tappable:
                          e.type ==
                          ExerciseType.translate, // ← dotText trong bubble
                      onSpeak: _isLikelyEnglish(e.prompt) ? () {} : null,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildBody() => switch (widget.exercise.type) {
    ExerciseType.translate => TranslateBody(
      exercise: widget.exercise,
      checkedCorrect: _checked,
      onAnswerChanged: (a) => setState(() => _answer = a),
    ),
    ExerciseType.pickTranslation => PickTranslationBody(
      selected: _answer as String?, // why
      exercise: widget.exercise,
      checkedCorrect: _checked,
      onSelect: (a) => setState(() => _answer = a),
    ),
    ExerciseType.pickImage => PickImageBody(
      selected: _answer as String?, //

      exercise: widget.exercise,
      checkedCorrect: _checked,
      onSelect: (a) => setState(() => _answer = a),
    ),
    ExerciseType.match => MatchBody(
      exercise: widget.exercise,
      checkedCorrect: _checked,
      onAnswerChanged: _onMatchAnswerChanged,
    ),
  };

  Widget _buildCheckBar() {
    if (widget.exercise.type == ExerciseType.match) {
      return const SizedBox(height: AppSpacing.S16);
    }

    final enabled = _hasAnswer && _checked == null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.S16,
        0,
        AppSpacing.S16,
        16,
      ),
      child: AppButton(
        label: 'KIỂM TRA',
        variant: enabled
            ? ButtonVariant.primary
            : ButtonVariant.ghost, // ← primary khi có đáp án, ghost khi chưa
        isEnabled: enabled,
        height: 56,
        width: double.infinity,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
        onPressed: enabled ? _check : null,
      ),
    );
  }

  void _onMatchAnswerChanged(Object? value) {
    if (value == true && _checked == null) {
      setState(() {
        _answer = value;
        _checked = true;
      });
      _sheetCtrl.forward(from: 0);
      return;
    }

    setState(() => _answer = value);
  }

  bool _isLikelyEnglish(String text) {
    final cleaned = text.replaceAll(RegExp(r"[^A-Za-z\s\?'!\.,-]"), '');
    return cleaned.trim().isNotEmpty && cleaned.length == text.length;
  }
}

class _CharacterMock extends StatelessWidget {
  final String asset;
  const _CharacterMock({required this.asset});

  String _resolveCharacterAsset() {
    return switch (asset) {
      'zari.svg' => AppIcon.charOlderSister,
      'easy.svg' => AppIcon.charDuoHi,
      'oscar.svg' => AppIcon.charUncle,
      'lin.svg' => AppIcon.charAunt,
      '' => AppIcon.charDuoHello,
      _ => asset,
    };
  }

  @override
  Widget build(BuildContext context) {
    final resolvedAsset = _resolveCharacterAsset();
    return SizedBox(
      width: 110,
      height: 220,
      child: Center(
        child: Image.asset(
          resolvedAsset,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.person,
            size: 230,
            color: AppColors.grayBorder200,
          ),
        ),
      ),
    );
  }
}
