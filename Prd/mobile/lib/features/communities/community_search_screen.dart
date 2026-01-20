import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'communities_provider.dart';

class CommunitySearchScreen extends ConsumerWidget {
  const CommunitySearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final communities = ref.watch(communitiesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('커뮤니티 찾기')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '지역 또는 키워드 검색',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: communities.when(
              data: (items) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => ListTile(
                  title: Text(items[index].name),
                  subtitle: Text(items[index].address),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/communities/${items[index].id}'),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: items.length,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('커뮤니티 목록을 불러오지 못했습니다.')),
            ),
          ),
        ],
      ),
    );
  }
}
