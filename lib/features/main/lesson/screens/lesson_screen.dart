import 'dart:async';

import 'package:duolingo_ui_clone/core/exports/app_export_theme.dart';
import 'package:duolingo_ui_clone/core/widgets/app_progress_linear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../bloc/lesson_bloc.dart';
import '../bloc/lesson_event.dart';
import '../bloc/lesson_state.dart';
import '../widgets/exercise_page.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => LessonBloc(), child: _LessonView());
  }
}

class _LessonView extends StatefulWidget {
  const _LessonView({super.key});

  @override
  State<_LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<_LessonView> {
  final _pageController = PageController();
  StreamSubscription<void>? _finishSubscription;

  @override
  void initState() {
    super.initState();
    _finishSubscription = context.read<LessonBloc>().onFinished.listen((_) {
      _navigateToFinish();
    });
  }

  void _navigateToFinish() {
    if (!mounted) return;
    final bloc = context.read<LessonBloc>();
    final state = bloc.state;
    context.go(
      '/lesson-result',
      extra: {
        'totalExercises': state.exercises.length,
        'correctCount': state.correctCount,
        'energy': state.energy,
      },
    );
  }

  void _onExerciseDone(bool isCorrect) {
    final bloc = context.read<LessonBloc>();
    bloc.add(ExerciseFinished(isCorrect: isCorrect));

    if (!bloc.state.isFinished) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _finishSubscription?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = context.read<LessonBloc>().state.exercises;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: exercises.length,
                itemBuilder: (_, i) => ExercisePage(
                  exercise: exercises[i],
                  onDone: _onExerciseDone,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<LessonBloc, LessonState>(
      buildWhen: (p, c) =>
          p.progress != c.progress ||
          p.combo != c.combo ||
          p.energy != c.energy,
      builder: (context, state) {
        final variant = state.combo >= 6
            ? ProgressVariant.chainSeven
            : state.combo >= 3
            ? ProgressVariant.chainThree
            : ProgressVariant.basic;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.S16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 32,
                  color: AppColors.grayBorder300,
                ),
                onPressed: () {
                  context.go('/home');
                },
              ),
              const SizedBox(width: AppSpacing.S16),
              Expanded(
                child: AppProgressLinear(
                  progress: state.progress,
                  label: state.combo >= 2 ? 'COMBO x${state.combo}' : null,
                  progressBarState: variant,
                ),
              ),
              const SizedBox(width: AppSpacing.S16),
              SvgPicture.asset(
                AppIcon.battery,
                width: 24,
              ),
              const SizedBox(width: 4),
              Text(
                '${state.energy}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.duoPink,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
