import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Payment', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'pay-123',
        'InvoiceUid': 'inv-456',
        'AccountUid': 'account-789',
        'Amount': 99.99,
        'PaymentDate': '2023-01-15T00:00:00Z',
        'PaymentMethod': 'CreditCard',
        'Status': 'Completed',
        'RefundAmount': 0.0,
        'RefundDate': null,
        'StripePaymentId': 'pi_123456789',
        'Created': '2023-01-15T00:00:00Z',
        'Updated': '2023-01-15T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'Invoice': {'Uid': 'inv-456', 'InvoiceNumber': 'INV-456'},
        'Account': {'Uid': 'account-789', 'Name': 'Test Company'},
      };

      // Act
      final payment = Payment.fromJson(json);

      // Assert
      expect(payment.uid, equals('pay-123'));
      expect(payment.invoiceUid, equals('inv-456'));
      expect(payment.accountUid, equals('account-789'));
      expect(payment.amount, equals(99.99));
      expect(payment.paymentDate, isA<DateTime>());
      expect(payment.paymentMethod, equals('CreditCard'));
      expect(payment.status, equals('Completed'));
      expect(payment.refundAmount, equals(0.0)); // Already set in constructor
      expect(payment.refundDate, isNull);
      expect(payment.stripePaymentId, equals('pi_123456789'));
      expect(payment.created, isA<DateTime>());
      expect(payment.updated, isA<DateTime>());
      expect(payment.createdBy, equals('admin'));
      expect(payment.updatedBy, equals('admin'));
      expect(payment.invoice, isNotNull);
      expect(payment.account, isNotNull);
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final payment = Payment(
        uid: 'pay-123',
        invoiceUid: 'inv-456',
        accountUid: 'account-789',
        amount: 99.99,
        paymentDate: DateTime.parse('2023-01-15T00:00:00Z'),
        paymentMethod: 'CreditCard',
        status: 'Completed',
        refundAmount: 0.0,
        stripePaymentId: 'pi_123456789',
        created: DateTime.parse('2023-01-15T00:00:00Z'),
        updated: DateTime.parse('2023-01-15T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
      );

      // Act
      final json = payment.toJson();

      // Assert
      expect(json['Uid'], equals('pay-123'));
      expect(json['InvoiceUid'], equals('inv-456'));
      expect(json['AccountUid'], equals('account-789'));
      expect(json['Amount'], equals(99.99));
      expect(json['PaymentDate'], isA<String>());
      expect(json['PaymentMethod'], equals('CreditCard'));
      expect(json['Status'], equals('Completed'));
      expect(json['RefundAmount'], equals(0.0));
      expect(json['StripePaymentId'], equals('pi_123456789'));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final payment = Payment(
        uid: 'pay-123',
        invoiceUid: 'inv-456',
        amount: 99.99,
        status: 'Completed',
        refundAmount: 0.0,
      );

      // Act
      final updatedPayment = payment.copyWith(
        status: 'Refunded',
        refundAmount: 99.99,
        refundDate: DateTime.parse('2023-01-20T00:00:00Z'),
      );

      // Assert
      expect(updatedPayment.uid, equals('pay-123')); // Unchanged
      expect(updatedPayment.invoiceUid, equals('inv-456')); // Unchanged
      expect(updatedPayment.amount, equals(99.99)); // Unchanged
      expect(updatedPayment.status, equals('Refunded')); // Changed
      expect(updatedPayment.refundAmount, equals(99.99)); // Added
      expect(updatedPayment.refundDate, isA<DateTime>()); // Added

      // Verify original is unchanged
      expect(payment.status, equals('Completed'));
      expect(payment.refundAmount, equals(0.0));
      expect(payment.refundDate, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final payment1 = Payment(
        uid: 'pay-123',
        invoiceUid: 'inv-456',
        amount: 99.99,
        status: 'Completed',
      );

      final payment2 = Payment(
        uid: 'pay-123',
        invoiceUid: 'inv-456',
        amount: 99.99,
        status: 'Completed',
      );

      final payment3 = Payment(
        uid: 'pay-123',
        invoiceUid: 'inv-456',
        amount: 99.99,
        status: 'Refunded', // Different
      );

      // Assert
      expect(payment1 == payment2, isTrue); // Same values should be equal
      expect(
        payment1 == payment3,
        isFalse,
      ); // Different values should not be equal

      // Check props content
      expect(payment1.props, contains(payment1.uid));
      expect(payment1.props, contains(payment1.invoiceUid));
      expect(payment1.props, contains(payment1.amount));
      expect(payment1.props, contains(payment1.status));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'pay-123',
        'InvoiceUid': 'inv-456',
        // Missing or null fields
      };

      // Act
      final payment = Payment.fromJson(json);

      // Assert
      expect(payment.uid, equals('pay-123'));
      expect(payment.invoiceUid, equals('inv-456'));
      expect(payment.accountUid, isNull);
      expect(payment.amount, isNull);
      expect(payment.paymentDate, isNull);
      expect(payment.paymentMethod, isNull);
      expect(payment.status, isNull);
      expect(payment.refundAmount, isNull);
      expect(payment.refundDate, isNull);
      expect(payment.stripePaymentId, isNull);
      expect(payment.invoice, isNull);
      expect(payment.account, isNull);
    });

    test('should handle different payment status values', () {
      // Test various status values
      final statuses = ['Completed', 'Refunded', 'Failed', 'Pending'];

      for (final status in statuses) {
        // Arrange
        final payment = Payment(
          uid: 'pay-123',
          status: status,
          refundAmount: 0.0,
        );

        // Act
        final json = payment.toJson();
        final deserialized = Payment.fromJson(json);

        // Assert
        expect(deserialized.status, equals(status));
      }
    });
  });
}
