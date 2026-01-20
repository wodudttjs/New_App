import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider(query));

    return Scaffold(
      appBar: AppBar(title: const Text('검색')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '제목/요약 검색',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => ref.read(searchQueryProvider.notifier).state = controller.text,
                ),
              ),
              onSubmitted: (value) => ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: results.when(
              data: (items) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (_, index) => ListTile(
                  title: Text(items[index].title),
                  subtitle: Text('${items[index].type} · ${items[index].summary}'),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: items.length,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const Center(child: Text('검색 결과를 불러오지 못했습니다.')),
            ),
          ),
        ],
      ),
    );
  }
}
