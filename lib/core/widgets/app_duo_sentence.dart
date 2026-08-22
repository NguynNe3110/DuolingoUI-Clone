// core/widgets/app_duo_sentence.dart
import 'dart:math' as math;
import 'package:duolingo_ui_clone/core/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_speech_bubble.dart';

class DashedUnderlinePainter extends CustomPainter {
  const DashedUnderlinePainter({
    required this.color,
    this.dashWidth = 7,
    this.dashGap = 5,
    this.thickness = 3,
  });

  final Color color;
  final double dashWidth;
  final double dashGap;
  final double thickness;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final y = size.height - thickness;
    double x = 0;
    while (x < size.width) {
      final w = math.min(dashWidth, size.width - x);
      canvas.drawRRect(
        RRect.fromLTRBR(
          x,
          y,
          x + w,
          y + thickness,
          Radius.circular(thickness / 2),
        ),
        paint,
      );
      x += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant DashedUnderlinePainter old) =>
      old.color != color ||
      old.dashWidth != dashWidth ||
      old.dashGap != dashGap ||
      old.thickness != thickness;
}

// core/widgets/app_duo_word.dart
class DuoWord extends StatefulWidget {
  const DuoWord({
    super.key,
    required this.word,
    required this.revealed,
    this.meanings = const [],
    this.tappable =
        true, // false → câu tiếng Việt: chữ trơn, không gạch, không popup
    this.revealedColor = const Color(0xFF4B4B4B),
    this.pendingColor = const Color(0xFFBDBDBD),
    this.activeColor = const Color(0xFF8A5CF6),
    this.lineColor = const Color(0xFFD5D5D5),
    this.fontSize = 18,
  });

  final String word;
  final bool revealed;
  final List<String> meanings;
  final bool tappable;
  final Color revealedColor, pendingColor, activeColor, lineColor;
  final double fontSize;

  @override
  State<DuoWord> createState() => _DuoWordState();
}

class _DuoWordState extends State<DuoWord> {
  final _ctrl =
      OverlayPortalController(); // OverlayPortalController là đối tượng đồng bộ, không cần dispose
  final Object _tapGroup = Object();
  Rect _targetRect = Rect.zero;

  void _toggle() {
    if (_ctrl.isShowing) return setState(() => _ctrl.hide());
    final box = context.findRenderObject();
    if (box is RenderBox && box.attached) {
      _targetRect = box.localToGlobal(Offset.zero) & box.size;
    }
    setState(() => _ctrl.show());
  }

  @override
  Widget build(BuildContext context) {
    final active = _ctrl.isShowing;

    // IMPLICIT: fade màu chữ 180ms khi [revealed] lật
    final text = AnimatedDefaultTextStyle(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: widget.fontSize,
        color: active
            ? widget.activeColor
            : (widget.revealed ? widget.revealedColor : widget.pendingColor),
      ),
      child: Text(
        widget.word,
      ), // ⚠️ KHÔNG set style ở đây — phải kế thừa style animate
    );

    if (!widget.tappable) return text; // câu tiếng Việt: chữ trơn

    return OverlayPortal(
      controller: _ctrl,
      overlayChildBuilder: (_) => _popup(context),
      child: TapRegion(
        groupId: _tapGroup,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _toggle,
          child: CustomPaint(
            painter: DashedUnderlinePainter(
              color: active ? widget.activeColor : widget.lineColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: text,
            ),
          ),
        ),
      ),
    );
  }

  Widget _popup(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Positioned(
      left: _targetRect.center.dx,
      top: _targetRect.bottom + 12,
      child: FractionalTranslation(
        translation: const Offset(-0.5, 0),
        child: TapRegion(
          groupId: _tapGroup,
          onTapOutside: (_) => setState(() => _ctrl.hide()),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: screen.width - 24),
            child: _MeaningPopup(
              // giữ nguyên class cũ của bạn
              meanings: widget.meanings.isEmpty
                  ? const ['(chưa có dịch)']
                  : widget.meanings,
            ),
          ),
        ),
      ),
    );
  }
}

class _MeaningPopup extends StatelessWidget {
  const _MeaningPopup({required this.meanings});
  final List<String> meanings;

  @override
  Widget build(BuildContext context) {
    return AppSpeechBubble(
      tail: BubbleTail.up,
      borderColor: const Color(0xFFE5E5E5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < meanings.length; i++) ...[
            if (i > 0)
              const Divider(height: 1, thickness: 1, color: Color(0xFFEBEBEB)),
            GestureDetector(
              // KHÔNG dùng InkWell: hết phụ thuộc Material
              onTap: () {
                /* chọn nghĩa */
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Text(
                  meanings[i],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AppDuoSentence extends StatefulWidget {
  const AppDuoSentence({
    super.key,
    required this.text,
    this.meanings = const {},
    this.duration = const Duration(milliseconds: 1300),
    this.revealAll =
        false, // true → câu tĩnh (màn "Chọn bản dịch đúng"), chữ hiện hết ngay
    this.tappable = true,
    this.onSpeak,
    this.onDone,
  });

  final String text;
  final Map<String, List<String>> meanings;
  final Duration duration;
  final bool revealAll;
  final bool tappable;
  final VoidCallback? onSpeak;
  final VoidCallback? onDone;

  @override
  State<AppDuoSentence> createState() => DuoSentenceState();
}

class DuoSentenceState extends State<AppDuoSentence>
    with SingleTickerProviderStateMixin {
  late List<String> _words = widget.text.split(RegExp(r'\s+'));

  // EXPLICIT: đồng hồ 0→1 (Bài 31 roadmap: AnimationController)
  late final AnimationController _ctrl =
      AnimationController(vsync: this, duration: widget.duration)
        ..addStatusListener((s) {
          if (s == AnimationStatus.completed) widget.onDone?.call();
        });

  void play() => _ctrl.forward(from: 0);
  void stop() => _ctrl.reset();

  @override
  void initState() {
    super.initState();

    play();
  }

  @override
  void didUpdateWidget(covariant AppDuoSentence old) {
    super.didUpdateWidget(old);
    // ⚠️ Bẫy "late final": text/duration đổi từ cha thì phải cập nhật tay
    if (old.text != widget.text) {
      _words = widget.text.split(RegExp(r'\s+'));
      _ctrl.reset();
    }
    if (old.duration != widget.duration) _ctrl.duration = widget.duration;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final revealedCount = widget.revealAll
            ? _words.length
            : (_ctrl.value * _words.length).ceil();
        return Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          runSpacing: 18,
          children: [
            if (widget.onSpeak != null)
              IconButton(
                onPressed: widget.onSpeak,
                constraints: const BoxConstraints.tightFor(
                  width: 36,
                  height: 36,
                ),
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(AppIcon.volumeOn, width: 28, height: 28),
              ),
            for (var i = 0; i < _words.length; i++)
              DuoWord(
                word: _words[i],
                revealed: i < revealedCount,
                tappable: widget.tappable,
                meanings: widget.meanings[_words[i].toLowerCase()] ?? const [],
              ),
          ],
        );
      },
    );
  }
}
