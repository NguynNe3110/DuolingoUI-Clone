import 'dart:async';
import 'dart:math';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/theme/app_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

enum AnswerCardStatus {
  idle,
  selected,
  correct,
  wrong,
  retry,
  disabled, // match: cặp đã ghép xong → mờ, phẳng, không bấm được
}

class AppAnswerCard extends StatefulWidget {
  final Widget child;
  final AnswerCardStatus status;
  final bool fillWidth;

  /// Config theo dạng bài — KHÔNG phải state:
  /// match 2 cột = true (sai → shake), normal = false (sai → chỉ đỏ)
  final bool shakeOnWrong;

  final VoidCallback? onPressed;
  final EdgeInsets padding;

  // ── Hợp đồng thời gian cho screen đặt timer reset ──
  static const Duration shakeDuration = Duration(milliseconds: 400);
  static const Duration bounceDuration = Duration(milliseconds: 500);
  static const Duration settleBuffer = Duration(milliseconds: 100);

  const AppAnswerCard({
    super.key,
    required this.child,
    required this.status,
    this.shakeOnWrong = false,
    this.onPressed,
    this.fillWidth = false,
    this.padding = const EdgeInsets.all(AppSpacing.S16),
  });

  @override
  State<AppAnswerCard> createState() => _AppAnswerCardState();
}

