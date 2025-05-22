// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plan _$PlanFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Plan',
  json,
  ($checkedConvert) {
    final val = Plan(
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
      name: $checkedConvert('Name', (v) => v as String?),
      description: $checkedConvert('Description', (v) => v as String?),
      billingTerm: $checkedConvert('BillingTerm', (v) => v as String?),
      billingTermCount: $checkedConvert(
        'BillingTermCount',
        (v) => (v as num?)?.toInt(),
      ),
      amount: $checkedConvert('Amount', (v) => (v as num?)?.toDouble()),
      setupFee: $checkedConvert('SetupFee', (v) => (v as num?)?.toDouble()),
      trialPeriodDays: $checkedConvert(
        'TrialPeriodDays',
        (v) => (v as num?)?.toInt(),
      ),
      isActive: $checkedConvert('IsActive', (v) => v as bool?),
      isFree: $checkedConvert('IsFree', (v) => v as bool?),
      recurringChargeAgreementRequired: $checkedConvert(
        'RecurringChargeAgreementRequired',
        (v) => v as bool?,
      ),
      planAddOns: $checkedConvert('PlanAddOns', (v) => v as List<dynamic>?),
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
    'name': 'Name',
    'description': 'Description',
    'billingTerm': 'BillingTerm',
    'billingTermCount': 'BillingTermCount',
    'amount': 'Amount',
    'setupFee': 'SetupFee',
    'trialPeriodDays': 'TrialPeriodDays',
    'isActive': 'IsActive',
    'isFree': 'IsFree',
    'recurringChargeAgreementRequired': 'RecurringChargeAgreementRequired',
    'planAddOns': 'PlanAddOns',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$PlanToJson(Plan instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.name case final value?) 'Name': value,
  if (instance.description case final value?) 'Description': value,
  if (instance.billingTerm case final value?) 'BillingTerm': value,
  if (instance.billingTermCount case final value?) 'BillingTermCount': value,
  if (instance.amount case final value?) 'Amount': value,
  if (instance.setupFee case final value?) 'SetupFee': value,
  if (instance.trialPeriodDays case final value?) 'TrialPeriodDays': value,
  if (instance.isActive case final value?) 'IsActive': value,
  if (instance.isFree case final value?) 'IsFree': value,
  if (instance.recurringChargeAgreementRequired case final value?)
    'RecurringChargeAgreementRequired': value,
  if (instance.planAddOns case final value?) 'PlanAddOns': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
