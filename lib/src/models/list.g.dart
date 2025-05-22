// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmailList _$EmailListFromJson(Map<String, dynamic> json) => $checkedCreate(
  'EmailList',
  json,
  ($checkedConvert) {
    final val = EmailList(
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
      subscriberCount: $checkedConvert(
        'SubscriberCount',
        (v) => (v as num?)?.toInt(),
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
    'description': 'Description',
    'subscriberCount': 'SubscriberCount',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$EmailListToJson(EmailList instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.name case final value?) 'Name': value,
  if (instance.description case final value?) 'Description': value,
  if (instance.subscriberCount case final value?) 'SubscriberCount': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
