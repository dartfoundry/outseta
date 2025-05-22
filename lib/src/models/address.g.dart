// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Address',
  json,
  ($checkedConvert) {
    final val = Address(
      uid: $checkedConvert('Uid', (v) => v as String?),
      addressLine1: $checkedConvert('AddressLine1', (v) => v as String?),
      addressLine2: $checkedConvert('AddressLine2', (v) => v as String?),
      addressLine3: $checkedConvert('AddressLine3', (v) => v as String?),
      city: $checkedConvert('City', (v) => v as String?),
      state: $checkedConvert('State', (v) => v as String?),
      postalCode: $checkedConvert('PostalCode', (v) => v as String?),
      country: $checkedConvert('Country', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'uid': 'Uid',
    'addressLine1': 'AddressLine1',
    'addressLine2': 'AddressLine2',
    'addressLine3': 'AddressLine3',
    'city': 'City',
    'state': 'State',
    'postalCode': 'PostalCode',
    'country': 'Country',
  },
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.addressLine1 case final value?) 'AddressLine1': value,
  if (instance.addressLine2 case final value?) 'AddressLine2': value,
  if (instance.addressLine3 case final value?) 'AddressLine3': value,
  if (instance.city case final value?) 'City': value,
  if (instance.state case final value?) 'State': value,
  if (instance.postalCode case final value?) 'PostalCode': value,
  if (instance.country case final value?) 'Country': value,
};
