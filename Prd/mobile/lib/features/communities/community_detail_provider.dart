import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/community_detail.dart';
import '../../core/providers/api_client_provider.dart';

final communityDetailProvider = FutureProvider.family<CommunityDetail, String>((ref, id) async {
  final api = ref.read(apiClientProvider);
  final res = await api.get<Map<String, dynamic>>('/communities/$id');
  return CommunityDetail.fromJson(res.data ?? {});
});
