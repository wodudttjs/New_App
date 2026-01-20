import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feed = ref.watch(homeFeedProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          feed.when(
            data: (data) => _HeroCard(quote: data.heroQuote, subtitle: data.heroSubtitle),
            loading: () => const _HeroCard(quote: '로딩 중...', subtitle: ''),
            error: (_, __) => const _HeroCard(quote: '로드 실패', subtitle: '다시 시도해주세요.'),
          ),
          const SizedBox(height: 16),
          _SectionCard(title: '최신 설교', onTap: () => context.go('/sermons')),
          feed.when(
            data: (data) => _MiniList(items: data.latestSermons.map((e) => e.title).toList()),
            loading: () => const _MiniList(items: ['불러오는 중...']),
            error: (_, __) => const _MiniList(items: ['불러오기 실패']),
          ),
          const SizedBox(height: 12),
          _SectionCard(title: '최신 소식', onTap: () => context.go('/news')),
          feed.when(
            data: (data) => _MiniList(items: data.latestNews.map((e) => e.title).toList()),
            loading: () => const _MiniList(items: ['불러오는 중...']),
            error: (_, __) => const _MiniList(items: ['불러오기 실패']),
          ),
          _SectionCard(title: '행사', onTap: () => context.go('/events')),
          _SectionCard(title: '커뮤니티 찾기', onTap: () => context.go('/communities')),
          _SectionCard(title: '출판물', onTap: () => context.go('/publications')),
          _SectionCard(title: '검색', onTap: () => context.go('/search')),
          _SectionCard(title: '기부', onTap: () => context.go('/donate')),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.quote, required this.subtitle});

  final String quote;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF2F1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('오늘의 한 문장', style: TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 8),
          Text(quote, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
        ],
      ),
    );
  }
}

class _MiniList extends StatelessWidget {
  const _MiniList({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map((item) => ListTile(
                dense: true,
                title: Text(item),
                contentPadding: EdgeInsets.zero,
              ))
          .toList(),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.onTap});

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
