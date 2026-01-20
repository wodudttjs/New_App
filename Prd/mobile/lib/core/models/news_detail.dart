class NewsDetail {
  const NewsDetail({
    required this.id,
    required this.title,
    required this.summary,
    required this.bodyHtml,
    required this.sourceUrl,
  });

  final String id;
  final String title;
  final String summary;
  final String bodyHtml;
  final String sourceUrl;

  factory NewsDetail.fromJson(Map<String, dynamic> json) {
    return NewsDetail(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      bodyHtml: json['bodyHtml'] as String? ?? '',
      sourceUrl: json['sourceUrl'] as String? ?? '',
    );
  }
}
