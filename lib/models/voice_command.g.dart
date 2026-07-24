// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ParsedVoiceItem _$ParsedVoiceItemFromJson(Map<String, dynamic> json) =>
    _ParsedVoiceItem(
      name: json['name'] as String,
      quantity: json['quantity'] == null
          ? 1
          : const FlexibleDoubleConverter().fromJson(json['quantity']),
      unit:
          $enumDecodeNullable(_$MeasurementUnitEnumMap, json['unit']) ??
          MeasurementUnit.piece,
      categoryId: json['categoryId'] as String?,
      priority:
          $enumDecodeNullable(_$ItemPriorityEnumMap, json['priority']) ??
          ItemPriority.normal,
      confidence: json['confidence'] == null
          ? 1
          : const FlexibleDoubleConverter().fromJson(json['confidence']),
      sourcePhrase: json['sourcePhrase'] as String? ?? '',
    );

Map<String, dynamic> _$ParsedVoiceItemToJson(_ParsedVoiceItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'quantity': const FlexibleDoubleConverter().toJson(instance.quantity),
      'unit': _$MeasurementUnitEnumMap[instance.unit]!,
      'categoryId': instance.categoryId,
      'priority': _$ItemPriorityEnumMap[instance.priority]!,
      'confidence': const FlexibleDoubleConverter().toJson(instance.confidence),
      'sourcePhrase': instance.sourcePhrase,
    };

const _$MeasurementUnitEnumMap = {
  MeasurementUnit.piece: 'piece',
  MeasurementUnit.gram: 'g',
  MeasurementUnit.kilogram: 'kg',
  MeasurementUnit.milliliter: 'ml',
  MeasurementUnit.liter: 'l',
  MeasurementUnit.pack: 'pack',
  MeasurementUnit.box: 'box',
  MeasurementUnit.bottle: 'bottle',
  MeasurementUnit.can: 'can',
  MeasurementUnit.bag: 'bag',
  MeasurementUnit.bunch: 'bunch',
  MeasurementUnit.dozen: 'dozen',
  MeasurementUnit.ounce: 'oz',
  MeasurementUnit.pound: 'lb',
  MeasurementUnit.fluidOunce: 'fl_oz',
  MeasurementUnit.gallon: 'gal',
};

const _$ItemPriorityEnumMap = {
  ItemPriority.low: 'low',
  ItemPriority.normal: 'normal',
  ItemPriority.high: 'high',
  ItemPriority.urgent: 'urgent',
};

_VoiceCommand _$VoiceCommandFromJson(Map<String, dynamic> json) =>
    _VoiceCommand(
      id: json['id'] as String,
      userId: json['userId'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
      status:
          $enumDecodeNullable(_$VoiceCommandStatusEnumMap, json['status']) ??
          VoiceCommandStatus.listening,
      transcript: json['transcript'] as String? ?? '',
      localeId: json['localeId'] as String? ?? 'en',
      confidence: json['confidence'] == null
          ? 1
          : const FlexibleDoubleConverter().fromJson(json['confidence']),
      parsedItems:
          (json['parsedItems'] as List<dynamic>?)
              ?.map((e) => ParsedVoiceItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ParsedVoiceItem>[],
      listId: json['listId'] as String?,
      createdItemIds:
          (json['createdItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      errorCode: json['errorCode'] as String?,
      captureDuration: const NullableDurationConverter().fromJson(
        (json['captureDuration'] as num?)?.toInt(),
      ),
    );

Map<String, dynamic> _$VoiceCommandToJson(_VoiceCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
      'status': _$VoiceCommandStatusEnumMap[instance.status]!,
      'transcript': instance.transcript,
      'localeId': instance.localeId,
      'confidence': const FlexibleDoubleConverter().toJson(instance.confidence),
      'parsedItems': instance.parsedItems,
      'listId': instance.listId,
      'createdItemIds': instance.createdItemIds,
      'errorCode': instance.errorCode,
      'captureDuration': const NullableDurationConverter().toJson(
        instance.captureDuration,
      ),
    };

const _$VoiceCommandStatusEnumMap = {
  VoiceCommandStatus.listening: 'listening',
  VoiceCommandStatus.transcribed: 'transcribed',
  VoiceCommandStatus.parsed: 'parsed',
  VoiceCommandStatus.applied: 'applied',
  VoiceCommandStatus.failed: 'failed',
};
