import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings_provider.dart';
import '../../core/utils/permission_utils.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pushSermon = ref.watch(pushSermonProvider);
    final pushNotice = ref.watch(pushNoticeProvider);
    final pushEvent = ref.watch(pushEventProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('신규 설교 알림'),
            value: pushSermon,
            onChanged: (value) async {
              if (value) {
                final granted = await requestNotificationPermission();
                if (!granted) return;
              }
              ref.read(pushSermonProvider.notifier).state = value;
              await persistPushSetting(ref, pushKeyFor('sermon'), value);
            },
          ),
          SwitchListTile(
            title: const Text('공지 알림'),
            value: pushNotice,
            onChanged: (value) async {
              if (value) {
                final granted = await requestNotificationPermission();
                if (!granted) return;
              }
              ref.read(pushNoticeProvider.notifier).state = value;
              await persistPushSetting(ref, pushKeyFor('notice'), value);
            },
          ),
          SwitchListTile(
            title: const Text('행사 리마인더'),
            value: pushEvent,
            onChanged: (value) async {
              if (value) {
                final granted = await requestNotificationPermission();
                if (!granted) return;
              }
              ref.read(pushEventProvider.notifier).state = value;
              await persistPushSetting(ref, pushKeyFor('event'), value);
            },
          ),
          const ListTile(title: Text('개인정보 처리방침')),
          const ListTile(title: Text('이용약관')),
          const ListTile(title: Text('앱 정보')),
        ],
      ),
    );
  }
}
