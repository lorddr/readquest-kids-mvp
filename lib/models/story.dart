class Story {
  final String id;
  final String level;
  final String title;
  final String badge;
  final String emoji;
  final String textDisplay;
  final String textAsr;
  final String illustrationUrl;
  final int words;

  Story({
    required this.id,
    required this.level,
    required this.title,
    required this.badge,
    required this.emoji,
    required this.textDisplay,
    required this.textAsr,
    required this.illustrationUrl,
    required this.words,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['id'] as String,
      level: json['level'] as String,
      title: json['title'] as String,
      badge: json['badge'] as String,
      emoji: json['emoji'] as String,
      textDisplay: json['text_display'] as String,
      textAsr: json['text_asr'] as String,
      illustrationUrl: json['illustration_url'] as String,
      words: json['words'] as int,
    );
  }
}