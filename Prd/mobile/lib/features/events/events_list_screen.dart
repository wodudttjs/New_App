import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'events_provider.dart';

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('행사')),
      body: events.when(
        data: (items) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (_, index) => ListTile(
            title: Text(items[index].title),
            subtitle: Text('${items[index].locationName} · ${items[index].startAt}'),
          ),
          separatorBuilder: (_, __) => const Divider(),
          itemCount: items.length,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('행사 목록을 불러오지 못했습니다.')),
      ),
    );
  }
}
