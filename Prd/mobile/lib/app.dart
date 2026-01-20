import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_screen.dart';
import 'features/sermons/sermon_list_screen.dart';
import 'features/sermons/sermon_detail_screen.dart';
import 'features/news/news_list_screen.dart';
import 'features/news/news_detail_screen.dart';
import 'features/communities/community_search_screen.dart';
import 'features/communities/community_detail_screen.dart';
import 'features/publications/publications_list_screen.dart';
import 'features/publications/pdf_viewer_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/events/events_list_screen.dart';
import 'features/search/search_screen.dart';
import 'features/donate/donate_screen.dart';

class FfwpuApp extends StatelessWidget {
  const FfwpuApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/sermons', builder: (_, __) => const SermonListScreen()),
        GoRoute(
          path: '/sermons/:id',
          builder: (_, state) => SermonDetailScreen(id: state.pathParameters['id'] ?? ''),
        ),
        GoRoute(path: '/news', builder: (_, __) => const NewsListScreen()),
        GoRoute(
          path: '/news/:id',
          builder: (_, state) => NewsDetailScreen(id: state.pathParameters['id'] ?? ''),
        ),
        GoRoute(path: '/communities', builder: (_, __) => const CommunitySearchScreen()),
        GoRoute(
          path: '/communities/:id',
          builder: (_, state) => CommunityDetailScreen(id: state.pathParameters['id'] ?? ''),
        ),
        GoRoute(path: '/publications', builder: (_, __) => const PublicationsListScreen()),
        GoRoute(
          path: '/publications/:id',
          builder: (_, state) => PdfViewerScreen(id: state.pathParameters['id'] ?? ''),
        ),
        GoRoute(path: '/events', builder: (_, __) => const EventsListScreen()),
        GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
        GoRoute(path: '/donate', builder: (_, __) => const DonateScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'FFWPU',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D3A3A)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
