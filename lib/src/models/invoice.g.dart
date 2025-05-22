// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_this, sort_constructors_first, prefer_single_quotes, lines_longer_than_80_chars

part of 'invoice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invoice _$InvoiceFromJson(Map<String, dynamic> json) => $checkedCreate(
  'Invoice',
  json,
  ($checkedConvert) {
    final val = Invoice(
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
      invoiceNumber: $checkedConvert('InvoiceNumber', (v) => v as String?),
      accountUid: $checkedConvert('AccountUid', (v) => v as String?),
      account: $checkedConvert(
        'Account',
        (v) => v == null ? null : Account.fromJson(v as Map<String, dynamic>),
      ),
      dueDate: $checkedConvert(
        'DueDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      amount: $checkedConvert('Amount', (v) => (v as num?)?.toDouble()),
      taxAmount: $checkedConvert('TaxAmount', (v) => (v as num?)?.toDouble()),
      discount: $checkedConvert('Discount', (v) => (v as num?)?.toDouble()),
      total: $checkedConvert('Total', (v) => (v as num?)?.toDouble()),
      billingPeriodStart: $checkedConvert(
        'BillingPeriodStart',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      billingPeriodEnd: $checkedConvert(
        'BillingPeriodEnd',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      paidDate: $checkedConvert(
        'PaidDate',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      paymentMethodUid: $checkedConvert(
        'PaymentMethodUid',
        (v) => v as String?,
      ),
      status: $checkedConvert('Status', (v) => v as String?),
      invoiceItems: $checkedConvert('InvoiceItems', (v) => v as List<dynamic>?),
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
    'invoiceNumber': 'InvoiceNumber',
    'accountUid': 'AccountUid',
    'account': 'Account',
    'dueDate': 'DueDate',
    'amount': 'Amount',
    'taxAmount': 'TaxAmount',
    'discount': 'Discount',
    'total': 'Total',
    'billingPeriodStart': 'BillingPeriodStart',
    'billingPeriodEnd': 'BillingPeriodEnd',
    'paidDate': 'PaidDate',
    'paymentMethodUid': 'PaymentMethodUid',
    'status': 'Status',
    'invoiceItems': 'InvoiceItems',
    'customFields': 'CustomFields',
  },
);

Map<String, dynamic> _$InvoiceToJson(Invoice instance) => <String, dynamic>{
  if (instance.uid case final value?) 'Uid': value,
  if (instance.created?.toIso8601String() case final value?) 'Created': value,
  if (instance.updated?.toIso8601String() case final value?) 'Updated': value,
  if (instance.createdBy case final value?) 'CreatedBy': value,
  if (instance.updatedBy case final value?) 'UpdatedBy': value,
  if (instance.invoiceNumber case final value?) 'InvoiceNumber': value,
  if (instance.accountUid case final value?) 'AccountUid': value,
  if (instance.account?.toJson() case final value?) 'Account': value,
  if (instance.dueDate?.toIso8601String() case final value?) 'DueDate': value,
  if (instance.amount case final value?) 'Amount': value,
  if (instance.taxAmount case final value?) 'TaxAmount': value,
  if (instance.discount case final value?) 'Discount': value,
  if (instance.total case final value?) 'Total': value,
  if (instance.billingPeriodStart?.toIso8601String() case final value?)
    'BillingPeriodStart': value,
  if (instance.billingPeriodEnd?.toIso8601String() case final value?)
    'BillingPeriodEnd': value,
  if (instance.paidDate?.toIso8601String() case final value?) 'PaidDate': value,
  if (instance.paymentMethodUid case final value?) 'PaymentMethodUid': value,
  if (instance.status case final value?) 'Status': value,
  if (instance.invoiceItems case final value?) 'InvoiceItems': value,
  if (instance.customFields case final value?) 'CustomFields': value,
};
