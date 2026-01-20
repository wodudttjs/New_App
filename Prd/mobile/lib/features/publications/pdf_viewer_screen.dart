import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;
import 'publication_detail_provider.dart';
import '../../core/utils/launch_url.dart';

class PdfViewerScreen extends ConsumerWidget {
  const PdfViewerScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(publicationDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('PDF 뷰어')),
      body: detail.when(
        data: (item) => item.pdfUrl.isEmpty
            ? const Center(child: Text('PDF URL이 없습니다.'))
            : _PdfViewer(title: item.title, url: item.pdfUrl),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('PDF 정보를 불러오지 못했습니다.')),
      ),
    );
  }
}

class _PdfViewer extends StatefulWidget {
  const _PdfViewer({required this.title, required this.url});

  final String title;
  final String url;

  @override
  State<_PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<_PdfViewer> {
  PdfControllerPinch? _controller;
  bool _loading = true;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final res = await http.get(Uri.parse(widget.url));
      if (!mounted) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final controller = PdfControllerPinch(document: PdfDocument.openData(res.bodyBytes));
        setState(() {
          _controller = controller;
          _loading = false;
        });
      } else {
        setState(() {
          _failed = true;
          _loading = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _failed = true;
        _loading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(child: Text(widget.title, overflow: TextOverflow.ellipsis)),
              IconButton(
                onPressed: () => launchExternalUrl(widget.url),
                icon: const Icon(Icons.open_in_new),
              ),
            ],
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _failed
                  ? const Center(child: Text('PDF를 불러오지 못했습니다.'))
                  : PdfViewPinch(controller: _controller!),
        ),
      ],
    );
  }
}
