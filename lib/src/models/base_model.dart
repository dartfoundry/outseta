import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

/// Base class for all Outseta API models
abstract class BaseModel extends Equatable {
  /// Creates a new base model with the given unique identifier
  const BaseModel({this.uid});

  /// The unique identifier of the model
  @JsonKey(name: 'Uid')
  final String? uid;

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson();

  @override
  List<Object?> get props => [uid];
}

/// Base class for models that include metadata
abstract class BaseModelWithMetadata extends BaseModel {
  /// Creates a new base model with the given unique identifier and metadata
  const BaseModelWithMetadata({
    super.uid,
    this.created,
    this.updated,
    this.createdBy,
    this.updatedBy,
  });

  /// The date and time the model was created
  @JsonKey(name: 'Created')
  final DateTime? created;

  /// The date and time the model was last updated
  @JsonKey(name: 'Updated')
  final DateTime? updated;

  /// The user who created the model
  @JsonKey(name: 'CreatedBy')
  final String? createdBy;

  /// The user who last updated the model
  @JsonKey(name: 'UpdatedBy')
  final String? updatedBy;

  @override
  List<Object?> get props => [
    ...super.props,
    created,
    updated,
    createdBy,
    updatedBy,
  ];
}
