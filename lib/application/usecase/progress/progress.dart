import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress.g.dart';

@riverpod
class Progress extends _$Progress {
  @override
  double build() {
    return 0;
  }

  void update(double data) {
    state = data;
  }

  void reset() {
    state = 0;
  }
}
