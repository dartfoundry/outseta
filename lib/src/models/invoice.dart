import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'account.dart';

part 'invoice.g.dart';

/// Invoice model representing a billing invoice in the Outseta API
@JsonSerializable()
class Invoice extends BaseModelWithMetadata {
  /// Creates a new Invoice instance
  const Invoice({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.invoiceNumber,
    this.accountUid,
    this.account,
    this.dueDate,
    this.amount,
    this.taxAmount,
    this.discount,
    this.total,
    this.billingPeriodStart,
    this.billingPeriodEnd,
    this.paidDate,
    this.paymentMethodUid,
    this.status,
    this.invoiceItems,
    this.customFields,
  });

  /// Factory constructor that creates an [Invoice] from JSON data
  factory Invoice.fromJson(Map<String, dynamic> json) => _$InvoiceFromJson(json);

  /// The invoice number
  @JsonKey(name: 'InvoiceNumber')
  final String? invoiceNumber;

  /// The UID of the account associated with this invoice
  @JsonKey(name: 'AccountUid')
  final String? accountUid;

  /// The account associated with this invoice
  @JsonKey(name: 'Account')
  final Account? account;

  /// The due date of the invoice
  @JsonKey(name: 'DueDate')
  final DateTime? dueDate;

  /// The base amount of the invoice
  @JsonKey(name: 'Amount')
  final double? amount;

  /// The tax amount of the invoice
  @JsonKey(name: 'TaxAmount')
  final double? taxAmount;

  /// The discount amount of the invoice
  @JsonKey(name: 'Discount')
  final double? discount;

  /// The total amount of the invoice
  @JsonKey(name: 'Total')
  final double? total;

  /// The start date of the billing period
  @JsonKey(name: 'BillingPeriodStart')
  final DateTime? billingPeriodStart;

  /// The end date of the billing period
  @JsonKey(name: 'BillingPeriodEnd')
  final DateTime? billingPeriodEnd;

  /// The date the invoice was paid
  @JsonKey(name: 'PaidDate')
  final DateTime? paidDate;

  /// The UID of the payment method used
  @JsonKey(name: 'PaymentMethodUid')
  final String? paymentMethodUid;

  /// The status of the invoice (e.g., 'Paid', 'Unpaid', 'Void')
  @JsonKey(name: 'Status')
  final String? status;

  /// The items on the invoice
  @JsonKey(name: 'InvoiceItems')
  final List<dynamic>? invoiceItems;

  /// Custom fields associated with this invoice
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this invoice instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$InvoiceToJson(this);

  /// Creates a copy of this invoice with the given fields replaced with new values
  Invoice copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? invoiceNumber,
    String? accountUid,
    Account? account,
    DateTime? dueDate,
    double? amount,
    double? taxAmount,
    double? discount,
    double? total,
    DateTime? billingPeriodStart,
    DateTime? billingPeriodEnd,
    DateTime? paidDate,
    String? paymentMethodUid,
    String? status,
    List<dynamic>? invoiceItems,
    Map<String, dynamic>? customFields,
  }) {
    return Invoice(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      accountUid: accountUid ?? this.accountUid,
      account: account ?? this.account,
      dueDate: dueDate ?? this.dueDate,
      amount: amount ?? this.amount,
      taxAmount: taxAmount ?? this.taxAmount,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      billingPeriodStart: billingPeriodStart ?? this.billingPeriodStart,
      billingPeriodEnd: billingPeriodEnd ?? this.billingPeriodEnd,
      paidDate: paidDate ?? this.paidDate,
      paymentMethodUid: paymentMethodUid ?? this.paymentMethodUid,
      status: status ?? this.status,
      invoiceItems: invoiceItems ?? this.invoiceItems,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        invoiceNumber,
        accountUid,
        account,
        dueDate,
        amount,
        taxAmount,
        discount,
        total,
        billingPeriodStart,
        billingPeriodEnd,
        paidDate,
        paymentMethodUid,
        status,
        invoiceItems,
        customFields,
      ];
}