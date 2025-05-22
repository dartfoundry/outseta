// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payment _$PaymentFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Payment',
  json,
  ($checkedConvert) {
    final val = Payment(
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
      accountUid: $checkedConvert('AccountUid', (v) => v as String?),
      account: $checkedConvert(
        'Account',
        (v) => v == null ? null : Account.fromJson(v as Map<String, dynamic>),
      ),
      amount: $checkedConvert('Amount', (v) => (v as num?)?.toDouble()),
      paymentDate: $checkedConvert(
        'PaymentDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      paymentMethod: $checkedConvert('PaymentMethod', (v) => v as String?),
      stripePaymentId: $checkedConvert('StripePaymentId', (v) => v as String?),
      stripeRefundId: $checkedConvert('StripeRefundId', (v) => v as String?),
      refundAmount: $checkedConvert(
        'RefundAmount',
        (v) => (v as num?)?.toDouble(),
      ),
      refundDate: $checkedConvert(
        'RefundDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      status: $checkedConvert('Status', (v) => v as String?),
      invoiceUid: $checkedConvert('InvoiceUid', (v) => v as String?),
      invoice: $checkedConvert(
        'Invoice',
        (v) => v == null ? null : Invoice.fromJson(v as Map<String, dynamic>),
      ),
      note: $checkedConvert('Note', (v) => v as String?),
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
    'accountUid': 'AccountUid',
    'account': 'Account',
    'amount': 'Amount',
    'paymentDate': 'PaymentDate',
    'paymentMethod': 'PaymentMethod',
    'stripePaymentId': 'StripePaymentId',
    'stripeRefundId': 'StripeRefundId',
    'refundAmount': 'RefundAmount',
    'refundDate': 'RefundDate',
    'status': 'Status',
    'invoiceUid': 'InvoiceUid',
    'invoice': 'Invoice',
    'note': 'Note',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.accountUid case final value?) 'AccountUid': value,
  if (instance.account?.toJson() case final value?) 'Account': value,
  if (instance.amount case final value?) 'Amount': value,
  if (instance.paymentDate?.toIso8601String() case final value?)
    'PaymentDate': value,
  if (instance.paymentMethod case final value?) 'PaymentMethod': value,
  if (instance.stripePaymentId case final value?) 'StripePaymentId': value,
  if (instance.stripeRefundId case final value?) 'StripeRefundId': value,
  if (instance.refundAmount case final value?) 'RefundAmount': value,
  if (instance.refundDate?.toIso8601String() case final value?)
    'RefundDate': value,
  if (instance.status case final value?) 'Status': value,
  if (instance.invoiceUid case final value?) 'InvoiceUid': value,
  if (instance.invoice?.toJson() case final value?) 'Invoice': value,
  if (instance.note case final value?) 'Note': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
