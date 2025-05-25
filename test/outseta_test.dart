import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

import 'outseta_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('OutsetaAuth', () {
    test('ApiKeyAuth should return correct headers', () async {
      // Arrange
      final auth = ApiKeyAuth(
        apiKey: 'test-api-key',
        secretKey: 'test-secret-key',
      );

      // Act
      final headers = await auth.getHeaders();

      // Assert
      expect(headers, {
        'Authorization': 'Outseta test-api-key:test-secret-key',
      });
    });

    test('BearerTokenAuth should return correct headers', () async {
      // Arrange
      final auth = BearerTokenAuth(accessToken: 'test-token');

      // Act
      final headers = await auth.getHeaders();

      // Assert
      expect(headers, {'Authorization': 'bearer test-token'});
    });
  });

  group('ApiException', () {
    test('should have correct message and status code', () {
      // Arrange & Act
      final exception = ApiException('Test error message', statusCode: 500);

      // Assert
      expect(exception.message, equals('Test error message'));
      expect(exception.statusCode, equals(500));
      expect(exception.toString(), equals('ApiException: Test error message'));
    });

    test('BadRequestException should have correct status code', () {
      // Arrange & Act
      final exception = BadRequestException('Bad request error');

      // Assert
      expect(exception.message, equals('Bad request error'));
      expect(exception.statusCode, equals(400));
      expect(
        exception.toString(),
        equals('BadRequestException: Bad request error'),
      );
    });

    test('UnauthorizedException should have correct status code', () {
      // Arrange & Act
      final exception = UnauthorizedException('Unauthorized error');

      // Assert
      expect(exception.message, equals('Unauthorized error'));
      expect(exception.statusCode, equals(401));
      expect(
        exception.toString(),
        equals('UnauthorizedException: Unauthorized error'),
      );
    });
  });

  group('OutsetaClient', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
    });

    test('get should handle successful response', () async {
      // Arrange
      final responseData = {'name': 'Test Account', 'uid': '123'};
      when(
        mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await outsetaClient.get('crm/accounts/123');

      // Assert
      expect(result, equals(responseData));
      verify(
        mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });

    test('get should throw exception on error response', () async {
      // Arrange
      final errorResponse = {'error': 'Not found'};
      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/accounts/invalid',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(errorResponse), 404));

      // Act & Assert
      expect(
        () => outsetaClient.get('crm/accounts/invalid'),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('get should throw BadRequestException on 400 response', () async {
      // Arrange
      final errorResponse = {'error': 'Bad request'};
      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/accounts/invalid',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(errorResponse), 400));

      // Act & Assert
      expect(
        () => outsetaClient.get('crm/accounts/invalid'),
        throwsA(isA<BadRequestException>()),
      );
    });

    test('get should throw UnauthorizedException on 401 response', () async {
      // Arrange
      final errorResponse = {'error': 'Unauthorized'};
      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/accounts/invalid',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(errorResponse), 401));

      // Act & Assert
      expect(
        () => outsetaClient.get('crm/accounts/invalid'),
        throwsA(isA<UnauthorizedException>()),
      );
    });

    test('get should throw ForbiddenException on 403 response', () async {
      // Arrange
      final errorResponse = {'error': 'Forbidden'};
      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/accounts/invalid',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(errorResponse), 403));

      // Act & Assert
      expect(
        () => outsetaClient.get('crm/accounts/invalid'),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test(
      'get should throw RateLimitExceededException on 429 response',
      () async {
        // Arrange
        final errorResponse = {'error': 'Rate limit exceeded'};
        when(
          mockClient.get(
            Uri.parse(
              'https://test-domain.outseta.com/api/v1/crm/accounts/invalid',
            ),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => http.Response(jsonEncode(errorResponse), 429),
        );

        // Act & Assert
        expect(
          () => outsetaClient.get('crm/accounts/invalid'),
          throwsA(isA<RateLimitExceededException>()),
        );
      },
    );

    test('get should throw ApiException on other error responses', () async {
      // Arrange
      final errorResponse = {'error': 'Server error'};
      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/accounts/invalid',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(errorResponse), 500));

      // Act & Assert
      expect(
        () => outsetaClient.get('crm/accounts/invalid'),
        throwsA(isA<ApiException>()),
      );
    });

    test('post should handle successful response', () async {
      // Arrange
      final requestData = {'name': 'New Account'};
      final responseData = {'name': 'New Account', 'uid': '456'};
      when(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts'),
          headers: anyNamed('headers'),
          body: jsonEncode(requestData),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await outsetaClient.post(
        'crm/accounts',
        body: requestData,
      );

      // Assert
      expect(result, equals(responseData));
      verify(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts'),
          headers: anyNamed('headers'),
          body: jsonEncode(requestData),
        ),
      ).called(1);
    });

    test('put should handle successful response', () async {
      // Arrange
      final requestData = {'uid': '456', 'name': 'Updated Account'};
      final responseData = {'uid': '456', 'name': 'Updated Account'};
      when(
        mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/456'),
          headers: anyNamed('headers'),
          body: jsonEncode(requestData),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await outsetaClient.put(
        'crm/accounts/456',
        body: requestData,
      );

      // Assert
      expect(result, equals(responseData));
      verify(
        mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/456'),
          headers: anyNamed('headers'),
          body: jsonEncode(requestData),
        ),
      ).called(1);
    });

    test('delete should handle successful response', () async {
      // Arrange
      when(
        mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/456'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act
      final result = await outsetaClient.delete('crm/accounts/456');

      // Assert
      expect(result, equals({}));
      verify(
        mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/456'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });

    test('close should close the HTTP client', () {
      // Act
      outsetaClient.close();

      // Assert
      verify(mockClient.close()).called(1);
    });
  });

  group('CrmApi', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;
    late CrmApi crmApi;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
      crmApi = CrmApi(outsetaClient);
    });

    test('getPeople should return paginated list of people', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Email': 'test@example.com',
            'FirstName': 'Test',
            'LastName': 'User',
            'FullName': 'Test User',
          },
        ],
        'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
      };

      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/people',
          ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await crmApi.getPeople();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.email, equals('test@example.com'));
      expect(result.items.first.firstName, equals('Test'));
      expect(result.items.first.lastName, equals('User'));
      expect(result.metadata.total, equals(1));
    });

    test('getPeople should handle filter parameter', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Email': 'test@example.com',
            'FirstName': 'Test',
            'LastName': 'User',
            'FullName': 'Test User',
          },
        ],
        'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
      };

      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/crm/people',
          ).replace(
            queryParameters: {
              'offset': '0',
              'limit': '25',
              'filter': 'Email eq \'test@example.com\'',
            },
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await crmApi.getPeople(
        filter: 'Email eq \'test@example.com\'',
      );

      // Assert
      expect(result.items.length, equals(1));
      expect(result.metadata.total, equals(1));
    });

    test('getPerson should return a person', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Test',
        'LastName': 'User',
        'FullName': 'Test User',
      };

      when(
        mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await crmApi.getPerson('123');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.email, equals('test@example.com'));
      expect(result.firstName, equals('Test'));
      expect(result.lastName, equals('User'));
    });

    test('createPerson should create a person', () async {
      // Arrange
      final person = Person(
        firstName: 'New',
        lastName: 'Person',
        email: 'new.person@example.com',
      );

      final responseData = {
        'Uid': '456',
        'Email': 'new.person@example.com',
        'FirstName': 'New',
        'LastName': 'Person',
        'FullName': 'New Person',
      };

      when(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await crmApi.createPerson(person);

      // Assert
      expect(result.uid, equals('456'));
      expect(result.email, equals('new.person@example.com'));
      expect(result.firstName, equals('New'));
      expect(result.lastName, equals('Person'));
    });

    test('updatePerson should update a person', () async {
      // Arrange
      final person = Person(
        uid: '123',
        firstName: 'Updated',
        lastName: 'Person',
        email: 'updated.person@example.com',
      );

      final responseData = {
        'Uid': '123',
        'Email': 'updated.person@example.com',
        'FirstName': 'Updated',
        'LastName': 'Person',
        'FullName': 'Updated Person',
      };

      when(
        mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await crmApi.updatePerson(person);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.email, equals('updated.person@example.com'));
      expect(result.firstName, equals('Updated'));
      expect(result.lastName, equals('Person'));
    });

    test('updatePerson should throw ArgumentError if uid is null', () async {
      // Arrange
      final person = Person(
        firstName: 'Invalid',
        lastName: 'Person',
        email: 'invalid.person@example.com',
      );

      // Act & Assert
      expect(() => crmApi.updatePerson(person), throwsA(isA<ArgumentError>()));
    });

    test('deletePerson should delete a person', () async {
      // Arrange
      when(
        mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act
      await crmApi.deletePerson('123');

      // Assert
      verify(
        mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });
  });

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

    test('updatePlan should throw ArgumentError if uid is null', () async {
      // Arrange
      final plan = Plan(
        name: 'Invalid Plan',
        description: 'Invalid plan without UID',
      );

      // Act & Assert
      expect(() => billingApi.updatePlan(plan), throwsA(isA<ArgumentError>()));
    });

    test('deletePlan should delete a plan', () async {
      // Arrange
      when(
        mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/billing/plans/123'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response('', 204));

      // Act
      await billingApi.deletePlan('123');

      // Assert
      verify(
        mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/billing/plans/123'),
          headers: anyNamed('headers'),
        ),
      ).called(1);
    });

    test('getSubscription should return a subscription', () async {
      // Arrange
      final responseData = {
        'Uid': '456',
        'PlanUid': '123',
        'AccountUid': '789',
        'StartDate': '2023-01-01T00:00:00Z',
        'Status': 'Active',
        'BillingRenewalTerm': 'Month',
        'Amount': 19.99,
      };

      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/billing/subscriptions/456',
          ),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await billingApi.getSubscription('456');

      // Assert
      expect(result.uid, equals('456'));
      expect(result.planUid, equals('123'));
      expect(result.accountUid, equals('789'));
      expect(result.status, equals('Active'));
      expect(result.amount, equals(19.99));
    });

    test('cancelSubscription should cancel a subscription', () async {
      // Arrange
      final responseData = {
        'Uid': '456',
        'Status': 'Canceled',
        'CancellationReason': 'No longer needed',
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/billing/subscriptions/456/cancel',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'CancellationReason': 'No longer needed'}),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await billingApi.cancelSubscription(
        '456',
        cancellationReason: 'No longer needed',
      );

      // Assert
      expect(result.uid, equals('456'));
      expect(result.status, equals('Canceled'));
      expect(result.cancellationReason, equals('No longer needed'));
    });

    test('markInvoiceAsPaid should mark an invoice as paid', () async {
      // Arrange
      final responseData = {
        'Uid': '789',
        'InvoiceNumber': 'INV-123',
        'Status': 'Paid',
        'PaidDate': '2023-01-15T00:00:00Z',
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/billing/invoices/789/mark-as-paid',
          ),
          headers: anyNamed('headers'),
          body: null,
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await billingApi.markInvoiceAsPaid('789');

      // Assert
      expect(result.uid, equals('789'));
      expect(result.invoiceNumber, equals('INV-123'));
      expect(result.status, equals('Paid'));
    });

    test('refundPayment should refund a payment', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Amount': 19.99,
        'RefundAmount': 19.99,
        'Status': 'Refunded',
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/billing/payments/123/refund',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Amount': 19.99}),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await billingApi.refundPayment('123', amount: 19.99);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.refundAmount, equals(19.99));
      expect(result.status, equals('Refunded'));
    });
  });

  group('MarketingApi', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;
    late MarketingApi marketingApi;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
      marketingApi = MarketingApi(outsetaClient);
    });

    test('getLists should return paginated list of email lists', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Name': 'Newsletter Subscribers',
            'Description': 'People who want to receive our newsletter',
            'SubscriberCount': 42,
          },
        ],
        'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
      };

      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/marketing/lists',
          ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getLists();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.name, equals('Newsletter Subscribers'));
      expect(result.items.first.subscriberCount, equals(42));
      expect(result.metadata.total, equals(1));
    });

    test('createList should create an email list', () async {
      // Arrange
      final list = EmailList(
        name: 'New List',
        description: 'A new email list for testing',
      );

      final responseData = {
        'Uid': '456',
        'Name': 'New List',
        'Description': 'A new email list for testing',
        'SubscriberCount': 0,
      };

      when(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await marketingApi.createList(list);

      // Assert
      expect(result.uid, equals('456'));
      expect(result.name, equals('New List'));
      expect(result.description, equals('A new email list for testing'));
      expect(result.subscriberCount, equals(0));
    });

    test('addSubscriber should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/marketing/lists/123/add-person/456',
          ),
          headers: anyNamed('headers'),
          body: null,
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.addSubscriber('123', '456');

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/marketing/lists/123/add-person/456',
          ),
          headers: anyNamed('headers'),
          body: null,
        ),
      ).called(1);
    });

    test('removeSubscriber should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/marketing/lists/123/remove-person/456',
          ),
          headers: anyNamed('headers'),
          body: null,
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.removeSubscriber('123', '456');

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/marketing/lists/123/remove-person/456',
          ),
          headers: anyNamed('headers'),
          body: null,
        ),
      ).called(1);
    });

    test('getEmails should return paginated list of emails', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Subject': 'Test Email Campaign',
            'FromName': 'Test Sender',
            'FromEmail': 'test@example.com',
            'Status': 'Draft',
          },
        ],
        'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
      };

      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/marketing/emails',
          ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getEmails();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.subject, equals('Test Email Campaign'));
      expect(result.items.first.fromName, equals('Test Sender'));
      expect(result.items.first.fromEmail, equals('test@example.com'));
      expect(result.metadata.total, equals(1));
    });
  });

  group('SupportApi', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;
    late SupportApi supportApi;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
      supportApi = SupportApi(outsetaClient);
    });

    test('getTickets should return paginated list of tickets', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Subject': 'Help with subscription',
            'Description': 'I need help with my subscription',
            'Status': 'Open',
            'Priority': 'Medium',
          },
        ],
        'metadata': {'count': 1, 'limit': 25, 'offset': 0, 'total': 1},
      };

      when(
        mockClient.get(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/support/tickets',
          ).replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.getTickets();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.subject, equals('Help with subscription'));
      expect(result.items.first.status, equals('Open'));
      expect(result.items.first.priority, equals('Medium'));
      expect(result.metadata.total, equals(1));
    });

    test('addComment should add a comment to a ticket', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Status': 'Open',
        'Comments': [
          {'Comment': 'This is a test comment', 'IsPrivate': true},
        ],
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/support/tickets/123/comments',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'Comment': 'This is a test comment',
            'IsPrivate': true,
          }),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.addComment(
        '123',
        'This is a test comment',
        isPrivate: true,
      );

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Help with subscription'));
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/support/tickets/123/comments',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'Comment': 'This is a test comment',
            'IsPrivate': true,
          }),
        ),
      ).called(1);
    });

    test('createTicket should create a ticket', () async {
      // Arrange
      final ticket = Ticket(
        subject: 'New Support Request',
        description: 'This is a test ticket',
        priority: 'High',
      );

      final responseData = {
        'Uid': '456',
        'Subject': 'New Support Request',
        'Description': 'This is a test ticket',
        'Status': 'Open',
        'Priority': 'High',
      };

      when(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await supportApi.createTicket(ticket);

      // Assert
      expect(result.uid, equals('456'));
      expect(result.subject, equals('New Support Request'));
      expect(result.description, equals('This is a test ticket'));
      expect(result.status, equals('Open'));
      expect(result.priority, equals('High'));
    });

    test('changeStatus should change ticket status', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Status': 'In Progress',
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/support/tickets/123/change-status',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Status': 'In Progress'}),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.changeStatus('123', 'In Progress');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.status, equals('In Progress'));
    });

    test('assignTicket should assign a ticket to a person', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'AssignedToPersonUid': '456',
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/support/tickets/123/assign',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'PersonUid': '456'}),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.assignTicket('123', '456');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.assignedToPersonUid, equals('456'));
    });
  });

  group('UserProfileApi', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;
    late UserProfileApi userProfileApi;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
      userProfileApi = UserProfileApi(outsetaClient);
    });

    test('getCurrentUser should return the current user profile', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Test',
        'LastName': 'User',
        'EmailConfirmed': true,
      };

      when(
        mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/profile/user'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.getCurrentUser();

      // Assert
      expect(result.uid, equals('123'));
      expect(result.email, equals('test@example.com'));
      expect(result.firstName, equals('Test'));
      expect(result.lastName, equals('User'));
      expect(result.emailConfirmed, isTrue);
    });

    test('getAccessToken should return an access token', () async {
      // Arrange
      final responseData = {
        'access_token': 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...',
        'token_type': 'bearer',
        'expires_in': 3600,
      };

      when(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/tokens'),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'username': 'test@example.com',
            'password': 'password123',
          }),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.getAccessToken(
        'test@example.com',
        'password123',
      );

      // Assert
      expect(result, equals('eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...'));
    });

    test('updateCurrentUser should update the user profile', () async {
      // Arrange
      final user = User(firstName: 'Updated', lastName: 'User');

      final responseData = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Updated',
        'LastName': 'User',
        'EmailConfirmed': true,
      };

      when(
        mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/profile/user'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.updateCurrentUser(user);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.firstName, equals('Updated'));
      expect(result.lastName, equals('User'));
    });

    test('changePassword should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/change-password',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'CurrentPassword': 'current-password',
            'NewPassword': 'new-password',
            'ConfirmPassword': 'new-password',
          }),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.changePassword(
        'current-password',
        'new-password',
        'new-password',
      );

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/change-password',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'CurrentPassword': 'current-password',
            'NewPassword': 'new-password',
            'ConfirmPassword': 'new-password',
          }),
        ),
      ).called(1);
    });

    test('requestPasswordReset should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/request-password-reset',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Email': 'test@example.com'}),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.requestPasswordReset('test@example.com');

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/request-password-reset',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Email': 'test@example.com'}),
        ),
      ).called(1);
    });
  });
}
