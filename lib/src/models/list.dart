import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'list.g.dart';

/// EmailList model representing an email list in the Outseta Marketing API
@JsonSerializable()
class EmailList extends BaseModelWithMetadata {
  /// Creates a new EmailList instance
  const EmailList({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.name,
    this.description,
    this.subscriberCount,
    this.customFields,
  });

  /// Factory constructor that creates an [EmailList] from JSON data
  factory EmailList.fromJson(Map<String, dynamic> json) => _$EmailListFromJson(json);

  /// The name of the email list
  @JsonKey(name: 'Name')
  final String? name;

  /// The description of the email list
  @JsonKey(name: 'Description')
  final String? description;

  /// The number of subscribers on the list
  @JsonKey(name: 'SubscriberCount')
  final int? subscriberCount;

  /// Custom fields associated with this email list
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this email list instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$EmailListToJson(this);

  /// Creates a copy of this email list with the given fields replaced with new values
  EmailList copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? name,
    String? description,
    int? subscriberCount,
    Map<String, dynamic>? customFields,
  }) {
    return EmailList(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      name: name ?? this.name,
      description: description ?? this.description,
      subscriberCount: subscriberCount ?? this.subscriberCount,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        description,
        subscriberCount,
        customFields,
      ];
}