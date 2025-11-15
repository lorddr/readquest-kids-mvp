class Story {
  final String id;
  final String level;
  final String title;
  final String badge;
  final String emoji;
  final String textDisplay;
  final String textAsr;
  final String illustrationSmall;
  final String illustrationLarge;
  final int words;

  Story({
    required this.id,
    required this.level,
    required this.title,
    required this.badge,
    required this.emoji,
    required this.textDisplay,
    required this.textAsr,
    required this.illustrationSmall,
    required this.illustrationLarge,
    required this.words,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'],
      level: json['level'],
      title: json['title'],
      badge: json['badge'],
      emoji: json['emoji'],
      textDisplay: json['text_display'],
      textAsr: json['text_asr'],
      illustrationSmall: json['illustration_small'],
      illustrationLarge: json['illustration_large'],
      words: json['words'],
    );
  }
}