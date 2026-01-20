import 'package:flutter/material.dart';
import '../webview/webview_screen.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const donateUrl = 'https://example.org/donate';
    return Scaffold(
      appBar: AppBar(title: const Text('기부')),
      body: WebViewScreen(title: '기부', url: donateUrl),
    );
  }
}
