import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/community.dart';
import '../../core/providers/api_client_provider.dart';
import '../../core/providers/local_storage_provider.dart';

final communitiesProvider = FutureProvider<List<Community>>((ref) async {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(localStorageProvider);
  try {
    final res = await api.get<Map<String, dynamic>>('/communities', query: {'limit': 20});
    final items = (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(Community.fromJson)
        .toList();
    await storage.setCachedList('communities', (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList());
    return items;
  } catch (_) {
    final cached = storage.getCachedList('communities');
    return cached.map(Community.fromJson).toList();
  }
});
