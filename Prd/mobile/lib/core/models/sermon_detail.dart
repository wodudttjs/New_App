class SermonDetail {
  const SermonDetail({
    required this.id,
    required this.title,
    required this.speaker,
    required this.summary,
    required this.transcript,
    required this.videoUrl,
    required this.audioUrl,
  });

  final String id;
  final String title;
  final String speaker;
  final String summary;
  final String transcript;
  final String videoUrl;
  final String audioUrl;

  factory SermonDetail.fromJson(Map<String, dynamic> json) {
    return SermonDetail(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      speaker: json['speaker'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      transcript: json['transcript'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
      audioUrl: json['audioUrl'] as String? ?? '',
    );
  }
}
