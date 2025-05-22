// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Account',
  json,
  ($checkedConvert) {
    final val = Account(
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
      billingAddress: $checkedConvert(
        'BillingAddress',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      mailingAddress: $checkedConvert(
        'MailingAddress',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      phoneNumber: $checkedConvert('PhoneNumber', (v) => v as String?),
      subscriptions: $checkedConvert(
        'Subscriptions',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Subscription.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      people: $checkedConvert(
        'People',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      primaryContact: $checkedConvert(
        'PrimaryContact',
        (v) => v == null ? null : Person.fromJson(v as Map<String, dynamic>),
      ),
      clientIdentifier: $checkedConvert(
        'ClientIdentifier',
        (v) => v as String?,
      ),
      dealUid: $checkedConvert('DealUid', (v) => v as String?),
      planUid: $checkedConvert('PlanUid', (v) => v as String?),
      cancellationReason: $checkedConvert(
        'CancellationReason',
        (v) => v as String?,
      ),
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
    'billingAddress': 'BillingAddress',
    'mailingAddress': 'MailingAddress',
    'phoneNumber': 'PhoneNumber',
    'subscriptions': 'Subscriptions',
    'people': 'People',
    'primaryContact': 'PrimaryContact',
    'clientIdentifier': 'ClientIdentifier',
    'dealUid': 'DealUid',
    'planUid': 'PlanUid',
    'cancellationReason': 'CancellationReason',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.name case final value?) 'Name': value,
  if (instance.billingAddress?.toJson() case final value?)
    'BillingAddress': value,
  if (instance.mailingAddress?.toJson() case final value?)
    'MailingAddress': value,
  if (instance.phoneNumber case final value?) 'PhoneNumber': value,
  if (instance.subscriptions?.map((e) => e.toJson()).toList() case final value?)
    'Subscriptions': value,
  if (instance.people?.map((e) => e.toJson()).toList() case final value?)
    'People': value,
  if (instance.primaryContact?.toJson() case final value?)
    'PrimaryContact': value,
  if (instance.clientIdentifier case final value?) 'ClientIdentifier': value,
  if (instance.dealUid case final value?) 'DealUid': value,
  if (instance.planUid case final value?) 'PlanUid': value,
  if (instance.cancellationReason case final value?)
    'CancellationReason': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
