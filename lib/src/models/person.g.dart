// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Person',
  json,
  ($checkedConvert) {
    final val = Person(
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
      email: $checkedConvert('Email', (v) => v as String?),
      firstName: $checkedConvert('FirstName', (v) => v as String?),
      lastName: $checkedConvert('LastName', (v) => v as String?),
      fullName: $checkedConvert('FullName', (v) => v as String?),
      emailConfirmed: $checkedConvert('EmailConfirmed', (v) => v as bool?),
      isPrimaryContact: $checkedConvert('IsPrimaryContact', (v) => v as bool?),
      mailingAddress: $checkedConvert(
        'MailingAddress',
        (v) => v == null ? null : Address.fromJson(v as Map<String, dynamic>),
      ),
      title: $checkedConvert('Title', (v) => v as String?),
      phoneNumber: $checkedConvert('PhoneNumber', (v) => v as String?),
      personAccount: $checkedConvert('PersonAccount', (v) => v),
      accountUid: $checkedConvert('AccountUid', (v) => v as String?),
      subscriptionUid: $checkedConvert('SubscriptionUid', (v) => v as String?),
      demographicInfo: $checkedConvert('DemographicInfo', (v) => v),
      profileImageS3Key: $checkedConvert(
        'ProfileImageS3Key',
        (v) => v as String?,
      ),
      lastLoggedInDate: $checkedConvert(
        'LastLoggedInDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      password: $checkedConvert('Password', (v) => v as String?),
      confirmPassword: $checkedConvert('ConfirmPassword', (v) => v as String?),
      marketingConsent: $checkedConvert('MarketingConsent', (v) => v as bool?),
      billingInvoiceEmail: $checkedConvert(
        'BillingInvoiceEmail',
        (v) => v as bool?,
      ),
      communicationEmail: $checkedConvert(
        'CommunicationEmail',
        (v) => v as bool?,
      ),
      marketingEmail: $checkedConvert('MarketingEmail', (v) => v as bool?),
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
    'email': 'Email',
    'firstName': 'FirstName',
    'lastName': 'LastName',
    'fullName': 'FullName',
    'emailConfirmed': 'EmailConfirmed',
    'isPrimaryContact': 'IsPrimaryContact',
    'mailingAddress': 'MailingAddress',
    'title': 'Title',
    'phoneNumber': 'PhoneNumber',
    'personAccount': 'PersonAccount',
    'accountUid': 'AccountUid',
    'subscriptionUid': 'SubscriptionUid',
    'demographicInfo': 'DemographicInfo',
    'profileImageS3Key': 'ProfileImageS3Key',
    'lastLoggedInDate': 'LastLoggedInDate',
    'password': 'Password',
    'confirmPassword': 'ConfirmPassword',
    'marketingConsent': 'MarketingConsent',
    'billingInvoiceEmail': 'BillingInvoiceEmail',
    'communicationEmail': 'CommunicationEmail',
    'marketingEmail': 'MarketingEmail',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.email case final value?) 'Email': value,
  if (instance.firstName case final value?) 'FirstName': value,
  if (instance.lastName case final value?) 'LastName': value,
  if (instance.fullName case final value?) 'FullName': value,
  if (instance.emailConfirmed case final value?) 'EmailConfirmed': value,
  if (instance.isPrimaryContact case final value?) 'IsPrimaryContact': value,
  if (instance.mailingAddress?.toJson() case final value?)
    'MailingAddress': value,
  if (instance.title case final value?) 'Title': value,
  if (instance.phoneNumber case final value?) 'PhoneNumber': value,
  if (instance.personAccount case final value?) 'PersonAccount': value,
  if (instance.accountUid case final value?) 'AccountUid': value,
  if (instance.subscriptionUid case final value?) 'SubscriptionUid': value,
  if (instance.demographicInfo case final value?) 'DemographicInfo': value,
  if (instance.profileImageS3Key case final value?) 'ProfileImageS3Key': value,
  if (instance.lastLoggedInDate?.toIso8601String() case final value?)
    'LastLoggedInDate': value,
  if (instance.password case final value?) 'Password': value,
  if (instance.confirmPassword case final value?) 'ConfirmPassword': value,
  if (instance.marketingConsent case final value?) 'MarketingConsent': value,
  if (instance.billingInvoiceEmail case final value?)
    'BillingInvoiceEmail': value,
  if (instance.communicationEmail case final value?)
    'CommunicationEmail': value,
  if (instance.marketingEmail case final value?) 'MarketingEmail': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