class _AppAnswerCardState extends State<AppAnswerCard>
    with TickerProviderStateMixin {
  static const double _depth = 2;

  bool _pressed = false;
  Timer? _releaseTimer;

  // ── SHAKE (chỉ chạy khi vào wrong VÀ shakeOnWrong) ──
  late final AnimationController _shakeController = AnimationController(
    vsync: this,
    duration: AppAnswerCard.shakeDuration,
  );

  late final Animation<double> _shakeX = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: -9.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 15,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -9.0,
        end: 8.0,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 20,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 8.0,
        end: -6.0,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 20,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -6.0,
        end: 4.0,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 20,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 4.0,
        end: -2.0,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 15,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -2.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 10,
    ),
  ]).animate(_shakeController);

  // ── JELLY BOUNCE (chạy khi vào correct) ──
  late final AnimationController _bounceController = AnimationController(
    vsync: this,
    duration: AppAnswerCard.bounceDuration,
  );

  late final Animation<double> _bounceY = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: 2.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 12,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 2.0,
        end: -19.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 30,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -19.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 24,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: -4.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 17,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: -4.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 17,
    ),
  ]).animate(_bounceController);

  late final Animation<double> _scaleX = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.10,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 12,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.10,
        end: 0.94,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 30,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.94,
        end: 1.08,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 24,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.08,
        end: 0.97,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 17,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.97,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 17,
    ),
  ]).animate(_bounceController);

  late final Animation<double> _shadowScaleX = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 12,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 0.84,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 30,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.84,
        end: 1.08,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 24,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.08,
        end: 0.97,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 17,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.97,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 17,
    ),
  ]).animate(_bounceController);

  late final Animation<double> _scaleY = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 0.86,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 12,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.86,
        end: 1.08,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 30,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.08,
        end: 0.92,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 24,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 0.92,
        end: 1.03,
      ).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 17,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.03,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: 17,
    ),
  ]).animate(_bounceController);

  bool get _isDisabled => widget.status == AnswerCardStatus.disabled;

  void _handleTapDown(TapDownDetails details) {
    if (_isDisabled) return; // disabled: không cả hiệu ứng lún
    _releaseTimer?.cancel();
    setState(() => _pressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    if (_isDisabled) return;
    _releaseTimer = Timer(const Duration(milliseconds: 40), () {
      if (mounted) setState(() => _pressed = false);
    });
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    _releaseTimer?.cancel();
    setState(() => _pressed = false);
  }

  // ════════════════════════════════════════════════════════
  // Card CHỈ phát effect khi transition — không tự đổi state,
  // không timer reset. "Shake xong về idle" là việc của screen.
  // ════════════════════════════════════════════════════════
  @override
  void didUpdateWidget(covariant AppAnswerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status == widget.status) return;
    if (widget.status == AnswerCardStatus.correct) {
      _bounceController.forward(from: 0);
    }
    if (widget.status == AnswerCardStatus.wrong && widget.shakeOnWrong) {
      _shakeController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _releaseTimer?.cancel();
    _shakeController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  // ── Palette ──
  Color _backgroundColor() => switch (widget.status) {
    AnswerCardStatus.idle => AppColors.background,
    AnswerCardStatus.selected => AppColors.blueSurface150,
    AnswerCardStatus.correct => AppColors.greenSurface250,
    AnswerCardStatus.wrong => AppColors.redSurface150,
    AnswerCardStatus.retry => AppColors.yellowSurface200,

    AnswerCardStatus.disabled => AppColors.background,
  };

  Color _textColor() => switch (widget.status) {
    AnswerCardStatus.idle => AppColors.textOnBackground,
    AnswerCardStatus.selected => AppColors.textBlueOnSurface150,
    AnswerCardStatus.correct => AppColors.textGreenOnSurface250,
    AnswerCardStatus.wrong => AppColors.textRedOnSurface150,
    AnswerCardStatus.retry => AppColors.textYellowOnSurface200,

    // TODO: thay bằng token text-disabled của bạn nếu có
    AnswerCardStatus.disabled => AppColors.grayBorder200,
  };

  Color _depthColor() => switch (widget.status) {
    AnswerCardStatus.idle => AppColors.grayBorder200,
    AnswerCardStatus.selected => AppColors.blueBorder150,
    AnswerCardStatus.correct => AppColors.greenBorder250,
    AnswerCardStatus.wrong => AppColors.redBorder150,
    AnswerCardStatus.retry => AppColors.yellowBorder200,

    // disabled = phẳng, không còn cạnh 3D (đúng như video)
    AnswerCardStatus.disabled => Colors.transparent,
  };

  Color _borderColor() => switch (widget.status) {
    AnswerCardStatus.idle => AppColors.grayBorder200,
    AnswerCardStatus.selected => AppColors.blueBorder150,
    AnswerCardStatus.correct => AppColors.greenBorder250,
    AnswerCardStatus.wrong => AppColors.redBorder150,
    AnswerCardStatus.retry => AppColors.yellowBorder200,

    AnswerCardStatus.disabled => AppColors.grayBorder200,
  };

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_shakeController, _bounceController]),
      builder: (context, _) {
        final double bounceOffset = _bounceY.value;
        // final double lift = max(0.0, -bounceOffset); // độ cao card đang bay lên
        // final double groundShadowOpacity =
        // (lift / 16.0).clamp(0.0, 0.5).toDouble(); // càng cao càng mờ

        return Stack(
          fit: widget.fillWidth ? StackFit.passthrough : StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            // ── Ground Shadow: chỉ hiện khi card nhảy lên ──
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()..scale(_shadowScaleX.value, 1, 1),

                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.graySurface200,
                    borderRadius: BorderRadius.circular(AppRadius.r14),
                  ),
                ),
              ),
            ),

            // ── Card: giữ nguyên logic ban đầu (có boxShadow depth) ──
            Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..translate(
                  _shakeX.value,
                  bounceOffset + (_pressed ? _depth : 0),
                  0,
                )
                ..scale(_scaleX.value, _scaleY.value, 1),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 30),
                  curve: Curves.easeOut,
                  alignment: widget.fillWidth ? Alignment.center : null,
                  decoration: BoxDecoration(
                    color: _backgroundColor(),
                    borderRadius: BorderRadius.circular(AppRadius.r14),
                    border: Border.all(
                      color: _borderColor(),
                      width: AppBorder.b2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _depthColor(),
                        offset: Offset(0, (_pressed) ? 0 : _depth),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: DefaultTextStyle.merge(
                    style: TextStyle(color: _textColor()),
                    child: IconTheme(
                      data: IconThemeData(color: _textColor()),
                      child: Padding(
                        padding: widget.padding,
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
