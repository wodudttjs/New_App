import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/search_item.dart';
import '../../core/providers/api_client_provider.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider.autoDispose.family<List<SearchItem>, String>((ref, query) async {
  if (query.trim().isEmpty) return [];
  final api = ref.read(apiClientProvider);
  final res = await api.get<Map<String, dynamic>>('/search', query: {'q': query});
  final items = (res.data?['items'] as List<dynamic>? ?? [])
      .whereType<Map<String, dynamic>>()
      .map(SearchItem.fromJson)
      .toList();
  return items;
});
