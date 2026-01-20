class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.category,
  });

  final String id;
  final String title;
  final String summary;
  final String category;

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }
}
