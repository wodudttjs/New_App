import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/sermon.dart';
import '../../core/providers/api_client_provider.dart';
import '../../core/providers/local_storage_provider.dart';

final sermonsProvider = FutureProvider.family<List<Sermon>, Map<String, String>>((ref, params) async {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(localStorageProvider);
  final query = <String, dynamic>{'limit': 20};
  if (params['query'] != null && params['query']!.isNotEmpty) {
    query['query'] = params['query'];
  }
  if (params['category'] != null && params['category']!.isNotEmpty) {
    query['category'] = params['category'];
  }
  if (params['year'] != null && params['year']!.isNotEmpty) {
    query['year'] = params['year'];
  }

  try {
    final res = await api.get<Map<String, dynamic>>('/sermons', query: query);
    final items = (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(Sermon.fromJson)
        .toList();
    await storage.setCachedList('sermons', (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList());
    return items;
  } catch (_) {
    final cached = storage.getCachedList('sermons');
    return cached.map(Sermon.fromJson).toList();
  }
});
