import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeProvider);
  return themeMode == ThemeMode.dark;
}); 