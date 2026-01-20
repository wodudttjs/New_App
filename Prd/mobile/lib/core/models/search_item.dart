class SearchItem {
  const SearchItem({
    required this.type,
    required this.id,
    required this.title,
    required this.summary,
  });

  final String type;
  final String id;
  final String title;
  final String summary;

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    return SearchItem(
      type: json['type'] as String? ?? '',
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
    );
  }
}
