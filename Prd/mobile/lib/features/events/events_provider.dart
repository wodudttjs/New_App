import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/event.dart';
import '../../core/providers/api_client_provider.dart';
import '../../core/providers/local_storage_provider.dart';

final eventsProvider = FutureProvider<List<EventItem>>((ref) async {
  final api = ref.read(apiClientProvider);
  final storage = ref.read(localStorageProvider);
  try {
    final res = await api.get<Map<String, dynamic>>('/events', query: {'limit': 20});
    final items = (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(EventItem.fromJson)
        .toList();
    await storage.setCachedList('events', (res.data?['items'] as List<dynamic>? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList());
    return items;
  } catch (_) {
    final cached = storage.getCachedList('events');
    return cached.map(EventItem.fromJson).toList();
  }
});
