enum ExerciseType { translate, pickTranslation, pickImage, match }

class Pair {
  final String left;
  final String right;

  const Pair({required this.left, required this.right});
}

class Exercise {
  final ExerciseType type;
  final String prompt;
  final List<String> options;
  final String correct;
  final Map<String, List<String>> meanings;
  final bool isNewWord;
  final String characterAsset;
  final List<String>? imageAssets;
  final List<Pair> pairs;

  const Exercise({
    required this.type,
    required this.prompt,
    required this.options,
    required this.correct,
    this.meanings = const {},
    this.isNewWord = false,
    this.characterAsset = '',
    this.imageAssets,
    this.pairs = const [],
  });
}