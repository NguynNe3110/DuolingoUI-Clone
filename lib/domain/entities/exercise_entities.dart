enum ExerciseType { translate, pickTranslation, pickImage }

class Exercise {
  final ExerciseType type;
  final String prompt;               // câu hỏi / từ cần nghe
  final List<String> options;        // pick*: đáp án | translate: bank từ
  final String correct;              // pick*: option đúng | translate: chuỗi ghép đúng
  final Map<String, List<String>> meanings;
  final bool isNewWord;
  final String characterAsset;       // TODO: svg nhân vật của bạn
  final List<String>? imageAssets;   // pickImage: svg theo option

  const Exercise({
    required this.type,
    required this.prompt,
    required this.options,
    required this.correct,
    this.meanings = const {},
    this.isNewWord = false,
    this.characterAsset = '',
    this.imageAssets,
  });

  static const List<Exercise> mock = [
    Exercise(
      type: ExerciseType.pickImage,
      prompt: 'tea', isNewWord: true,
      options: ['đường', 'sữa', 'trà', 'cà phê'],
      correct: 'trà',
      imageAssets: ['sugar.svg', 'milk.svg', 'tea.svg', 'coffee.svg'],
      meanings: {'tea': ['trà']},
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'trà', options: ['please', 'tea', 'coffee'], correct: 'tea',
      characterAsset: 'zari.svg',
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'welcome', isNewWord: true,
      options: ['chào', 'cảm ơn', 'mừng'], correct: 'chào mừng',
      characterAsset: 'easy.svg',
      meanings: {'welcome': ['chào mừng']},
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'cà phê', options: ['coffee', 'tea', 'welcome'], correct: 'coffee',
      characterAsset: 'zari.svg',
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'Coffee or tea?',
      options: ['Cà', 'hay', 'phê', 'trà', 'tôi'], correct: 'Cà phê hay trà',
      characterAsset: 'oscar.svg',
      meanings: {'coffee': ['cà phê'], 'or': ['hay'], 'tea': ['trà']},
    ),
    Exercise(
      type: ExerciseType.pickTranslation,
      prompt: 'chào mừng', options: ['welcome', 'tea', 'please'], correct: 'welcome',
      characterAsset: 'lin.svg',
    ),
    Exercise(
      type: ExerciseType.translate,
      prompt: 'Tea or coffee?',
      options: ['cà', 'cảm ơn', 'hay', 'phê', 'Trà'], correct: 'Trà hay cà phê',
      characterAsset: 'easy.svg',
      meanings: {'tea': ['trà'], 'or': ['hay'], 'coffee': ['cà phê']},
    ),
  ];
}