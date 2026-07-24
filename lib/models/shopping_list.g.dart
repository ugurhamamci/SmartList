// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ShoppingList _$ShoppingListFromJson(
  Map<String, dynamic> json,
) => _ShoppingList(
  id: json['id'] as String,
  title: json['title'] as String,
  ownerId: json['ownerId'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
  createdBy: json['createdBy'] as String,
  updatedBy: json['updatedBy'] as String,
  description: json['description'] as String? ?? '',
  emoji: json['emoji'] as String? ?? '🛒',
  colorHex: json['colorHex'] as String? ?? 'FF6C63FF',
  categoryId: json['categoryId'] as String?,
  memberIds:
      (json['memberIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  memberRoles:
      (json['memberRoles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, $enumDecode(_$MemberRoleEnumMap, e)),
      ) ??
      const <String, MemberRole>{},
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 1,
  itemCount: (json['itemCount'] as num?)?.toInt() ?? 0,
  completedItemCount: (json['completedItemCount'] as num?)?.toInt() ?? 0,
  isArchived: json['isArchived'] as bool? ?? false,
  isPinned: json['isPinned'] as bool? ?? false,
  isFavorite: json['isFavorite'] as bool? ?? false,
  isCompleted: json['isCompleted'] as bool? ?? false,
  completedAt: const NullableTimestampConverter().fromJson(json['completedAt']),
  lastActivityAt: const NullableTimestampConverter().fromJson(
    json['lastActivityAt'],
  ),
  itemSortOption:
      $enumDecodeNullable(_$ItemSortOptionEnumMap, json['itemSortOption']) ??
      ItemSortOption.manual,
  budget: const NullableDoubleConverter().fromJson(json['budget']),
  currency: json['currency'] as String? ?? 'USD',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  totalSpent: json['totalSpent'] == null
      ? 0
      : const FlexibleDoubleConverter().fromJson(json['totalSpent']),
  generatedFrom: $enumDecodeNullable(
    _$AiListKindEnumMap,
    json['generatedFrom'],
  ),
  deletedAt: const NullableTimestampConverter().fromJson(json['deletedAt']),
  version: (json['version'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$ShoppingListToJson(
  _ShoppingList instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'ownerId': instance.ownerId,
  'createdAt': const TimestampConverter().toJson(instance.createdAt),
  'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
  'createdBy': instance.createdBy,
  'updatedBy': instance.updatedBy,
  'description': instance.description,
  'emoji': instance.emoji,
  'colorHex': instance.colorHex,
  'categoryId': instance.categoryId,
  'memberIds': instance.memberIds,
  'memberRoles': instance.memberRoles.map(
    (k, e) => MapEntry(k, _$MemberRoleEnumMap[e]!),
  ),
  'memberCount': instance.memberCount,
  'itemCount': instance.itemCount,
  'completedItemCount': instance.completedItemCount,
  'isArchived': instance.isArchived,
  'isPinned': instance.isPinned,
  'isFavorite': instance.isFavorite,
  'isCompleted': instance.isCompleted,
  'completedAt': const NullableTimestampConverter().toJson(
    instance.completedAt,
  ),
  'lastActivityAt': const NullableTimestampConverter().toJson(
    instance.lastActivityAt,
  ),
  'itemSortOption': _$ItemSortOptionEnumMap[instance.itemSortOption]!,
  'budget': const NullableDoubleConverter().toJson(instance.budget),
  'currency': instance.currency,
  'tags': instance.tags,
  'totalSpent': const FlexibleDoubleConverter().toJson(instance.totalSpent),
  'generatedFrom': _$AiListKindEnumMap[instance.generatedFrom],
  'deletedAt': const NullableTimestampConverter().toJson(instance.deletedAt),
  'version': instance.version,
};

const _$MemberRoleEnumMap = {
  MemberRole.owner: 'owner',
  MemberRole.editor: 'editor',
  MemberRole.viewer: 'viewer',
  MemberRole.guest: 'guest',
};

const _$ItemSortOptionEnumMap = {
  ItemSortOption.manual: 'manual',
  ItemSortOption.alphabetical: 'alphabetical',
  ItemSortOption.category: 'category',
  ItemSortOption.priority: 'priority',
  ItemSortOption.completion: 'completion',
  ItemSortOption.recentlyAdded: 'recently_added',
};

const _$AiListKindEnumMap = {
  AiListKind.weeklyShopping: 'weekly_shopping',
  AiListKind.mealPlan: 'meal_plan',
  AiListKind.party: 'party',
  AiListKind.baby: 'baby',
  AiListKind.diet: 'diet',
  AiListKind.custom: 'custom',
};
