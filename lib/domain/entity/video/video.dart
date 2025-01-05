import 'package:freezed_annotation/freezed_annotation.dart';

part 'video.freezed.dart';
part 'video.g.dart';

@freezed
class Video with _$Video {
  const factory Video({
    required String id,
    required String path,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'thumbnail_file_path') required String thumbnailFilePath,
    required String title,
    required int volume,
    required int length,
  }) = _Video;

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);
}
