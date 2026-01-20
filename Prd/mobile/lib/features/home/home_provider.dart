import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/home_feed.dart';
import '../../core/providers/api_client_provider.dart';

final homeFeedProvider = FutureProvider<HomeFeed>((ref) async {
  final api = ref.read(apiClientProvider);
  final res = await api.get<Map<String, dynamic>>('/home-feed');
  return HomeFeed.fromJson(res.data ?? {});
});
