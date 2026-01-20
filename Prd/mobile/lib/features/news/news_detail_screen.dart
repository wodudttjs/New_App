import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'news_detail_provider.dart';
import '../../core/utils/launch_url.dart';

class NewsDetailScreen extends ConsumerWidget {
  const NewsDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(newsDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('소식 상세')),
      body: detail.when(
        data: (item) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(item.summary),
              const SizedBox(height: 12),
              Text(item.bodyHtml),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: item.sourceUrl.isEmpty ? null : () => launchExternalUrl(item.sourceUrl),
                child: const Text('원문 보기'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('소식 상세를 불러오지 못했습니다.')),
      ),
    );
  }
}
