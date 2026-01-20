class Publication {
  const Publication({
    required this.id,
    required this.title,
    required this.issue,
  });

  final String id;
  final String title;
  final String issue;

  factory Publication.fromJson(Map<String, dynamic> json) {
    return Publication(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      issue: json['issue'] as String? ?? '',
    );
  }
}
