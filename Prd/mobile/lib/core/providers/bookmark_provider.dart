import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'local_storage_provider.dart';

final bookmarksProvider = StateProvider<List<String>>((ref) {
  return ref.read(localStorageProvider).getBookmarks();
});

Future<void> toggleBookmark(WidgetRef ref, String id) async {
  await ref.read(localStorageProvider).toggleBookmark(id);
  ref.read(bookmarksProvider.notifier).state = ref.read(localStorageProvider).getBookmarks();
}
