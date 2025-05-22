// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'deal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deal _$DealFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Deal',
  json,
  ($checkedConvert) {
    final val = Deal(
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
      amount: $checkedConvert('Amount', (v) => (v as num?)?.toDouble()),
      stage: $checkedConvert('Stage', (v) => v as String?),
      stageUid: $checkedConvert('StageUid', (v) => v as String?),
      dealPipelineUid: $checkedConvert('DealPipelineUid', (v) => v as String?),
      accountUid: $checkedConvert('AccountUid', (v) => v as String?),
      account: $checkedConvert(
        'Account',
        (v) => v == null ? null : Account.fromJson(v as Map<String, dynamic>),
      ),
      personUid: $checkedConvert('PersonUid', (v) => v as String?),
      person: $checkedConvert(
        'Person',
        (v) => v == null ? null : Person.fromJson(v as Map<String, dynamic>),
      ),
      assignedToPersonUid: $checkedConvert(
        'AssignedToPersonUid',
        (v) => v as String?,
      ),
      assignedToPerson: $checkedConvert(
        'AssignedToPerson',
        (v) => v == null ? null : Person.fromJson(v as Map<String, dynamic>),
      ),
      closeDate: $checkedConvert(
        'CloseDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      dealLostReason: $checkedConvert('DealLostReason', (v) => v as String?),
      description: $checkedConvert('Description', (v) => v as String?),
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
    'amount': 'Amount',
    'stage': 'Stage',
    'stageUid': 'StageUid',
    'dealPipelineUid': 'DealPipelineUid',
    'accountUid': 'AccountUid',
    'account': 'Account',
    'personUid': 'PersonUid',
    'person': 'Person',
    'assignedToPersonUid': 'AssignedToPersonUid',
    'assignedToPerson': 'AssignedToPerson',
    'closeDate': 'CloseDate',
    'dealLostReason': 'DealLostReason',
    'description': 'Description',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$DealToJson(Deal instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.name case final value?) 'Name': value,
  if (instance.amount case final value?) 'Amount': value,
  if (instance.stage case final value?) 'Stage': value,
  if (instance.stageUid case final value?) 'StageUid': value,
  if (instance.dealPipelineUid case final value?) 'DealPipelineUid': value,
  if (instance.accountUid case final value?) 'AccountUid': value,
  if (instance.account?.toJson() case final value?) 'Account': value,
  if (instance.personUid case final value?) 'PersonUid': value,
  if (instance.person?.toJson() case final value?) 'Person': value,
  if (instance.assignedToPersonUid case final value?)
    'AssignedToPersonUid': value,
  if (instance.assignedToPerson?.toJson() case final value?)
    'AssignedToPerson': value,
  if (instance.closeDate?.toIso8601String() case final value?)
    'CloseDate': value,
  if (instance.dealLostReason case final value?) 'DealLostReason': value,
  if (instance.description case final value?) 'Description': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
