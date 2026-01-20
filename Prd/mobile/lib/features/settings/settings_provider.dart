import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/providers/local_storage_provider.dart';

const _pushSermonKey = 'push_sermon';
const _pushNoticeKey = 'push_notice';
const _pushEventKey = 'push_event';

final pushSermonProvider = StateProvider<bool>((ref) {
  return ref.read(localStorageProvider).getBool(_pushSermonKey);
});

final pushNoticeProvider = StateProvider<bool>((ref) {
  return ref.read(localStorageProvider).getBool(_pushNoticeKey);
});

final pushEventProvider = StateProvider<bool>((ref) {
  return ref.read(localStorageProvider).getBool(_pushEventKey);
});

Future<void> persistPushSetting(WidgetRef ref, String key, bool value) async {
  await ref.read(localStorageProvider).setBool(key, value);
}

String pushKeyFor(String type) {
  switch (type) {
    case 'sermon':
      return _pushSermonKey;
    case 'notice':
      return _pushNoticeKey;
    case 'event':
      return _pushEventKey;
    default:
      return _pushSermonKey;
  }
}
