import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'community_detail_provider.dart';

class CommunityDetailScreen extends ConsumerWidget {
  const CommunityDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(communityDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('커뮤니티 상세')),
      body: detail.when(
        data: (item) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 6),
              Text(item.address),
              const SizedBox(height: 12),
              Text('전화: ${item.phone}'),
              const SizedBox(height: 4),
              Text('이메일: ${item.email}'),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('커뮤니티 상세를 불러오지 못했습니다.')),
      ),
    );
  }
}
