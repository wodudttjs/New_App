class Sermon {
  const Sermon({
    required this.id,
    required this.title,
    required this.speaker,
    required this.date,
    required this.summary,
  });

  final String id;
  final String title;
  final String speaker;
  final String date;
  final String summary;

  factory Sermon.fromJson(Map<String, dynamic> json) {
    return Sermon(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      speaker: json['speaker'] as String? ?? '',
      date: json['date'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
    );
  }
}
