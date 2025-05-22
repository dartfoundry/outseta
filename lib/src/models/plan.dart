import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'plan.g.dart';

/// Plan model representing a subscription plan in the Outseta API
@JsonSerializable()
class Plan extends BaseModelWithMetadata {
  /// Creates a new Plan instance
  const Plan({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.name,
    this.description,
    this.billingTerm,
    this.billingTermCount,
    this.amount,
    this.setupFee,
    this.trialPeriodDays,
    this.isActive,
    this.isFree,
    this.recurringChargeAgreementRequired,
    this.planAddOns,
    this.customFields,
  });

  /// Factory constructor that creates a [Plan] from JSON data
  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);

  /// The name of the plan
  @JsonKey(name: 'Name')
  final String? name;

  /// The description of the plan
  @JsonKey(name: 'Description')
  final String? description;

  /// The billing term (e.g., 'Month', 'Year')
  @JsonKey(name: 'BillingTerm')
  final String? billingTerm;

  /// The number of billing terms
  @JsonKey(name: 'BillingTermCount')
  final int? billingTermCount;

  /// The amount for the plan
  @JsonKey(name: 'Amount')
  final double? amount;

  /// The setup fee for the plan
  @JsonKey(name: 'SetupFee')
  final double? setupFee;

  /// The number of trial period days
  @JsonKey(name: 'TrialPeriodDays')
  final int? trialPeriodDays;

  /// Whether the plan is active
  @JsonKey(name: 'IsActive')
  final bool? isActive;

  /// Whether the plan is free
  @JsonKey(name: 'IsFree')
  final bool? isFree;

  /// Whether a recurring charge agreement is required
  @JsonKey(name: 'RecurringChargeAgreementRequired')
  final bool? recurringChargeAgreementRequired;

  /// The add-ons associated with this plan
  @JsonKey(name: 'PlanAddOns')
  final List<dynamic>? planAddOns;

  /// Custom fields associated with this plan
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this plan instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$PlanToJson(this);

  /// Creates a copy of this plan with the given fields replaced with new values
  Plan copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? name,
    String? description,
    String? billingTerm,
    int? billingTermCount,
    double? amount,
    double? setupFee,
    int? trialPeriodDays,
    bool? isActive,
    bool? isFree,
    bool? recurringChargeAgreementRequired,
    List<dynamic>? planAddOns,
    Map<String, dynamic>? customFields,
  }) {
    return Plan(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      name: name ?? this.name,
      description: description ?? this.description,
      billingTerm: billingTerm ?? this.billingTerm,
      billingTermCount: billingTermCount ?? this.billingTermCount,
      amount: amount ?? this.amount,
      setupFee: setupFee ?? this.setupFee,
      trialPeriodDays: trialPeriodDays ?? this.trialPeriodDays,
      isActive: isActive ?? this.isActive,
      isFree: isFree ?? this.isFree,
      recurringChargeAgreementRequired: recurringChargeAgreementRequired ?? this.recurringChargeAgreementRequired,
      planAddOns: planAddOns ?? this.planAddOns,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        description,
        billingTerm,
        billingTermCount,
        amount,
        setupFee,
        trialPeriodDays,
        isActive,
        isFree,
        recurringChargeAgreementRequired,
        planAddOns,
        customFields,
      ];
}