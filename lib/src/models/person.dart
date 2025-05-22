import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'address.dart';

part 'person.g.dart';

/// Person model representing a contact in the Outseta CRM
@JsonSerializable()
class Person extends BaseModelWithMetadata {
  /// Creates a new Person instance
  const Person({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.email,
    this.firstName,
    this.lastName,
    this.fullName,
    this.emailConfirmed,
    this.isPrimaryContact,
    this.mailingAddress,
    this.title,
    this.phoneNumber,
    this.personAccount,
    this.accountUid,
    this.subscriptionUid,
    this.demographicInfo,
    this.profileImageS3Key,
    this.lastLoggedInDate,
    this.password,
    this.confirmPassword,
    this.marketingConsent,
    this.billingInvoiceEmail,
    this.communicationEmail,
    this.marketingEmail,
    this.customFields,
  });

  /// Factory constructor that creates a [Person] from JSON data
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  /// The person's email address
  @JsonKey(name: 'Email')
  final String? email;

  /// The person's first name
  @JsonKey(name: 'FirstName')
  final String? firstName;

  /// The person's last name
  @JsonKey(name: 'LastName')
  final String? lastName;

  /// The person's full name (computed from first and last name)
  @JsonKey(name: 'FullName')
  final String? fullName;

  /// Whether the person's email has been confirmed
  @JsonKey(name: 'EmailConfirmed')
  final bool? emailConfirmed;

  /// Whether the person is the primary contact for their account
  @JsonKey(name: 'IsPrimaryContact')
  final bool? isPrimaryContact;

  /// The person's mailing address
  @JsonKey(name: 'MailingAddress')
  final Address? mailingAddress;

  /// The person's job title
  @JsonKey(name: 'Title')
  final String? title;

  /// The person's phone number
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;

  /// Account information associated with this person
  @JsonKey(name: 'PersonAccount')
  final dynamic personAccount;

  /// The UID of the account this person belongs to
  @JsonKey(name: 'AccountUid')
  final String? accountUid;

  /// The UID of the subscription this person belongs to
  @JsonKey(name: 'SubscriptionUid')
  final String? subscriptionUid;

  /// Demographic information about the person
  @JsonKey(name: 'DemographicInfo')
  final dynamic demographicInfo;

  /// The S3 key for the person's profile image
  @JsonKey(name: 'ProfileImageS3Key')
  final String? profileImageS3Key;

  /// The date and time the person last logged in
  @JsonKey(name: 'LastLoggedInDate')
  final DateTime? lastLoggedInDate;

  /// The person's password (write-only, used for creating/updating)
  @JsonKey(name: 'Password')
  final String? password;

  /// The person's password confirmation (write-only, used for creating/updating)
  @JsonKey(name: 'ConfirmPassword')
  final String? confirmPassword;

  /// Whether the person has consented to marketing communications
  @JsonKey(name: 'MarketingConsent')
  final bool? marketingConsent;

  /// Whether the person should receive billing invoice emails
  @JsonKey(name: 'BillingInvoiceEmail')
  final bool? billingInvoiceEmail;

  /// Whether the person should receive communication emails
  @JsonKey(name: 'CommunicationEmail')
  final bool? communicationEmail;

  /// Whether the person should receive marketing emails
  @JsonKey(name: 'MarketingEmail')
  final bool? marketingEmail;

  /// Custom fields associated with this person
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this person instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  /// Creates a copy of this person with the given fields replaced with new values
  Person copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? email,
    String? firstName,
    String? lastName,
    String? fullName,
    bool? emailConfirmed,
    bool? isPrimaryContact,
    Address? mailingAddress,
    String? title,
    String? phoneNumber,
    dynamic personAccount,
    String? accountUid,
    String? subscriptionUid,
    dynamic demographicInfo,
    String? profileImageS3Key,
    DateTime? lastLoggedInDate,
    String? password,
    String? confirmPassword,
    bool? marketingConsent,
    bool? billingInvoiceEmail,
    bool? communicationEmail,
    bool? marketingEmail,
    Map<String, dynamic>? customFields,
  }) {
    return Person(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      emailConfirmed: emailConfirmed ?? this.emailConfirmed,
      isPrimaryContact: isPrimaryContact ?? this.isPrimaryContact,
      mailingAddress: mailingAddress ?? this.mailingAddress,
      title: title ?? this.title,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      personAccount: personAccount ?? this.personAccount,
      accountUid: accountUid ?? this.accountUid,
      subscriptionUid: subscriptionUid ?? this.subscriptionUid,
      demographicInfo: demographicInfo ?? this.demographicInfo,
      profileImageS3Key: profileImageS3Key ?? this.profileImageS3Key,
      lastLoggedInDate: lastLoggedInDate ?? this.lastLoggedInDate,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      marketingConsent: marketingConsent ?? this.marketingConsent,
      billingInvoiceEmail: billingInvoiceEmail ?? this.billingInvoiceEmail,
      communicationEmail: communicationEmail ?? this.communicationEmail,
      marketingEmail: marketingEmail ?? this.marketingEmail,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    email,
    firstName,
    lastName,
    fullName,
    emailConfirmed,
    isPrimaryContact,
    mailingAddress,
    title,
    phoneNumber,
    personAccount,
    accountUid,
    subscriptionUid,
    demographicInfo,
    profileImageS3Key,
    lastLoggedInDate,
    password,
    confirmPassword,
    marketingConsent,
    billingInvoiceEmail,
    communicationEmail,
    marketingEmail,
    customFields,
  ];
}
