import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'address.g.dart';

/// Address model representing a physical address in the Outseta API
@JsonSerializable()
class Address extends BaseModel {
  /// Creates a new Address instance
  const Address({
    super.uid,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.city,
    this.state,
    this.postalCode,
    this.country,
  });

  /// Factory constructor that creates an [Address] from JSON data
  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  /// The first line of the address
  @JsonKey(name: 'AddressLine1')
  final String? addressLine1;

  /// The second line of the address
  @JsonKey(name: 'AddressLine2')
  final String? addressLine2;

  /// The third line of the address
  @JsonKey(name: 'AddressLine3')
  final String? addressLine3;

  /// The city
  @JsonKey(name: 'City')
  final String? city;

  /// The state or province
  @JsonKey(name: 'State')
  final String? state;

  /// The postal or ZIP code
  @JsonKey(name: 'PostalCode')
  final String? postalCode;

  /// The country
  @JsonKey(name: 'Country')
  final String? country;

  /// Converts this address instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  /// Creates a copy of this address with the given fields replaced with new values
  Address copyWith({
    String? uid,
    String? addressLine1,
    String? addressLine2,
    String? addressLine3,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    return Address(
      uid: uid ?? this.uid,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      addressLine3: addressLine3 ?? this.addressLine3,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    addressLine1,
    addressLine2,
    addressLine3,
    city,
    state,
    postalCode,
    country,
  ];
}
