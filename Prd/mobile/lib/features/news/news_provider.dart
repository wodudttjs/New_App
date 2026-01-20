import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/news_item.dart';
import '../../core/providers/api_client_provider.dart';
import '../../core/providers/local_storage_provider.dart';

final newsProvider = FutureProvider.family<List<NewsItem>, Map<String, String>>((ref, params) async {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(localStorageProvider);
  final query = <String, dynamic>{'limit': 20};
  if (params['query'] != null && params['query']!.isNotEmpty) {
    query['query'] = params['query'];
  }
  if (params['category'] != null && params['category']!.isNotEmpty) {
    query['category'] = params['category'];
  }
  try {
    final res = await api.get<Map<String, dynamic>>('/news', query: query);
    final items = (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(NewsItem.fromJson)
        .toList();
    await storage.setCachedList('news', (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList());
    return items;
  } catch (_) {
    final cached = storage.getCachedList('news');
    return cached.map(NewsItem.fromJson).toList();
  }
});
