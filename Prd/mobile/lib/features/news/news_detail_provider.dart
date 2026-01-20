import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/news_detail.dart';
import '../../core/providers/api_client_provider.dart';

final newsDetailProvider = FutureProvider.family<NewsDetail, String>((ref, id) async {
  final api = ref.read(apiClientProvider);
  final res = await api.get<Map<String, dynamic>>('/news/$id');
  return NewsDetail.fromJson(res.data ?? {});
});
