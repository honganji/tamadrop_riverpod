import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tamadrop_riverpod/infra/impl/repository/video_repo_impl.dart';
import 'package:tamadrop_riverpod/infra/service/sqlite/sqlite.dart';

part 'all_id.g.dart';

@riverpod
class AllId extends _$AllId {
  @override
  Future<String> build() async {
    final db = ref.watch(sqfliteProvider);
    final VideoRepoImpl repo = VideoRepoImpl(db: db);
    late String id;
    try {
      id = await repo.getAllId();
    } catch (e) {
      print(e.toString());
    }
    return id;
  }
}
