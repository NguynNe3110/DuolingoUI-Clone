import '../../domain/entities/exercise_entities.dart';
import '../../core/theme/app_icon.dart';

class MockExercises {
  static const List<Exercise> lesson1 = [
    Exercise(
      type: ExerciseType.pickImage,
      prompt: 'tea',
      isNewWord: true,
      options: ['đường', 'sữa', 'trà', 'cà phê'],
      correct: 'trà',
      imageAssets: [
        AppIcon.lessonSuggar,
        AppIcon.lessonMilk,
        AppIcon.lessonTea,
        AppIcon.lessonCafe,
      ],
      meanings: {
        'tea': ['trà'],
      },
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'trà',
      options: ['please', 'tea', 'coffee'],
      correct: 'tea',
      characterAsset: AppIcon.charOlderSister,
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'welcome',
      isNewWord: true,
      options: ['chào', 'cảm ơn', 'mừng'],
      correct: 'chào mừng',
      characterAsset: AppIcon.charDuoHi,
      meanings: {
        'welcome': ['chào mừng'],
      },
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'cà phê',
      options: ['coffee', 'tea', 'welcome'],
      correct: 'coffee',
      characterAsset: AppIcon.charOlderSister,
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'Coffee or tea?',
      options: ['Cà', 'hay', 'phê', 'trà', 'tôi'],
      correct: 'Cà phê hay trà',
      characterAsset: AppIcon.charUncle,
      meanings: {
        'coffee': ['cà phê'],
        'or': ['hay'],
        'tea': ['trà'],
      },
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'chào mừng',
      options: ['welcome', 'tea', 'please'],
      correct: 'welcome',
      characterAsset: AppIcon.charAunt,
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'Tea or coffee?',
      options: ['cà', 'cảm ơn', 'hay', 'phê', 'Trà'],
      correct: 'Trà hay cà phê',
      characterAsset: AppIcon.charDuoHi,
      meanings: {
        'tea': ['trà'],
        'or': ['hay'],
        'coffee': ['cà phê'],
      },
    ),
    Exercise(
      type: ExerciseType.match,
      prompt: 'Ghép từ đúng nghĩa',
      options: [],
      correct: '',
      pairs: [
        Pair(left: 'tea', right: 'trà'),
        Pair(left: 'coffee', right: 'cà phê'),
        Pair(left: 'welcome', right: 'chào mừng'),
      ],
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'xin chào',
      options: ['hello', 'goodbye', 'tea'],
      correct: 'hello',
      characterAsset: AppIcon.charNeighbor,
    ),
    Exercise(
      type: ExerciseType.pickImage,
      prompt: 'coffee',
      options: ['trà', 'đường', 'cà phê', 'sữa'],
      correct: 'cà phê',
      imageAssets: [
        AppIcon.lessonTea,
        AppIcon.lessonSuggar,
        AppIcon.lessonCafe,
        AppIcon.lessonMilk,
      ],
      meanings: {
        'coffee': ['cà phê'],
      },
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'Please welcome me',
      options: ['xin', 'mừng', 'chào', 'tôi'],
      correct: 'xin chào mừng tôi',
      characterAsset: AppIcon.charBrother,
      meanings: {
        'please': ['xin'],
        'welcome': ['chào mừng'],
        'me': ['tôi'],
      },
    ),
    Exercise(
      type: ExerciseType.match,
      prompt: 'Ghép cụm từ',
      options: [],
      correct: '',
      pairs: [
        Pair(left: 'good morning', right: 'chào buổi sáng'),
        Pair(left: 'thank you', right: 'cảm ơn'),
        Pair(left: 'good night', right: 'chúc ngủ ngon'),
      ],
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'cảm ơn',
      options: ['thanks', 'coffee', 'tea'],
      correct: 'thanks',
      characterAsset: AppIcon.charGrandMa,
    ),
  ];

  static const List<Exercise> defaultLesson = lesson1;
}
