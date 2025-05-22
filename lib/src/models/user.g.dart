// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => $checkedCreate(
  'User',
  json,
  ($checkedConvert) {
    final val = User(
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
      username: $checkedConvert('Username', (v) => v as String?),
      email: $checkedConvert('Email', (v) => v as String?),
      emailConfirmed: $checkedConvert('EmailConfirmed', (v) => v as bool?),
      firstName: $checkedConvert('FirstName', (v) => v as String?),
      lastName: $checkedConvert('LastName', (v) => v as String?),
      phoneNumber: $checkedConvert('PhoneNumber', (v) => v as String?),
      personUid: $checkedConvert('PersonUid', (v) => v as String?),
      person: $checkedConvert(
        'Person',
        (v) => v == null ? null : Person.fromJson(v as Map<String, dynamic>),
      ),
      profileImageS3Key: $checkedConvert(
        'ProfileImageS3Key',
        (v) => v as String?,
      ),
      lastLoggedInDate: $checkedConvert(
        'LastLoggedInDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      isAdmin: $checkedConvert('IsAdmin', (v) => v as bool?),
      password: $checkedConvert('Password', (v) => v as String?),
      confirmPassword: $checkedConvert('ConfirmPassword', (v) => v as String?),
      marketingConsent: $checkedConvert('MarketingConsent', (v) => v as bool?),
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
    'username': 'Username',
    'email': 'Email',
    'emailConfirmed': 'EmailConfirmed',
    'firstName': 'FirstName',
    'lastName': 'LastName',
    'phoneNumber': 'PhoneNumber',
    'personUid': 'PersonUid',
    'person': 'Person',
    'profileImageS3Key': 'ProfileImageS3Key',
    'lastLoggedInDate': 'LastLoggedInDate',
    'isAdmin': 'IsAdmin',
    'password': 'Password',
    'confirmPassword': 'ConfirmPassword',
    'marketingConsent': 'MarketingConsent',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.username case final value?) 'Username': value,
  if (instance.email case final value?) 'Email': value,
  if (instance.emailConfirmed case final value?) 'EmailConfirmed': value,
  if (instance.firstName case final value?) 'FirstName': value,
  if (instance.lastName case final value?) 'LastName': value,
  if (instance.phoneNumber case final value?) 'PhoneNumber': value,
  if (instance.personUid case final value?) 'PersonUid': value,
  if (instance.person?.toJson() case final value?) 'Person': value,
  if (instance.profileImageS3Key case final value?) 'ProfileImageS3Key': value,
  if (instance.lastLoggedInDate?.toIso8601String() case final value?)
    'LastLoggedInDate': value,
  if (instance.isAdmin case final value?) 'IsAdmin': value,
  if (instance.password case final value?) 'Password': value,
  if (instance.confirmPassword case final value?) 'ConfirmPassword': value,
  if (instance.marketingConsent case final value?) 'MarketingConsent': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
