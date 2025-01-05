import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tamadrop_riverpod/presentation/theme/dark_theme.dart';
import 'package:tamadrop_riverpod/presentation/theme/light_theme.dart';

part 'theme.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  ThemeData build() {
    return lightTheme;
  }

  void toggleTheme() {
    state = isDark() ? lightTheme : darkTheme;
  }

  bool isDark() {
    return state == darkTheme;
  }
}
