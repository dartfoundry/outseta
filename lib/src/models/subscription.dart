import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'plan.dart';

part 'subscription.g.dart';

/// Subscription model representing a customer subscription in the Outseta API
@JsonSerializable()
class Subscription extends BaseModelWithMetadata {
  /// Creates a new Subscription instance
  const Subscription({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.billingRenewalTerm,
    this.plan,
    this.planUid,
    this.accountUid,
    this.personUid,
    this.startDate,
    this.endDate,
    this.cancelDate,
    this.billingStart,
    this.billingEnd,
    this.cancellationReason,
    this.quantity,
    this.amount,
    this.setupFee,
    this.discount,
    this.taxAmount,
    this.total,
    this.status,
    this.subscriptionAddOns,
    this.paymentMethod,
    this.planName,
    this.customFields,
  });

  /// Factory constructor that creates a [Subscription] from JSON data
  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  /// The billing renewal term (e.g., 'Month', 'Year')
  @JsonKey(name: 'BillingRenewalTerm')
  final String? billingRenewalTerm;

  /// The plan associated with this subscription
  @JsonKey(name: 'Plan')
  final Plan? plan;

  /// The UID of the plan associated with this subscription
  @JsonKey(name: 'PlanUid')
  final String? planUid;

  /// The UID of the account associated with this subscription
  @JsonKey(name: 'AccountUid')
  final String? accountUid;

  /// The UID of the person associated with this subscription
  @JsonKey(name: 'PersonUid')
  final String? personUid;

  /// The start date of the subscription
  @JsonKey(name: 'StartDate')
  final DateTime? startDate;

  /// The end date of the subscription
  @JsonKey(name: 'EndDate')
  final DateTime? endDate;

  /// The date the subscription was cancelled
  @JsonKey(name: 'CancelDate')
  final DateTime? cancelDate;

  /// The date billing starts for this subscription
  @JsonKey(name: 'BillingStart')
  final DateTime? billingStart;

  /// The date billing ends for this subscription
  @JsonKey(name: 'BillingEnd')
  final DateTime? billingEnd;

  /// The reason for cancellation, if applicable
  @JsonKey(name: 'CancellationReason')
  final String? cancellationReason;

  /// The quantity of the subscription
  @JsonKey(name: 'Quantity')
  final int? quantity;

  /// The base amount for the subscription
  @JsonKey(name: 'Amount')
  final double? amount;

  /// The setup fee for the subscription
  @JsonKey(name: 'SetupFee')
  final double? setupFee;

  /// The discount amount for the subscription
  @JsonKey(name: 'Discount')
  final double? discount;

  /// The tax amount for the subscription
  @JsonKey(name: 'TaxAmount')
  final double? taxAmount;

  /// The total amount for the subscription
  @JsonKey(name: 'Total')
  final double? total;

  /// The status of the subscription (e.g., 'Active', 'Canceled', 'Trial')
  @JsonKey(name: 'Status')
  final String? status;

  /// The add-ons associated with this subscription
  @JsonKey(name: 'SubscriptionAddOns')
  final List<dynamic>? subscriptionAddOns;

  /// The payment method for this subscription
  @JsonKey(name: 'PaymentMethod')
  final String? paymentMethod;

  /// The name of the plan associated with this subscription
  @JsonKey(name: 'PlanName')
  final String? planName;

  /// Custom fields associated with this subscription
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this subscription instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);

  /// Creates a copy of this subscription with the given fields replaced with new values
  Subscription copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? billingRenewalTerm,
    Plan? plan,
    String? planUid,
    String? accountUid,
    String? personUid,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? cancelDate,
    DateTime? billingStart,
    DateTime? billingEnd,
    String? cancellationReason,
    int? quantity,
    double? amount,
    double? setupFee,
    double? discount,
    double? taxAmount,
    double? total,
    String? status,
    List<dynamic>? subscriptionAddOns,
    String? paymentMethod,
    String? planName,
    Map<String, dynamic>? customFields,
  }) {
    return Subscription(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      billingRenewalTerm: billingRenewalTerm ?? this.billingRenewalTerm,
      plan: plan ?? this.plan,
      planUid: planUid ?? this.planUid,
      accountUid: accountUid ?? this.accountUid,
      personUid: personUid ?? this.personUid,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      cancelDate: cancelDate ?? this.cancelDate,
      billingStart: billingStart ?? this.billingStart,
      billingEnd: billingEnd ?? this.billingEnd,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      quantity: quantity ?? this.quantity,
      amount: amount ?? this.amount,
      setupFee: setupFee ?? this.setupFee,
      discount: discount ?? this.discount,
      taxAmount: taxAmount ?? this.taxAmount,
      total: total ?? this.total,
      status: status ?? this.status,
      subscriptionAddOns: subscriptionAddOns ?? this.subscriptionAddOns,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      planName: planName ?? this.planName,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    billingRenewalTerm,
    plan,
    planUid,
    accountUid,
    personUid,
    startDate,
    endDate,
    cancelDate,
    billingStart,
    billingEnd,
    cancellationReason,
    quantity,
    amount,
    setupFee,
    discount,
    taxAmount,
    total,
    status,
    subscriptionAddOns,
    paymentMethod,
    planName,
    customFields,
  ];
}
