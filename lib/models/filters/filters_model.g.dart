// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FiltersModel _$FiltersModelFromJson(Map<String, dynamic> json) => FiltersModel(
      status: (json['status'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$StatusEnumEnumMap, k), e as bool),
      ),
      priority: (json['priority'] as Map<String, dynamic>).map(
        (k, e) => MapEntry($enumDecode(_$PriorityEnumEnumMap, k), e as bool),
      ),
      selectedSortBy:
          $enumDecodeNullable(_$SortByEnumEnumMap, json['selectedSortBy']),
      selectedServiceCategory:
          (json['selectedServiceCategory'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$FiltersModelToJson(FiltersModel instance) =>
    <String, dynamic>{
      'status':
          instance.status.map((k, e) => MapEntry(_$StatusEnumEnumMap[k]!, e)),
      'priority': instance.priority
          .map((k, e) => MapEntry(_$PriorityEnumEnumMap[k]!, e)),
      'selectedSortBy': _$SortByEnumEnumMap[instance.selectedSortBy],
      'selectedServiceCategory': instance.selectedServiceCategory,
    };

const _$StatusEnumEnumMap = {
  StatusEnum.scheduled: 'scheduled',
  StatusEnum.inprogress: 'inprogress',
  StatusEnum.completed: 'completed',
  StatusEnum.canceled: 'canceled',
};

const _$PriorityEnumEnumMap = {
  PriorityEnum.high: 'high',
  PriorityEnum.medium: 'medium',
  PriorityEnum.low: 'low',
};

const _$SortByEnumEnumMap = {
  SortByEnum.desc: 'desc',
  SortByEnum.asc: 'asc',
};
