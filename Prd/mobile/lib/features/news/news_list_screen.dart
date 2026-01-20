import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'news_provider.dart';
import '../../core/providers/search_params_provider.dart';

class NewsListScreen extends ConsumerWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(newsQueryProvider);
    final category = ref.watch(newsCategoryProvider);
    final news = ref.watch(newsProvider({'query': query, 'category': category}));
    return Scaffold(
      appBar: AppBar(title: const Text('소식')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: '제목/요약 검색',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.search),
              ),
              onSubmitted: (value) => ref.read(newsQueryProvider.notifier).state = value,
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: '전체',
                  selected: category.isEmpty,
                  onSelected: () => ref.read(newsCategoryProvider.notifier).state = '',
                ),
                _FilterChip(
                  label: 'notice',
                  selected: category == 'notice',
                  onSelected: () => ref.read(newsCategoryProvider.notifier).state = 'notice',
                ),
                _FilterChip(
                  label: 'news',
                  selected: category == 'news',
                  onSelected: () => ref.read(newsCategoryProvider.notifier).state = 'news',
                ),
                _FilterChip(
                  label: 'column',
                  selected: category == 'column',
                  onSelected: () => ref.read(newsCategoryProvider.notifier).state = 'column',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: news.when(
              data: (items) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => ListTile(
                  title: Text(items[index].title),
                  subtitle: Text(items[index].summary),
                  onTap: () => context.go('/news/${items[index].id}'),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: items.length,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('소식 목록을 불러오지 못했습니다.')),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onSelected});

  final String label;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onSelected(),
      ),
    );
  }
}
