import 'package:json_annotation/json_annotation.dart';

part 'metadata.g.dart';

/// A class that represents metadata fields that are included in some API responses
@JsonSerializable()
class Metadata {
  /// Creates a new metadata instance
  const Metadata({this.created, this.updated, this.createdBy, this.updatedBy});

  /// Factory constructor that creates a [Metadata] from JSON data
  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);

  /// The date and time the resource was created
  @JsonKey(name: 'Created')
  final DateTime? created;

  /// The date and time the resource was last updated
  @JsonKey(name: 'Updated')
  final DateTime? updated;

  /// The user who created the resource
  @JsonKey(name: 'CreatedBy')
  final String? createdBy;

  /// The user who last updated the resource
  @JsonKey(name: 'UpdatedBy')
  final String? updatedBy;

  /// Converts this metadata instance to a JSON map
  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
