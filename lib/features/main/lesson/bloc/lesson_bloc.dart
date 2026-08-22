import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  // Stream that fires true when the lesson is fully completed.
  final _finishController = StreamController<void>.broadcast();
  Stream<void> get onFinished => _finishController.stream;

  LessonBloc() : super(const LessonState.initial()) {
    on<ExerciseFinished>(_onExerciseFinished);
  }

  void _onExerciseFinished(ExerciseFinished event, Emitter<LessonState> emit) {
    final next = state.copyWith(
      currentIndex: state.currentIndex + 1,
      combo: event.isCorrect ? state.combo + 1 : 0,
      // energy decreases only on a wrong answer
      energy: event.isCorrect ? state.energy : state.energy - 1,
    );
    emit(next);

    if (next.isFinished) {
      _finishController.add(null);
    }
  }

  @override
  Future<void> close() {
    _finishController.close();
    return super.close();
  }
}
