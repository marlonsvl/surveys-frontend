class Question {
  final String id;
  final String text;
  final int minValue;
  final int maxValue;
  final List<String> labels; // Changed to list of labels for all values
  
  const Question({
    required this.id,
    required this.text,
    required this.minValue,
    required this.maxValue,
    required this.labels, // Now required
  });
}