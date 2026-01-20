import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/sermon_detail.dart';
import '../../core/providers/api_client_provider.dart';

final sermonDetailProvider = FutureProvider.family<SermonDetail, String>((ref, id) async {
  final api = ref.read(apiClientProvider);
  final res = await api.get<Map<String, dynamic>>('/sermons/$id');
  return SermonDetail.fromJson(res.data ?? {});
});
