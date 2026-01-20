import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage_provider.dart';

final continueWatchingProvider = StateProvider.family<int, String>((ref, id) {
  return ref.read(localStorageProvider).getContinuePosition(id);
});

Future<void> saveContinuePosition(WidgetRef ref, String id, int seconds) async {
  await ref.read(localStorageProvider).setContinuePosition(id, seconds);
  ref.read(continueWatchingProvider(id).notifier).state = seconds;
}
