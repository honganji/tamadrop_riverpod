// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoImpl _$$VideoImplFromJson(Map<String, dynamic> json) => _$VideoImpl(
      id: json['id'] as String,
      path: json['path'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      thumbnailFilePath: json['thumbnailFilePath'] as String,
      title: json['title'] as String,
      volume: (json['volume'] as num).toInt(),
      length: (json['length'] as num).toInt(),
    );

Map<String, dynamic> _$$VideoImplToJson(_$VideoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'createdAt': instance.createdAt.toIso8601String(),
      'thumbnailFilePath': instance.thumbnailFilePath,
      'title': instance.title,
      'volume': instance.volume,
      'length': instance.length,
    };
