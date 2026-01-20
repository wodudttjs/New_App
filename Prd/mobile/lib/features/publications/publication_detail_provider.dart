import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/models/publication_detail.dart';
import '../../core/providers/api_client_provider.dart';

final publicationDetailProvider = FutureProvider.family<PublicationDetail, String>((ref, id) async {
  final api = ref.read(apiClientProvider);
  final res = await api.get<Map<String, dynamic>>('/publications/$id');
  return PublicationDetail.fromJson(res.data ?? {});
});
