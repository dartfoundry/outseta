import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'address.dart';
import 'person.dart';
import 'subscription.dart';

part 'account.g.dart';

/// Account model representing a customer account in the Outseta CRM
@JsonSerializable()
class Account extends BaseModelWithMetadata {
  /// Creates a new Account instance
  const Account({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.name,
    this.billingAddress,
    this.mailingAddress,
    this.phoneNumber,
    this.subscriptions,
    this.people,
    this.primaryContact,
    this.clientIdentifier,
    this.dealUid,
    this.planUid,
    this.cancellationReason,
    this.customFields,
  });

  /// Factory constructor that creates an [Account] from JSON data
  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  /// The account name or company name
  @JsonKey(name: 'Name')
  final String? name;

  /// The billing address for the account
  @JsonKey(name: 'BillingAddress')
  final Address? billingAddress;

  /// The mailing address for the account
  @JsonKey(name: 'MailingAddress')
  final Address? mailingAddress;

  /// The phone number for the account
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;

  /// The subscriptions associated with this account
  @JsonKey(name: 'Subscriptions')
  final List<Subscription>? subscriptions;

  /// The people associated with this account
  @JsonKey(name: 'People')
  final List<Person>? people;

  /// The primary contact person for this account
  @JsonKey(name: 'PrimaryContact')
  final Person? primaryContact;

  /// The client identifier for this account
  @JsonKey(name: 'ClientIdentifier')
  final String? clientIdentifier;

  /// The UID of the deal associated with this account
  @JsonKey(name: 'DealUid')
  final String? dealUid;

  /// The UID of the plan associated with this account
  @JsonKey(name: 'PlanUid')
  final String? planUid;

  /// The reason for cancellation, if applicable
  @JsonKey(name: 'CancellationReason')
  final String? cancellationReason;

  /// Custom fields associated with this account
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this account instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  /// Creates a copy of this account with the given fields replaced with new values
  Account copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? name,
    Address? billingAddress,
    Address? mailingAddress,
    String? phoneNumber,
    List<Subscription>? subscriptions,
    List<Person>? people,
    Person? primaryContact,
    String? clientIdentifier,
    String? dealUid,
    String? planUid,
    String? cancellationReason,
    Map<String, dynamic>? customFields,
  }) {
    return Account(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      name: name ?? this.name,
      billingAddress: billingAddress ?? this.billingAddress,
      mailingAddress: mailingAddress ?? this.mailingAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subscriptions: subscriptions ?? this.subscriptions,
      people: people ?? this.people,
      primaryContact: primaryContact ?? this.primaryContact,
      clientIdentifier: clientIdentifier ?? this.clientIdentifier,
      dealUid: dealUid ?? this.dealUid,
      planUid: planUid ?? this.planUid,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        name,
        billingAddress,
        mailingAddress,
        phoneNumber,
        subscriptions,
        people,
        primaryContact,
        clientIdentifier,
        dealUid,
        planUid,
        cancellationReason,
        customFields,
      ];
}