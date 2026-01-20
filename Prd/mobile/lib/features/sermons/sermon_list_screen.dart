import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'sermons_provider.dart';
import '../../core/providers/bookmark_provider.dart';
import '../../core/providers/search_params_provider.dart';

class SermonListScreen extends ConsumerWidget {
  const SermonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(sermonQueryProvider);
    final category = ref.watch(sermonCategoryProvider);
    final year = ref.watch(sermonYearProvider);
    final sermons = ref.watch(sermonsProvider({'query': query, 'category': category, 'year': year}));
    final bookmarks = ref.watch(bookmarksProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('설교')),
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
              onSubmitted: (value) => ref.read(sermonQueryProvider.notifier).state = value,
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
                  onSelected: () => ref.read(sermonCategoryProvider.notifier).state = '',
                ),
                _FilterChip(
                  label: 'faith',
                  selected: category == 'faith',
                  onSelected: () => ref.read(sermonCategoryProvider.notifier).state = 'faith',
                ),
                _FilterChip(
                  label: 'peace',
                  selected: category == 'peace',
                  onSelected: () => ref.read(sermonCategoryProvider.notifier).state = 'peace',
                ),
                const SizedBox(width: 12),
                _FilterChip(
                  label: '2026',
                  selected: year == '2026',
                  onSelected: () => ref.read(sermonYearProvider.notifier).state = '2026',
                ),
                _FilterChip(
                  label: '2025',
                  selected: year == '2025',
                  onSelected: () => ref.read(sermonYearProvider.notifier).state = '2025',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: sermons.when(
              data: (items) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => ListTile(
                  title: Text(items[index].title),
                  subtitle: Text('${items[index].speaker} · ${items[index].date}'),
                  leading: Icon(bookmarks.contains(items[index].id) ? Icons.bookmark : Icons.bookmark_border),
                  trailing: const Icon(Icons.play_circle_outline),
                  onTap: () => context.go('/sermons/${items[index].id}'),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: items.length,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('설교 목록을 불러오지 못했습니다.')),
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
