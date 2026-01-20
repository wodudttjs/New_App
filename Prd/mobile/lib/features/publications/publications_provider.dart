import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/publication.dart';
import '../../core/providers/api_client_provider.dart';
import '../../core/providers/local_storage_provider.dart';

final publicationsProvider = FutureProvider<List<Publication>>((ref) async {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(localStorageProvider);
  try {
    final res = await api.get<Map<String, dynamic>>('/publications', query: {'limit': 20});
    final items = (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(Publication.fromJson)
        .toList();
    await storage.setCachedList('publications', (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList());
    return items;
  } catch (_) {
    final cached = storage.getCachedList('publications');
    return cached.map(Publication.fromJson).toList();
  }
});
