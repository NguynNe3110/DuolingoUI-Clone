abstract class LessonEvent {
  const LessonEvent();
}

class ExerciseFinished extends LessonEvent {
  final bool isCorrect;
  const ExerciseFinished({required this.isCorrect});
}
