import '../../../../domain/entities/exercise_entities.dart';

class LessonState {
  final List<Exercise> exercises;
  final int currentIndex;
  final int combo;
  final int energy;

  const LessonState({
    required this.exercises,
    required this.currentIndex,
    required this.combo,
    required this.energy,
  });

  const LessonState.initial()
      : this(exercises: Exercise.mock, currentIndex: 0, combo: 0, energy: 5);

  double get progress =>
      exercises.isEmpty ? 1 : currentIndex / exercises.length;
  bool get isFinished => currentIndex >= exercises.length;

  LessonState copyWith({int? currentIndex, int? combo, int? energy}) =>
      LessonState(
        exercises: exercises,
        currentIndex: currentIndex ?? this.currentIndex,
        combo: combo ?? this.combo,
        energy: energy ?? this.energy,
      );
}