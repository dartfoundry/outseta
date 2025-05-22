import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

/// A class that represents pagination metadata from the Outseta API responses
@JsonSerializable()
class Pagination {
  /// Creates a new pagination instance
  const Pagination({
    required this.count,
    required this.limit,
    required this.offset,
    required this.total,
  });

  /// Factory constructor that creates a [Pagination] from JSON data
  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  /// The number of items in the current page
  @JsonKey(name: 'count')
  final int count;

  /// The maximum number of items per page
  @JsonKey(name: 'limit')
  final int limit;

  /// The offset (starting point) of the current page
  @JsonKey(name: 'offset')
  final int offset;

  /// The total number of items available
  @JsonKey(name: 'total')
  final int total;

  /// Converts this pagination instance to a JSON map
  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}

/// A paginated response from the Outseta API
@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  /// Creates a new paginated response
  const PaginatedResponse({
    required this.items,
    required this.metadata,
  });

  /// Factory constructor that creates a [PaginatedResponse] from JSON data
  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  /// The list of items in the current page
  @JsonKey(name: 'items')
  final List<T> items;

  /// The pagination metadata
  @JsonKey(name: 'metadata')
  final Pagination metadata;

  /// Converts this paginated response to a JSON map
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}