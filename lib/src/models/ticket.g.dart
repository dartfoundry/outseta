// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Ticket',
  json,
  ($checkedConvert) {
    final val = Ticket(
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
      description: $checkedConvert('Description', (v) => v as String?),
      status: $checkedConvert('Status', (v) => v as String?),
      priority: $checkedConvert('Priority', (v) => v as String?),
      requesterPersonUid: $checkedConvert(
        'RequesterPersonUid',
        (v) => v as String?,
      ),
      requesterPerson: $checkedConvert(
        'RequesterPerson',
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
      comments: $checkedConvert('Comments', (v) => v as List<dynamic>?),
      accountUid: $checkedConvert('AccountUid', (v) => v as String?),
      source: $checkedConvert('Source', (v) => v as String?),
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
    'description': 'Description',
    'status': 'Status',
    'priority': 'Priority',
    'requesterPersonUid': 'RequesterPersonUid',
    'requesterPerson': 'RequesterPerson',
    'assignedToPersonUid': 'AssignedToPersonUid',
    'assignedToPerson': 'AssignedToPerson',
    'comments': 'Comments',
    'accountUid': 'AccountUid',
    'source': 'Source',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.subject case final value?) 'Subject': value,
  if (instance.description case final value?) 'Description': value,
  if (instance.status case final value?) 'Status': value,
  if (instance.priority case final value?) 'Priority': value,
  if (instance.requesterPersonUid case final value?)
    'RequesterPersonUid': value,
  if (instance.requesterPerson?.toJson() case final value?)
    'RequesterPerson': value,
  if (instance.assignedToPersonUid case final value?)
    'AssignedToPersonUid': value,
  if (instance.assignedToPerson?.toJson() case final value?)
    'AssignedToPerson': value,
  if (instance.comments case final value?) 'Comments': value,
  if (instance.accountUid case final value?) 'AccountUid': value,
  if (instance.source case final value?) 'Source': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
