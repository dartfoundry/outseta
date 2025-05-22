// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Email',
  json,
  ($checkedConvert) {
    final val = Email(
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
      subject: $checkedConvert('Subject', (v) => v as String?),
      fromName: $checkedConvert('FromName', (v) => v as String?),
      fromEmail: $checkedConvert('FromEmail', (v) => v as String?),
      replyToEmail: $checkedConvert('ReplyToEmail', (v) => v as String?),
      content: $checkedConvert('Content', (v) => v as String?),
      status: $checkedConvert('Status', (v) => v as String?),
      scheduledDate: $checkedConvert(
        'ScheduledDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      sentDate: $checkedConvert(
        'SentDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      openCount: $checkedConvert('OpenCount', (v) => (v as num?)?.toInt()),
      clickCount: $checkedConvert('ClickCount', (v) => (v as num?)?.toInt()),
      emailListUid: $checkedConvert('EmailListUid', (v) => v as String?),
      emailList: $checkedConvert(
        'EmailList',
        (v) => v == null ? null : EmailList.fromJson(v as Map<String, dynamic>),
      ),
      personSegmentUid: $checkedConvert(
        'PersonSegmentUid',
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
    'subject': 'Subject',
    'fromName': 'FromName',
    'fromEmail': 'FromEmail',
    'replyToEmail': 'ReplyToEmail',
    'content': 'Content',
    'status': 'Status',
    'scheduledDate': 'ScheduledDate',
    'sentDate': 'SentDate',
    'openCount': 'OpenCount',
    'clickCount': 'ClickCount',
    'emailListUid': 'EmailListUid',
    'emailList': 'EmailList',
    'personSegmentUid': 'PersonSegmentUid',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.subject case final value?) 'Subject': value,
  if (instance.fromName case final value?) 'FromName': value,
  if (instance.fromEmail case final value?) 'FromEmail': value,
  if (instance.replyToEmail case final value?) 'ReplyToEmail': value,
  if (instance.content case final value?) 'Content': value,
  if (instance.status case final value?) 'Status': value,
  if (instance.scheduledDate?.toIso8601String() case final value?)
    'ScheduledDate': value,
  if (instance.sentDate?.toIso8601String() case final value?) 'SentDate': value,
  if (instance.openCount case final value?) 'OpenCount': value,
  if (instance.clickCount case final value?) 'ClickCount': value,
  if (instance.emailListUid case final value?) 'EmailListUid': value,
  if (instance.emailList?.toJson() case final value?) 'EmailList': value,
  if (instance.personSegmentUid case final value?) 'PersonSegmentUid': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
