import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../storage/local_storage.dart';

final localStorageProvider = Provider<LocalStorage>((ref) {
  final settings = Hive.box('settings');
  final bookmarks = Hive.box('bookmarks');
  final continueBox = Hive.box('continue_watching');
  final cacheBox = Hive.box('cache');
  return LocalStorage(settings, bookmarks, continueBox, cacheBox);
});
