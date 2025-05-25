import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';
import 'account.dart';
import 'invoice.dart';

part 'payment.g.dart';

/// Payment model representing a payment transaction in the Outseta API
@JsonSerializable()
class Payment extends BaseModelWithMetadata {
  /// Creates a new Payment instance
  const Payment({
    super.uid,
    super.created,
    super.updated,
    super.createdBy,
    super.updatedBy,
    this.accountUid,
    this.account,
    this.amount,
    this.paymentDate,
    this.paymentMethod,
    this.stripePaymentId,
    this.stripeRefundId,
    this.refundAmount,
    this.refundDate,
    this.status,
    this.invoiceUid,
    this.invoice,
    this.note,
    this.customFields,
  });

  /// Factory constructor that creates a [Payment] from JSON data
  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  /// The UID of the account associated with this payment
  @JsonKey(name: 'AccountUid')
  final String? accountUid;

  /// The account associated with this payment
  @JsonKey(name: 'Account')
  final Account? account;

  /// The amount of the payment
  @JsonKey(name: 'Amount')
  final double? amount;

  /// The date the payment was made
  @JsonKey(name: 'PaymentDate')
  final DateTime? paymentDate;

  /// The payment method used (e.g., 'CreditCard', 'Check', 'Cash')
  @JsonKey(name: 'PaymentMethod')
  final String? paymentMethod;

  /// The Stripe payment ID, if applicable
  @JsonKey(name: 'StripePaymentId')
  final String? stripePaymentId;

  /// The Stripe refund ID, if applicable
  @JsonKey(name: 'StripeRefundId')
  final String? stripeRefundId;

  /// The refund amount, if applicable
  @JsonKey(name: 'RefundAmount')
  final double? refundAmount;

  /// The date the payment was refunded, if applicable
  @JsonKey(name: 'RefundDate')
  final DateTime? refundDate;

  /// The status of the payment (e.g., 'Completed', 'Refunded', 'Failed')
  @JsonKey(name: 'Status')
  final String? status;

  /// The UID of the invoice associated with this payment
  @JsonKey(name: 'InvoiceUid')
  final String? invoiceUid;

  /// The invoice associated with this payment
  @JsonKey(name: 'Invoice')
  final Invoice? invoice;

  /// A note associated with the payment
  @JsonKey(name: 'Note')
  final String? note;

  /// Custom fields associated with this payment
  @JsonKey(name: 'CustomFields')
  final Map<String, dynamic>? customFields;

  /// Converts this payment instance to a JSON map
  @override
  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  /// Creates a copy of this payment with the given fields replaced with new values
  Payment copyWith({
    String? uid,
    DateTime? created,
    DateTime? updated,
    String? createdBy,
    String? updatedBy,
    String? accountUid,
    Account? account,
    double? amount,
    DateTime? paymentDate,
    String? paymentMethod,
    String? stripePaymentId,
    String? stripeRefundId,
    double? refundAmount,
    DateTime? refundDate,
    String? status,
    String? invoiceUid,
    Invoice? invoice,
    String? note,
    Map<String, dynamic>? customFields,
  }) {
    return Payment(
      uid: uid ?? this.uid,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      createdBy: createdBy ?? this.createdBy,
      updatedBy: updatedBy ?? this.updatedBy,
      accountUid: accountUid ?? this.accountUid,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      stripePaymentId: stripePaymentId ?? this.stripePaymentId,
      stripeRefundId: stripeRefundId ?? this.stripeRefundId,
      refundAmount: refundAmount ?? this.refundAmount,
      refundDate: refundDate ?? this.refundDate,
      status: status ?? this.status,
      invoiceUid: invoiceUid ?? this.invoiceUid,
      invoice: invoice ?? this.invoice,
      note: note ?? this.note,
      customFields: customFields ?? this.customFields,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    accountUid,
    account,
    amount,
    paymentDate,
    paymentMethod,
    stripePaymentId,
    stripeRefundId,
    refundAmount,
    refundDate,
    status,
    invoiceUid,
    invoice,
    note,
    customFields,
  ];
}
