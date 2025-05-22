// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pagination _$PaginationFromJson(Map<String, dynamic> json) =>
    $checkedCreate('Pagination', json, ($checkedConvert) {
      final val = Pagination(
        count: $checkedConvert('count', (v) => (v as num).toInt()),
        limit: $checkedConvert('limit', (v) => (v as num).toInt()),
        offset: $checkedConvert('offset', (v) => (v as num).toInt()),
        total: $checkedConvert('total', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };

PaginatedResponse<T> _$PaginatedResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => $checkedCreate('PaginatedResponse', json, ($checkedConvert) {
  final val = PaginatedResponse<T>(
    items: $checkedConvert(
      'items',
      (v) => (v as List<dynamic>).map(fromJsonT).toList(),
    ),
    metadata: $checkedConvert(
      'metadata',
      (v) => Pagination.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$PaginatedResponseToJson<T>(
  PaginatedResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'metadata': instance.metadata.toJson(),
};
