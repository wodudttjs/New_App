import 'package:flutter_riverpod/flutter_riverpod.dart';

final sermonQueryProvider = StateProvider<String>((ref) => '');
final sermonCategoryProvider = StateProvider<String>((ref) => '');
final sermonYearProvider = StateProvider<String>((ref) => '');

final newsQueryProvider = StateProvider<String>((ref) => '');
final newsCategoryProvider = StateProvider<String>((ref) => '');
