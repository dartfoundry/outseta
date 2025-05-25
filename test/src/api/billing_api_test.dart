import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

import 'billing_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('BillingApi', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;
    late BillingApi billingApi;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
      billingApi = BillingApi(outsetaClient);
    });

    // Plans endpoints tests
    group('Plans endpoints', () {
      test('getPlans should return paginated list of plans', () async {
        // Arrange
        final responseData = {
          'items': [
            {
              'Uid': '123',
              'Name': 'Basic Plan',
              'Description': 'Basic subscription plan',
              'Amount': 19.99,
              'BillingTerm': 'Month',
              'IsActive': true,
            },
          ],
          'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/plans',
            ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getPlans();

        // Assert
        expect(result.items.length, equals(1));
        expect(result.items.first.name, equals('Basic Plan'));
        expect(result.items.first.amount, equals(19.99));
        expect(result.items.first.billingTerm, equals('Month'));
        expect(result.items.first.isActive, isTrue);
        expect(result.metadata.total, equals(1));
      });

      test('getPlan should return a plan', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'Name': 'Basic Plan',
          'Description': 'Basic subscription plan',
          'Amount': 19.99,
          'BillingTerm': 'Month',
          'IsActive': true,
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/plans/123',
            ),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getPlan('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.name, equals('Basic Plan'));
        expect(result.description, equals('Basic subscription plan'));
        expect(result.amount, equals(19.99));
        expect(result.billingTerm, equals('Month'));
        expect(result.isActive, isTrue);
      });

      test('createPlan should create a plan', () async {
        // Arrange
        final plan = Plan(
          name: 'Premium Plan',
          description: 'Premium subscription plan',
          amount: 49.99,
          billingTerm: 'Month',
          isActive: true,
        );

        final responseData = {
          'Uid': '456',
          'Name': 'Premium Plan',
          'Description': 'Premium subscription plan',
          'Amount': 49.99,
          'BillingTerm': 'Month',
          'IsActive': true,
        };

        when(
          mockClient.post(
            Uri.parse('https://test-domain.outseta.com/api/v1/billing/plans'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

        // Act
        final result = await billingApi.createPlan(plan);

        // Assert
        expect(result.uid, equals('456'));
        expect(result.name, equals('Premium Plan'));
        expect(result.amount, equals(49.99));
        expect(result.billingTerm, equals('Month'));
        expect(result.isActive, isTrue);
      });

      test('updatePlan should update a plan', () async {
        // Arrange
        final plan = Plan(
          uid: '123',
          name: 'Updated Plan',
          description: 'Updated subscription plan',
          amount: 29.99,
          billingTerm: 'Month',
          isActive: true,
        );

        final responseData = {
          'Uid': '123',
          'Name': 'Updated Plan',
          'Description': 'Updated subscription plan',
          'Amount': 29.99,
          'BillingTerm': 'Month',
          'IsActive': true,
        };

        when(
          mockClient.put(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/plans/123',
            ),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.updatePlan(plan);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.name, equals('Updated Plan'));
        expect(result.description, equals('Updated subscription plan'));
        expect(result.amount, equals(29.99));
        expect(result.billingTerm, equals('Month'));
        expect(result.isActive, isTrue);
      });

      test('updatePlan should throw ArgumentError if uid is null', () async {
        // Arrange
        final plan = Plan(
          name: 'Invalid Plan',
          description: 'Invalid plan without UID',
        );

        // Act & Assert
        expect(
          () => billingApi.updatePlan(plan),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('deletePlan should delete a plan', () async {
        // Arrange
        when(
          mockClient.delete(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/plans/123',
            ),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response('', 204));

        // Act
        await billingApi.deletePlan('123');

        // Assert
        verify(
          mockClient.delete(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/plans/123',
            ),
            headers: anyNamed('headers'),
          ),
        ).called(1);
      });
    });

    // Subscriptions endpoints tests
    group('Subscriptions endpoints', () {
      test(
        'getSubscriptions should return paginated list of subscriptions',
        () async {
          // Arrange
          final responseData = {
            'items': [
              {
                'Uid': '123',
                'PlanUid': '456',
                'AccountUid': '789',
                'StartDate': '2023-01-01T00:00:00Z',
                'Status': 'Active',
                'BillingRenewalTerm': 'Month',
                'Amount': 19.99,
              },
            ],
            'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
          };

          when(
            mockClient.get(
              Uri.parse(
                'https://test-domain.outseta.com/api/v1/billing/subscriptions',
              ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
              headers: anyNamed('headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(jsonEncode(responseData), 200),
          );

          // Act
          final result = await billingApi.getSubscriptions();

          // Assert
          expect(result.items.length, equals(1));
          expect(result.items.first.planUid, equals('456'));
          expect(result.items.first.accountUid, equals('789'));
          expect(result.items.first.status, equals('Active'));
          expect(result.items.first.amount, equals(19.99));
          expect(result.metadata.total, equals(1));
        },
      );

      test('getSubscription should return a subscription', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'PlanUid': '456',
          'AccountUid': '789',
          'StartDate': '2023-01-01T00:00:00Z',
          'Status': 'Active',
          'BillingRenewalTerm': 'Month',
          'Amount': 19.99,
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/subscriptions/123',
            ),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getSubscription('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.planUid, equals('456'));
        expect(result.accountUid, equals('789'));
        expect(result.status, equals('Active'));
        expect(result.amount, equals(19.99));
      });

      test('createSubscription should create a subscription', () async {
        // Arrange
        final subscription = Subscription(
          planUid: '456',
          accountUid: '789',
          startDate: DateTime.parse('2023-01-01T00:00:00Z'),
        );

        final responseData = {
          'Uid': '123',
          'PlanUid': '456',
          'AccountUid': '789',
          'StartDate': '2023-01-01T00:00:00Z',
          'Status': 'Active',
          'BillingRenewalTerm': 'Month',
          'Amount': 19.99,
        };

        when(
          mockClient.post(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/subscriptions',
            ),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

        // Act
        final result = await billingApi.createSubscription(subscription);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.planUid, equals('456'));
        expect(result.accountUid, equals('789'));
        expect(result.status, equals('Active'));
        expect(result.amount, equals(19.99));
      });

      test('updateSubscription should update a subscription', () async {
        // Arrange
        final subscription = Subscription(
          uid: '123',
          planUid: '456',
          accountUid: '789',
          status: 'Canceled',
        );

        final responseData = {
          'Uid': '123',
          'PlanUid': '456',
          'AccountUid': '789',
          'StartDate': '2023-01-01T00:00:00Z',
          'Status': 'Canceled',
          'BillingRenewalTerm': 'Month',
          'Amount': 19.99,
        };

        when(
          mockClient.put(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/subscriptions/123',
            ),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.updateSubscription(subscription);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.planUid, equals('456'));
        expect(result.accountUid, equals('789'));
        expect(result.status, equals('Canceled'));
        expect(result.amount, equals(19.99));
      });

      test(
        'updateSubscription should throw ArgumentError if uid is null',
        () async {
          // Arrange
          final subscription = Subscription(planUid: '456', accountUid: '789');

          // Act & Assert
          expect(
            () => billingApi.updateSubscription(subscription),
            throwsA(isA<ArgumentError>()),
          );
        },
      );

      test('cancelSubscription should cancel a subscription', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'Status': 'Canceled',
          'CancellationReason': 'No longer needed',
        };

        when(
          mockClient.post(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/subscriptions/123/cancel',
            ),
            headers: anyNamed('headers'),
            body: jsonEncode({'CancellationReason': 'No longer needed'}),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.cancelSubscription(
          '123',
          cancellationReason: 'No longer needed',
        );

        // Assert
        expect(result.uid, equals('123'));
        expect(result.status, equals('Canceled'));
        expect(result.cancellationReason, equals('No longer needed'));
      });
    });

    // Invoices endpoints tests
    group('Invoices endpoints', () {
      test('getInvoices should return paginated list of invoices', () async {
        // Arrange
        final responseData = {
          'items': [
            {
              'Uid': '123',
              'InvoiceNumber': 'INV-123',
              'AccountUid': '456',
              'Amount': 99.99,
              'DueDate': '2023-02-01T00:00:00Z',
              'Status': 'Unpaid',
            },
          ],
          'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/invoices',
            ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getInvoices();

        // Assert
        expect(result.items.length, equals(1));
        expect(result.items.first.invoiceNumber, equals('INV-123'));
        expect(result.items.first.accountUid, equals('456'));
        expect(result.items.first.amount, equals(99.99));
        expect(result.items.first.status, equals('Unpaid'));
        expect(result.metadata.total, equals(1));
      });

      test('getInvoice should return an invoice', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'InvoiceNumber': 'INV-123',
          'AccountUid': '456',
          'Amount': 99.99,
          'DueDate': '2023-02-01T00:00:00Z',
          'Status': 'Unpaid',
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/invoices/123',
            ),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getInvoice('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.invoiceNumber, equals('INV-123'));
        expect(result.accountUid, equals('456'));
        expect(result.amount, equals(99.99));
        expect(result.status, equals('Unpaid'));
      });

      test('createInvoice should create an invoice', () async {
        // Arrange
        final invoice = Invoice(
          accountUid: '456',
          amount: 99.99,
          dueDate: DateTime.parse('2023-02-01T00:00:00Z'),
        );

        final responseData = {
          'Uid': '123',
          'InvoiceNumber': 'INV-123',
          'AccountUid': '456',
          'Amount': 99.99,
          'DueDate': '2023-02-01T00:00:00Z',
          'Status': 'Unpaid',
        };

        when(
          mockClient.post(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/invoices',
            ),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

        // Act
        final result = await billingApi.createInvoice(invoice);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.invoiceNumber, equals('INV-123'));
        expect(result.accountUid, equals('456'));
        expect(result.amount, equals(99.99));
        expect(result.status, equals('Unpaid'));
      });

      test('updateInvoice should update an invoice', () async {
        // Arrange
        final invoice = Invoice(
          uid: '123',
          accountUid: '456',
          amount: 149.99,
          dueDate: DateTime.parse('2023-03-01T00:00:00Z'),
        );

        final responseData = {
          'Uid': '123',
          'InvoiceNumber': 'INV-123',
          'AccountUid': '456',
          'Amount': 149.99,
          'DueDate': '2023-03-01T00:00:00Z',
          'Status': 'Unpaid',
        };

        when(
          mockClient.put(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/invoices/123',
            ),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.updateInvoice(invoice);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.accountUid, equals('456'));
        expect(result.amount, equals(149.99));
        expect(result.status, equals('Unpaid'));
      });

      test('updateInvoice should throw ArgumentError if uid is null', () async {
        // Arrange
        final invoice = Invoice(accountUid: '456', amount: 99.99);

        // Act & Assert
        expect(
          () => billingApi.updateInvoice(invoice),
          throwsA(isA<ArgumentError>()),
        );
      });

      test('markInvoiceAsPaid should mark an invoice as paid', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'InvoiceNumber': 'INV-123',
          'Status': 'Paid',
          'PaidDate': '2023-01-15T00:00:00Z',
        };

        when(
          mockClient.post(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/invoices/123/mark-as-paid',
            ),
            headers: anyNamed('headers'),
            body: null,
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.markInvoiceAsPaid('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.invoiceNumber, equals('INV-123'));
        expect(result.status, equals('Paid'));
      });
    });

    // Payments endpoints tests
    group('Payments endpoints', () {
      test('getPayments should return paginated list of payments', () async {
        // Arrange
        final responseData = {
          'items': [
            {
              'Uid': '123',
              'InvoiceUid': '456',
              'Amount': 99.99,
              'PaymentDate': '2023-01-15T00:00:00Z',
              'PaymentMethod': 'CreditCard',
              'Status': 'Completed',
            },
          ],
          'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/payments',
            ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getPayments();

        // Assert
        expect(result.items.length, equals(1));
        expect(result.items.first.invoiceUid, equals('456'));
        expect(result.items.first.amount, equals(99.99));
        expect(result.items.first.paymentMethod, equals('CreditCard'));
        expect(result.items.first.status, equals('Completed'));
        expect(result.metadata.total, equals(1));
      });

      test('getPayment should return a payment', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'InvoiceUid': '456',
          'Amount': 99.99,
          'PaymentDate': '2023-01-15T00:00:00Z',
          'PaymentMethod': 'CreditCard',
          'Status': 'Completed',
        };

        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/payments/123',
            ),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.getPayment('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.invoiceUid, equals('456'));
        expect(result.amount, equals(99.99));
        expect(result.paymentMethod, equals('CreditCard'));
        expect(result.status, equals('Completed'));
      });

      test('createPayment should create a payment', () async {
        // Arrange
        final payment = Payment(
          invoiceUid: '456',
          amount: 99.99,
          paymentMethod: 'CreditCard',
        );

        final responseData = {
          'Uid': '123',
          'InvoiceUid': '456',
          'Amount': 99.99,
          'PaymentDate': '2023-01-15T00:00:00Z',
          'PaymentMethod': 'CreditCard',
          'Status': 'Completed',
        };

        when(
          mockClient.post(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/payments',
            ),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

        // Act
        final result = await billingApi.createPayment(payment);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.invoiceUid, equals('456'));
        expect(result.amount, equals(99.99));
        expect(result.paymentMethod, equals('CreditCard'));
        expect(result.status, equals('Completed'));
      });

      test('refundPayment should refund a payment', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'Amount': 99.99,
          'RefundAmount': 99.99,
          'Status': 'Refunded',
        };

        when(
          mockClient.post(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/billing/payments/123/refund',
            ),
            headers: anyNamed('headers'),
            body: jsonEncode({'Amount': 99.99}),
          ),
        ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await billingApi.refundPayment('123', amount: 99.99);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.refundAmount, equals(99.99));
        expect(result.status, equals('Refunded'));
      });
    });
  });
}
