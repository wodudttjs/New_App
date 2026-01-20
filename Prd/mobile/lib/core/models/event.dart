class EventItem {
  const EventItem({
    required this.id,
    required this.title,
    required this.summary,
    required this.startAt,
    required this.locationName,
  });

  final String id;
  final String title;
  final String summary;
  final String startAt;
  final String locationName;

  factory EventItem.fromJson(Map<String, dynamic> json) {
    return EventItem(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      summary: json['summary'] as String? ?? '',
      startAt: json['startAt'] as String? ?? '',
      locationName: json['locationName'] as String? ?? '',
    );
  }
}
