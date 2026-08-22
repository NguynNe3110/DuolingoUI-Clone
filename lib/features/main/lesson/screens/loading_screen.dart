import 'dart:async';
import 'dart:math';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoadingScreen extends StatefulWidget {
  final String nextPath;

  const LoadingScreen({super.key, this.nextPath = '/lesson-result'});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const String _funFacts =
      'Ngay lúc này, có hơn 2 triệu người đang nắm giữ chuỗi streak nhiều hơn 365 ngày!';

  static const TextStyle _loadingTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.1,
    color: AppColors.textGrayOnBackground,
  );

  int _dotCount = 1;
  Timer? _dotTimer;
  Timer? _nextTimer;

  @override
  void initState() {
    super.initState();
    // Cứ 400ms: . -> .. -> ... -> .  (luyện Bài 3-4: setState)
    _dotTimer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      setState(() {
        _dotCount = _dotCount % 3 + 1; // 1, 2, 3 rồi quay về 1
      });
    });

    final delayMs = 1000 + Random().nextInt(1001);
    _nextTimer = Timer(Duration(milliseconds: delayMs), () {
      if (!mounted) return;
      context.go(widget.nextPath);
    });
  }

  @override
  void dispose() {
    _dotTimer?.cancel();
    _nextTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(),
              const SizedBox(height: 16),

              Image.asset(AppIcon.imageDuoWait, width: 200),
              const SizedBox(height: 32),

              // ── "ĐANG TẢI" + dấu chấm động ─────────────────
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('ĐANG TẢI', style: _loadingTextStyle),
                  SizedBox(
                    width: 26, // giữ chỗ cố định để chữ KHÔNG bị nhảy
                    child: Text('.' * _dotCount, style: _loadingTextStyle),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text(
                _funFacts,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textGrayOnBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
