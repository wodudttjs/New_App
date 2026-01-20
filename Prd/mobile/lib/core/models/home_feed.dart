import 'sermon.dart';
import 'news_item.dart';

class HomeFeed {
  const HomeFeed({
    required this.heroQuote,
    required this.heroSubtitle,
    required this.latestSermons,
    required this.latestNews,
  });

  final String heroQuote;
  final String heroSubtitle;
  final List<Sermon> latestSermons;
  final List<NewsItem> latestNews;

  factory HomeFeed.fromJson(Map<String, dynamic> json) {
    final hero = json['hero'] as Map<String, dynamic>? ?? const {};
    final sermons = (json['latestSermons'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(Sermon.fromJson)
        .toList();
    final news = (json['latestNews'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(NewsItem.fromJson)
        .toList();

    return HomeFeed(
      heroQuote: hero['quote'] as String? ?? '',
      heroSubtitle: hero['subtitle'] as String? ?? '',
      latestSermons: sermons,
      latestNews: news,
    );
  }
}
