// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Favorite _$FavoriteFromJson(Map<String, dynamic> json) => _Favorite(
  id: json['id'] as String,
  userId: json['userId'] as String,
  targetId: json['targetId'] as String,
  targetType: $enumDecode(_$FavoriteTargetTypeEnumMap, json['targetType']),
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  label: json['label'] as String? ?? '',
  emoji: json['emoji'] as String? ?? '⭐',
  listId: json['listId'] as String?,
);

Map<String, dynamic> _$FavoriteToJson(_Favorite instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'targetId': instance.targetId,
  'targetType': _$FavoriteTargetTypeEnumMap[instance.targetType]!,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'label': instance.label,
  'emoji': instance.emoji,
  'listId': instance.listId,
};

const _$FavoriteTargetTypeEnumMap = {
  FavoriteTargetType.list: 'list',
  FavoriteTargetType.item: 'item',
  FavoriteTargetType.template: 'template',
};

_RecentSearch _$RecentSearchFromJson(Map<String, dynamic> json) =>
    _RecentSearch(
      id: json['id'] as String,
      userId: json['userId'] as String,
      query: json['query'] as String,
      searchedAt: const TimestampConverter().fromJson(json['searchedAt']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      searchCount: (json['searchCount'] as num?)?.toInt() ?? 1,
      resultCount: (json['resultCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$RecentSearchToJson(_RecentSearch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'query': instance.query,
      'searchedAt': const TimestampConverter().toJson(instance.searchedAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'searchCount': instance.searchCount,
      'resultCount': instance.resultCount,
    };
