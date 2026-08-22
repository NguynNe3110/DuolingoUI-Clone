import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_answer_card.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/exercise_entities.dart';

class _Flight {
  final int tokenId;
  final String text;
  final Rect from;
  final Rect to;
  final AnimationController controller;
  _Flight({required this.tokenId, required this.text,
    required this.from, required this.to, required this.controller});
}

class TranslateBody extends StatefulWidget {
  final Exercise exercise;
  final bool? checkedCorrect;
  final ValueChanged<List<String>> onAnswerChanged;

  const TranslateBody({
    super.key,
    required this.exercise,
    required this.checkedCorrect,
    required this.onAnswerChanged,
  });

  @override
  State<TranslateBody> createState() => _TranslateBodyState();
}

class _TranslateBodyState extends State<TranslateBody>
    with TickerProviderStateMixin {
  final List<int> _selected = [];
  final Set<int> _inFlight = {};
  final List<_Flight> _flights = [];

  final GlobalKey _stackKey = GlobalKey();
  final Map<int, GlobalKey> _bankKeys = {};
  final Map<int, GlobalKey> _answerKeys = {};

  static const _chipText = TextStyle(fontSize: 17, fontWeight: FontWeight.w600);
  static const _chipPadding = EdgeInsets.symmetric(   // ← MỚI
    horizontal: AppSpacing.S16,
    vertical: AppSpacing.S12,
  );

  bool get _locked => widget.checkedCorrect != null;

  GlobalKey _bankKey(int id) => _bankKeys.putIfAbsent(id, () => GlobalKey());
  GlobalKey _answerKey(int id) => _answerKeys.putIfAbsent(id, () => GlobalKey());

  @override
  void dispose() {
    for (final f in _flights) f.controller.dispose();
    super.dispose();
  }

  Rect? _localRect(GlobalKey key) {
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final stack = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || stack == null || !box.attached) return null;
    return stack.globalToLocal(box.localToGlobal(Offset.zero)) & box.size;
  }

  void _emit() =>
      widget.onAnswerChanged(_selected.map((i) => widget.exercise.options[i]).toList());

  void _tapBank(int id) {
    if (_locked || _selected.contains(id) || _inFlight.contains(id)) return;
    final from = _localRect(_bankKey(id));
    setState(() { _selected.add(id); _inFlight.add(id); });
    _emit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launch(id, from, _localRect(_answerKey(id)));
    });
  }

  void _tapAnswer(int id) {
    if (_locked || !_selected.contains(id) || _inFlight.contains(id)) return;
    final from = _localRect(_answerKey(id));
    setState(() { _selected.remove(id); _inFlight.add(id); });
    _emit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launch(id, from, _localRect(_bankKey(id))); // đích = placeholder xám
    });
  }

  void _launch(int id, Rect? from, Rect? to) {
    if (!mounted) return;
    if (from == null || to == null) {
      setState(() => _inFlight.remove(id));
      return;
    }
    final controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 220));
    controller.addListener(() => setState(() {}));
    controller.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        setState(() {
          _flights.removeWhere((f) => f.tokenId == id);
          _inFlight.remove(id);
        });
        controller.dispose();
      }
    });
    setState(() => _flights.add(_Flight(
        tokenId: id, text: widget.exercise.options[id],
        from: from, to: to, controller: controller)));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: _stackKey,
      children: [
        Column(children: [ _answerArea(), const Spacer(), _bank() ]),
        for (final f in _flights)
          Positioned(
            left: f.from.left + (f.to.left - f.from.left) *
                Curves.easeOut.transform(f.controller.value),
            top: f.from.top + (f.to.top - f.from.top) *
                Curves.easeOut.transform(f.controller.value),

            width: f.from.width,
            height: f.from.height,
            child: IgnorePointer(
              child: AppAnswerCard(
                status: AnswerCardStatus.idle,

                padding: _chipPadding,
                child: Text(f.text, style: _chipText),
              ),
            ),
          ),
      ],
    );
  }

  Widget _answerArea() {
    final status = widget.checkedCorrect == null
        ? AnswerCardStatus.idle
        : (widget.checkedCorrect!
        ? AnswerCardStatus.correct   // → jelly bounce tự phát trong card
        : AnswerCardStatus.wrong);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      constraints: const BoxConstraints(minHeight: 120),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.grayBorder200, width: 2)),
      ),
      child: Wrap(
        spacing: 8, runSpacing: 8,
        children: [
          for (final id in _selected)
            Opacity(
              opacity: _inFlight.contains(id) ? 0 : 1, // INVISIBLE giữ chỗ đo tọa độ
              child: AppAnswerCard(
                key: _answerKey(id),
                status: status,
                padding: _chipPadding,
                onPressed: () => _tapAnswer(id),
                child: Text(widget.exercise.options[id], style: _chipText),
              ),
            ),
        ],
      ),
    );
  }

  Widget _bank() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        spacing: 10, runSpacing: 12,
        alignment: WrapAlignment.center,
        children: [
          for (var id = 0; id < widget.exercise.options.length; id++)
            if (_selected.contains(id) || _inFlight.contains(id))
              _placeholder(id)
            else
              AppAnswerCard(
                key: _bankKey(id),
                padding: _chipPadding,
                status: AnswerCardStatus.idle,
                onPressed: () => _tapBank(id),
                child: Text(widget.exercise.options[id], style: _chipText),
              ),
        ],
      ),
    );
  }

  /// Khối xám giữ chỗ — geometry KHỚP TUYỆT ĐỐI với AppAnswerCard:
  /// cùng padding S16 + border b2 + radius r14 (chỉ khác màu, text trong suốt)
  Widget _placeholder(int id) {
    return Container(
      key: _bankKey(id),
      padding: _chipPadding,
      decoration: BoxDecoration(
        color: AppColors.graySurface200,
        borderRadius: BorderRadius.circular(AppRadius.r14),
        border: Border.all(color: Colors.transparent, width: AppBorder.b2),
      ),
      child: Text(widget.exercise.options[id],
          style: _chipText.copyWith(color: Colors.transparent)),
    );
  }
}