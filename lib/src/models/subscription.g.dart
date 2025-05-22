// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'Subscription',
      json,
      ($checkedConvert) {
        final val = Subscription(
          uid: $checkedConvert('Uid', (v) => v as String?),
          created: $checkedConvert(
            'Created',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          updated: $checkedConvert(
            'Updated',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          createdBy: $checkedConvert('CreatedBy', (v) => v as String?),
          updatedBy: $checkedConvert('UpdatedBy', (v) => v as String?),
          billingRenewalTerm: $checkedConvert(
            'BillingRenewalTerm',
            (v) => v as String?,
          ),
          plan: $checkedConvert(
            'Plan',
            (v) => v == null ? null : Plan.fromJson(v as Map<String, dynamic>),
          ),
          planUid: $checkedConvert('PlanUid', (v) => v as String?),
          accountUid: $checkedConvert('AccountUid', (v) => v as String?),
          personUid: $checkedConvert('PersonUid', (v) => v as String?),
          startDate: $checkedConvert(
            'StartDate',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          endDate: $checkedConvert(
            'EndDate',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          cancelDate: $checkedConvert(
            'CancelDate',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          billingStart: $checkedConvert(
            'BillingStart',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          billingEnd: $checkedConvert(
            'BillingEnd',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          cancellationReason: $checkedConvert(
            'CancellationReason',
            (v) => v as String?,
          ),
          quantity: $checkedConvert('Quantity', (v) => (v as num?)?.toInt()),
          amount: $checkedConvert('Amount', (v) => (v as num?)?.toDouble()),
          setupFee: $checkedConvert('SetupFee', (v) => (v as num?)?.toDouble()),
          discount: $checkedConvert('Discount', (v) => (v as num?)?.toDouble()),
          taxAmount: $checkedConvert(
            'TaxAmount',
            (v) => (v as num?)?.toDouble(),
          ),
          total: $checkedConvert('Total', (v) => (v as num?)?.toDouble()),
          status: $checkedConvert('Status', (v) => v as String?),
          subscriptionAddOns: $checkedConvert(
            'SubscriptionAddOns',
            (v) => v as List<dynamic>?,
          ),
          paymentMethod: $checkedConvert('PaymentMethod', (v) => v as String?),
          planName: $checkedConvert('PlanName', (v) => v as String?),
          customFields: $checkedConvert(
            'CustomFields',
            (v) => v as Map<String, dynamic>?,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'uid': 'Uid',
        'created': 'Created',
        'updated': 'Updated',
        'createdBy': 'CreatedBy',
        'updatedBy': 'UpdatedBy',
        'billingRenewalTerm': 'BillingRenewalTerm',
        'plan': 'Plan',
        'planUid': 'PlanUid',
        'accountUid': 'AccountUid',
        'personUid': 'PersonUid',
        'startDate': 'StartDate',
        'endDate': 'EndDate',
        'cancelDate': 'CancelDate',
        'billingStart': 'BillingStart',
        'billingEnd': 'BillingEnd',
        'cancellationReason': 'CancellationReason',
        'quantity': 'Quantity',
        'amount': 'Amount',
        'setupFee': 'SetupFee',
        'discount': 'Discount',
        'taxAmount': 'TaxAmount',
        'total': 'Total',
        'status': 'Status',
        'subscriptionAddOns': 'SubscriptionAddOns',
        'paymentMethod': 'PaymentMethod',
        'planName': 'PlanName',
        'customFields': 'CustomFields',
      },
    );

Map<String, dynamic> _$SubscriptionToJson(
  Subscription instance,
) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.billingRenewalTerm case final value?)
    'BillingRenewalTerm': value,
  if (instance.plan?.toJson() case final value?) 'Plan': value,
  if (instance.planUid case final value?) 'PlanUid': value,
  if (instance.accountUid case final value?) 'AccountUid': value,
  if (instance.personUid case final value?) 'PersonUid': value,
  if (instance.startDate?.toIso8601String() case final value?)
    'StartDate': value,
  if (instance.endDate?.toIso8601String() case final value?) 'EndDate': value,
  if (instance.cancelDate?.toIso8601String() case final value?)
    'CancelDate': value,
  if (instance.billingStart?.toIso8601String() case final value?)
    'BillingStart': value,
  if (instance.billingEnd?.toIso8601String() case final value?)
    'BillingEnd': value,
  if (instance.cancellationReason case final value?)
    'CancellationReason': value,
  if (instance.quantity case final value?) 'Quantity': value,
  if (instance.amount case final value?) 'Amount': value,
  if (instance.setupFee case final value?) 'SetupFee': value,
  if (instance.discount case final value?) 'Discount': value,
  if (instance.taxAmount case final value?) 'TaxAmount': value,
  if (instance.total case final value?) 'Total': value,
  if (instance.status case final value?) 'Status': value,
  if (instance.subscriptionAddOns case final value?)
    'SubscriptionAddOns': value,
  if (instance.paymentMethod case final value?) 'PaymentMethod': value,
  if (instance.planName case final value?) 'PlanName': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
