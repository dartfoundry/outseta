import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'person.dart';

part 'user.g.dart';

/// User model representing a user profile in the Outseta API
@JsonSerializable()
class User extends BaseModelWithMetadata {
  /// Creates a new User instance
  const User({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.username,
    this.email,
    this.emailConfirmed,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.personUid,
    this.person,
    this.profileImageS3Key,
    this.lastLoggedInDate,
    this.isAdmin,
    this.password,
    this.confirmPassword,
    this.marketingConsent,
    this.customFields,
  });

  /// Factory constructor that creates a [User] from JSON data
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// The username of the user
  @JsonKey(name: 'Username')
  final String? username;

  /// The email address of the user
  @JsonKey(name: 'Email')
  final String? email;

  /// Whether the user's email has been confirmed
  @JsonKey(name: 'EmailConfirmed')
  final bool? emailConfirmed;

  /// The first name of the user
  @JsonKey(name: 'FirstName')
  final String? firstName;

  /// The last name of the user
  @JsonKey(name: 'LastName')
  final String? lastName;

  /// The phone number of the user
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;

  /// The UID of the person associated with this user
  @JsonKey(name: 'PersonUid')
  final String? personUid;

  /// The person associated with this user
  @JsonKey(name: 'Person')
  final Person? person;

  /// The S3 key for the user's profile image
  @JsonKey(name: 'ProfileImageS3Key')
  final String? profileImageS3Key;

  /// The date and time the user last logged in
  @JsonKey(name: 'LastLoggedInDate')
  final DateTime? lastLoggedInDate;

  /// Whether the user is an admin
  @JsonKey(name: 'IsAdmin')
  final bool? isAdmin;

  /// The user's password (write-only, used for creating/updating)
  @JsonKey(name: 'Password')
  final String? password;

  /// The user's password confirmation (write-only, used for creating/updating)
  @JsonKey(name: 'ConfirmPassword')
  final String? confirmPassword;

  /// Whether the user has consented to marketing communications
  @JsonKey(name: 'MarketingConsent')
  final bool? marketingConsent;

  /// Custom fields associated with this user
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this user instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Creates a copy of this user with the given fields replaced with new values
  User copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? username,
    String? email,
    bool? emailConfirmed,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? personUid,
    Person? person,
    String? profileImageS3Key,
    DateTime? lastLoggedInDate,
    bool? isAdmin,
    String? password,
    String? confirmPassword,
    bool? marketingConsent,
    Map<String, dynamic>? customFields,
  }) {
    return User(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      username: username ?? this.username,
      email: email ?? this.email,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      personUid: personUid ?? this.personUid,
      person: person ?? this.person,
      profileImageS3Key: profileImageS3Key ?? this.profileImageS3Key,
      lastLoggedInDate: lastLoggedInDate ?? this.lastLoggedInDate,
      isAdmin: isAdmin ?? this.isAdmin,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      marketingConsent: marketingConsent ?? this.marketingConsent,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        username,
        email,
        emailConfirmed,
        firstName,
        lastName,
        phoneNumber,
        personUid,
        person,
        profileImageS3Key,
        lastLoggedInDate,
        isAdmin,
        password,
        confirmPassword,
        marketingConsent,
        customFields,
      ];
}