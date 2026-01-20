import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'publications_provider.dart';

class PublicationsListScreen extends ConsumerWidget {
  const PublicationsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publications = ref.watch(publicationsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('출판물')),
      body: publications.when(
        data: (items) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => ListTile(
            title: Text(items[index].title),
            subtitle: Text(items[index].issue),
            trailing: const Icon(Icons.picture_as_pdf),
            onTap: () => context.go('/publications/${items[index].id}'),
          ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: items.length,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('출판물 목록을 불러오지 못했습니다.')),
      ),
    );
  }
}
