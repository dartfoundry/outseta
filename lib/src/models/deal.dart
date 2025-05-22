import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'person.dart';
import 'account.dart';

part 'deal.g.dart';

/// Deal model representing a sales opportunity in the Outseta CRM
@JsonSerializable()
class Deal extends BaseModelWithMetadata {
  /// Creates a new Deal instance
  const Deal({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.name,
    this.amount,
    this.stage,
    this.stageUid,
    this.dealPipelineUid,
    this.accountUid,
    this.account,
    this.personUid,
    this.person,
    this.assignedToPersonUid,
    this.assignedToPerson,
    this.closeDate,
    this.dealLostReason,
    this.description,
    this.customFields,
  });

  /// Factory constructor that creates a [Deal] from JSON data
  factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);

  /// The name of the deal
  @JsonKey(name: 'Name')
  final String? name;

  /// The amount of the deal
  @JsonKey(name: 'Amount')
  final double? amount;

  /// The stage of the deal (e.g., 'Qualification', 'Proposal', 'Negotiation')
  @JsonKey(name: 'Stage')
  final String? stage;

  /// The UID of the stage
  @JsonKey(name: 'StageUid')
  final String? stageUid;

  /// The UID of the deal pipeline
  @JsonKey(name: 'DealPipelineUid')
  final String? dealPipelineUid;

  /// The UID of the account associated with this deal
  @JsonKey(name: 'AccountUid')
  final String? accountUid;

  /// The account associated with this deal
  @JsonKey(name: 'Account')
  final Account? account;

  /// The UID of the person associated with this deal
  @JsonKey(name: 'PersonUid')
  final String? personUid;

  /// The person associated with this deal
  @JsonKey(name: 'Person')
  final Person? person;

  /// The UID of the person this deal is assigned to
  @JsonKey(name: 'AssignedToPersonUid')
  final String? assignedToPersonUid;

  /// The person this deal is assigned to
  @JsonKey(name: 'AssignedToPerson')
  final Person? assignedToPerson;

  /// The close date of the deal
  @JsonKey(name: 'CloseDate')
  final DateTime? closeDate;

  /// The reason the deal was lost, if applicable
  @JsonKey(name: 'DealLostReason')
  final String? dealLostReason;

  /// The description of the deal
  @JsonKey(name: 'Description')
  final String? description;

  /// Custom fields associated with this deal
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this deal instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$DealToJson(this);

  /// Creates a copy of this deal with the given fields replaced with new values
  Deal copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? name,
    double? amount,
    String? stage,
    String? stageUid,
    String? dealPipelineUid,
    String? accountUid,
    Account? account,
    String? personUid,
    Person? person,
    String? assignedToPersonUid,
    Person? assignedToPerson,
    DateTime? closeDate,
    String? dealLostReason,
    String? description,
    Map<String, dynamic>? customFields,
  }) {
    return Deal(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      stage: stage ?? this.stage,
      stageUid: stageUid ?? this.stageUid,
      dealPipelineUid: dealPipelineUid ?? this.dealPipelineUid,
      accountUid: accountUid ?? this.accountUid,
      account: account ?? this.account,
      personUid: personUid ?? this.personUid,
      person: person ?? this.person,
      assignedToPersonUid: assignedToPersonUid ?? this.assignedToPersonUid,
      assignedToPerson: assignedToPerson ?? this.assignedToPerson,
      closeDate: closeDate ?? this.closeDate,
      dealLostReason: dealLostReason ?? this.dealLostReason,
      description: description ?? this.description,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        amount,
        stage,
        stageUid,
        dealPipelineUid,
        accountUid,
        account,
        personUid,
        person,
        assignedToPersonUid,
        assignedToPerson,
        closeDate,
        dealLostReason,
        description,
        customFields,
      ];
}