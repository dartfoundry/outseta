import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Invoice', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'inv-123',
        'InvoiceNumber': 'INV-123',
        'AccountUid': 'account-456',
        'Amount': 99.99,
        'DueDate': '2023-02-01T00:00:00Z',
        'Status': 'Unpaid',
        'PaidDate': null,
        'InvoiceItems': [
          {
            'Description': 'Monthly subscription',
            'Amount': 99.99,
            'Quantity': 1,
          },
        ],
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'Account': {'Uid': 'account-456', 'Name': 'Test Company'},
      };

      // Act
      final invoice = Invoice.fromJson(json);

      // Assert
      expect(invoice.uid, equals('inv-123'));
      expect(invoice.invoiceNumber, equals('INV-123'));
      expect(invoice.accountUid, equals('account-456'));
      expect(invoice.amount, equals(99.99));
      expect(invoice.dueDate, isA<DateTime>());
      expect(invoice.status, equals('Unpaid'));
      expect(invoice.paidDate, isNull);
      expect(invoice.invoiceItems, isNotNull);
      expect(invoice.invoiceItems?.length, equals(1));
      expect(
        invoice.invoiceItems?[0]['Description'],
        equals('Monthly subscription'),
      );
      expect(invoice.created, isA<DateTime>());
      expect(invoice.updated, isA<DateTime>());
      expect(invoice.createdBy, equals('admin'));
      expect(invoice.updatedBy, equals('admin'));
      expect(invoice.account, isNotNull);
      expect(invoice.account?.uid, equals('account-456'));
      expect(invoice.account?.name, equals('Test Company'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final invoice = Invoice(
        uid: 'inv-123',
        invoiceNumber: 'INV-123',
        accountUid: 'account-456',
        amount: 99.99,
        dueDate: DateTime.parse('2023-02-01T00:00:00Z'),
        status: 'Unpaid',
        invoiceItems: [
          {
            'Description': 'Monthly subscription',
            'Amount': 99.99,
            'Quantity': 1,
          },
        ],
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        account: Account(uid: 'account-456', name: 'Test Company'),
      );

      // Act
      final json = invoice.toJson();

      // Assert
      expect(json['Uid'], equals('inv-123'));
      expect(json['InvoiceNumber'], equals('INV-123'));
      expect(json['AccountUid'], equals('account-456'));
      expect(json['Amount'], equals(99.99));
      expect(json['DueDate'], isA<String>());
      expect(json['Status'], equals('Unpaid'));
      expect(json['InvoiceItems'], isNotNull);
      expect(json['InvoiceItems'].length, equals(1));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['Account'], isNotNull);
      expect(json['Account'], isNotNull);
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final invoice = Invoice(
        uid: 'inv-123',
        invoiceNumber: 'INV-123',
        accountUid: 'account-456',
        amount: 99.99,
        status: 'Unpaid',
      );

      // Act
      final updatedInvoice = invoice.copyWith(
        status: 'Paid',
        paidDate: DateTime.parse('2023-02-15T00:00:00Z'),
        amount: 149.99,
      );

      // Assert
      expect(updatedInvoice.uid, equals('inv-123')); // Unchanged
      expect(updatedInvoice.invoiceNumber, equals('INV-123')); // Unchanged
      expect(updatedInvoice.accountUid, equals('account-456')); // Unchanged
      expect(updatedInvoice.status, equals('Paid')); // Changed
      expect(updatedInvoice.paidDate, isA<DateTime>()); // Added
      expect(updatedInvoice.amount, equals(149.99)); // Changed

      // Verify original is unchanged
      expect(invoice.status, equals('Unpaid'));
      expect(invoice.paidDate, isNull);
      expect(invoice.amount, equals(99.99));
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final invoice1 = Invoice(
        uid: 'inv-123',
        invoiceNumber: 'INV-123',
        accountUid: 'account-456',
        amount: 99.99,
        status: 'Unpaid',
      );

      final invoice2 = Invoice(
        uid: 'inv-123',
        invoiceNumber: 'INV-123',
        accountUid: 'account-456',
        amount: 99.99,
        status: 'Unpaid',
      );

      final invoice3 = Invoice(
        uid: 'inv-123',
        invoiceNumber: 'INV-123',
        accountUid: 'account-456',
        amount: 99.99,
        status: 'Paid', // Different
      );

      // Assert
      expect(invoice1 == invoice2, isTrue); // Same values should be equal
      expect(
        invoice1 == invoice3,
        isFalse,
      ); // Different values should not be equal

      // Check props content
      expect(invoice1.props, contains(invoice1.uid));
      expect(invoice1.props, contains(invoice1.invoiceNumber));
      expect(invoice1.props, contains(invoice1.accountUid));
      expect(invoice1.props, contains(invoice1.amount));
      expect(invoice1.props, contains(invoice1.status));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'inv-123',
        'InvoiceNumber': 'INV-123',
        // Missing or null fields
      };

      // Act
      final invoice = Invoice.fromJson(json);

      // Assert
      expect(invoice.uid, equals('inv-123'));
      expect(invoice.invoiceNumber, equals('INV-123'));
      expect(invoice.accountUid, isNull);
      expect(invoice.amount, isNull);
      expect(invoice.dueDate, isNull);
      expect(invoice.paidDate, isNull);
      expect(invoice.status, isNull);
      expect(invoice.invoiceItems, isNull);
      expect(invoice.account, isNull);
    });

    test('should handle different status values', () {
      // Test various status values
      final statuses = ['Unpaid', 'Paid', 'Void', 'Refunded', 'Overdue'];

      for (final status in statuses) {
        // Arrange
        final invoice = Invoice(
          uid: 'inv-123',
          invoiceNumber: 'INV-123',
          status: status,
        );

        // Act
        final json = invoice.toJson();
        final deserialized = Invoice.fromJson(json);

        // Assert
        expect(deserialized.status, equals(status));
      }
    });
  });
}
