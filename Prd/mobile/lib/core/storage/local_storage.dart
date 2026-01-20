import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  LocalStorage(this._settingsBox, this._bookmarksBox, this._continueBox, this._cacheBox);

  final Box _settingsBox;
  final Box _bookmarksBox;
  final Box _continueBox;
  final Box _cacheBox;

  bool getBool(String key, {bool fallback = false}) {
    return _settingsBox.get(key, defaultValue: fallback) as bool;
  }

  Future<void> setBool(String key, bool value) async {
    await _settingsBox.put(key, value);
  }

  List<String> getBookmarks() {
    return (_bookmarksBox.get('items', defaultValue: <String>[]) as List)
        .whereType<String>()
        .toList();
  }

  Future<void> toggleBookmark(String id) async {
    final items = getBookmarks();
    if (items.contains(id)) {
      items.remove(id);
    } else {
      items.add(id);
    }
    await _bookmarksBox.put('items', items);
  }

  int getContinuePosition(String id) {
    return _continueBox.get(id, defaultValue: 0) as int;
  }

  Future<void> setContinuePosition(String id, int seconds) async {
    await _continueBox.put(id, seconds);
  }

  List<Map<String, dynamic>> getCachedList(String key) {
    return (_cacheBox.get(key, defaultValue: <dynamic>[]) as List)
        .whereType<Map>()
        .map((item) => item.map((k, v) => MapEntry(k.toString(), v)))
        .toList();
  }

  Future<void> setCachedList(String key, List<Map<String, dynamic>> items) async {
    await _cacheBox.put(key, items);
  }
}
