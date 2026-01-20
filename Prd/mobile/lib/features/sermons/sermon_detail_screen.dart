import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'sermon_detail_provider.dart';
import '../../core/utils/launch_url.dart';
import '../../core/providers/bookmark_provider.dart';
import '../../core/providers/continue_watching_provider.dart';

class SermonDetailScreen extends ConsumerWidget {
  const SermonDetailScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(sermonDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('설교 상세')),
      body: detail.when(
        data: (item) => _SermonDetailBody(item: item),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('설교 상세를 불러오지 못했습니다.')),
      ),
    );
  }
}

class _SermonDetailBody extends ConsumerStatefulWidget {
  const _SermonDetailBody({required this.item});

  final dynamic item;

  @override
  ConsumerState<_SermonDetailBody> createState() => _SermonDetailBodyState();
}

class _SermonDetailBodyState extends ConsumerState<_SermonDetailBody> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    if (widget.item.videoUrl.isEmpty) return;
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.item.videoUrl));
    await controller.initialize();
    final saved = ref.read(continueWatchingProvider(widget.item.id));
    if (saved > 0) {
      await controller.seekTo(Duration(seconds: saved));
    }
    setState(() {
      _videoController = controller;
      _chewieController = ChewieController(videoPlayerController: controller, autoPlay: false);
    });
    controller.addListener(_onPositionChanged);
  }

  void _onPositionChanged() {
    final controller = _videoController;
    if (controller == null) return;
    if (!controller.value.isInitialized) return;
    final seconds = controller.value.position.inSeconds;
    if (seconds % 10 == 0) {
      saveContinuePosition(ref, widget.item.id, seconds);
    }
  }

  @override
  void dispose() {
    final controller = _videoController;
    if (controller != null && controller.value.isInitialized) {
      saveContinuePosition(ref, widget.item.id, controller.value.position.inSeconds);
    }
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookmarks = ref.watch(bookmarksProvider);
    final isBookmarked = bookmarks.contains(widget.item.id);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text(widget.item.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(widget.item.speaker, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          if (_chewieController != null)
            AspectRatio(
              aspectRatio: _videoController?.value.aspectRatio ?? 16 / 9,
              child: Chewie(controller: _chewieController!),
            )
          else
            const Text('영상 플레이어를 준비 중입니다.'),
          const SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: widget.item.videoUrl.isEmpty ? null : () => launchExternalUrl(widget.item.videoUrl),
                child: const Text('영상 외부 열기'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: widget.item.audioUrl.isEmpty ? null : () => launchExternalUrl(widget.item.audioUrl),
                child: const Text('오디오 외부 열기'),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => toggleBookmark(ref, widget.item.id),
                icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(widget.item.summary),
          const SizedBox(height: 12),
          Text(widget.item.transcript),
        ],
      ),
    );
  }
}
