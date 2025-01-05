// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
      id: json['id'] as String,
      path: json['path'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      thumbnailFilePath: json['thumbnail_file_path'] as String,
      title: json['title'] as String,
      volume: (json['volume'] as num).toInt(),
      length: (json['length'] as num).toInt(),
    );

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'created_at': instance.createdAt.toIso8601String(),
      'thumbnail_file_path': instance.thumbnailFilePath,
      'title': instance.title,
      'volume': instance.volume,
      'length': instance.length,
    };
