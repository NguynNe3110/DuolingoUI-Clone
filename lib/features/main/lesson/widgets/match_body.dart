import 'dart:async';
import 'dart:math';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_answer_card.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/exercise_entities.dart';


class MatchBody extends StatefulWidget {
  final Exercise exercise;
  final bool? checkedCorrect;
  final ValueChanged<Object?> onAnswerChanged;

  const MatchBody({
    super.key,
    required this.exercise,
    required this.checkedCorrect,
    required this.onAnswerChanged,
  });

  @override
  State<MatchBody> createState() => _MatchBodyState();
}

class _MatchBodyState extends State<MatchBody> {
  late final List<String> _lefts = [for (final p in widget.exercise.pairs) p.left];
  late final List<String> _rights =
  [for (final p in widget.exercise.pairs) p.right]..shuffle(Random());

  String? _selLeft;
  String? _selRight;
  final Set<String> _matched = {};
  final Set<String> _wrongFlash = {};
  final Set<String> _correctFlash = {};
  final List<Timer> _timers = [];

  @override
  void dispose() {
    for (final t in _timers) t.cancel();
    super.dispose();
  }

  void _tap(String v, bool isLeft) {
    if (_matched.contains(v) ||
        _wrongFlash.contains(v) ||
        _correctFlash.contains(v)) return;

    setState(() {
      if (isLeft) _selLeft = (_selLeft == v) ? null : v;
      else        _selRight = (_selRight == v) ? null : v;
    });
    _tryMatch();
  }

  void _tryMatch() {
    final l = _selLeft, r = _selRight;
    if (l == null || r == null) return;

    // nhả selection ngay để user ghép cặp khác trong khi effect đang chạy
    setState(() { _selLeft = null; _selRight = null; });

    final ok = widget.exercise.pairs.any((p) => p.left == l && p.right == r);
    if (ok) {
      setState(() => _correctFlash.addAll([l, r]));
      _timers.add(Timer(AppAnswerCard.bounceDuration, () {
        if (!mounted) return;
        setState(() {
          _correctFlash.removeAll([l, r]);
          _matched.addAll([l, r]);        // → disabled: mờ, phẳng
        });
        if (_matched.length == widget.exercise.pairs.length * 2) {
          widget.onAnswerChanged(true);   // hết cặp → báo shell
        }
      }));
    } else {
      setState(() => _wrongFlash.addAll([l, r]));   // → wrong + shake
      _timers.add(Timer(
        AppAnswerCard.shakeDuration + AppAnswerCard.settleBuffer,
            () {
          if (!mounted) return;
          setState(() => _wrongFlash.removeAll([l, r])); // shake xong → idle
        },
      ));
    }
  }

  AnswerCardStatus _statusOf(String v) {
    if (_wrongFlash.contains(v)) return AnswerCardStatus.wrong;
    if (_correctFlash.contains(v)) return AnswerCardStatus.correct;
    if (_matched.contains(v)) return AnswerCardStatus.disabled;
    if (v == _selLeft || v == _selRight) return AnswerCardStatus.selected;
    return AnswerCardStatus.idle;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _column(_lefts, true)),
          const SizedBox(width: 12),
          Expanded(child: _column(_rights, false)),
        ],
      ),
    );
  }

  Widget _column(List<String> items, bool isLeft) => Column(
    children: [
      for (final v in items) ...[
        AppAnswerCard(
          status: _statusOf(v),
          shakeOnWrong: true,   // match: sai → shake
          fillWidth: true,
          onPressed: () => _tap(v, isLeft),
          child: Text(v,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(height: 12),
      ],
    ],
  );
}