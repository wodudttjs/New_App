class PublicationDetail {
  const PublicationDetail({
    required this.id,
    required this.title,
    required this.issue,
    required this.pdfUrl,
  });

  final String id;
  final String title;
  final String issue;
  final String pdfUrl;

  factory PublicationDetail.fromJson(Map<String, dynamic> json) {
    return PublicationDetail(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      issue: json['issue'] as String? ?? '',
      pdfUrl: json['pdfUrl'] as String? ?? '',
    );
  }
}
