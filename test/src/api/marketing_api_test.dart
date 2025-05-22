import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

import 'marketing_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
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
          }
        ],
        'metadata': {
          'count': 1,
          'limit': 25,
          'offset': 0,
          'total': 1,
        },
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists')
            .replace(queryParameters: {'offset': '0', 'limit': '25'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getLists();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.name, equals('Newsletter Subscribers'));
      expect(result.items.first.subscriberCount, equals(42));
      expect(result.metadata.total, equals(1));
    });
    
    test('getList should return an email list by UID', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Name': 'Newsletter Subscribers',
        'Description': 'People who want to receive our newsletter',
        'SubscriberCount': 42,
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getList('123');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.name, equals('Newsletter Subscribers'));
      expect(result.description, equals('People who want to receive our newsletter'));
      expect(result.subscriberCount, equals(42));
      expect(result.created, isA<DateTime>());
      expect(result.updated, isA<DateTime>());
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
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await marketingApi.createList(list);

      // Assert
      expect(result.uid, equals('456'));
      expect(result.name, equals('New List'));
      expect(result.description, equals('A new email list for testing'));
      expect(result.subscriberCount, equals(0));
    });
    
    test('updateList should update an email list', () async {
      // Arrange
      final list = EmailList(
        uid: '123',
        name: 'Updated List',
        description: 'An updated email list for testing',
      );
      
      final responseData = {
        'Uid': '123',
        'Name': 'Updated List',
        'Description': 'An updated email list for testing',
        'SubscriberCount': 42,
      };
      
      when(mockClient.put(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.updateList(list);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.name, equals('Updated List'));
      expect(result.description, equals('An updated email list for testing'));
      expect(result.subscriberCount, equals(42));
    });
    
    test('updateList should throw ArgumentError if uid is null', () async {
      // Arrange
      final list = EmailList(
        name: 'Invalid List',
        description: 'List without UID',
      );
      
      // Act & Assert
      expect(
        () => marketingApi.updateList(list),
        throwsA(isA<ArgumentError>()),
      );
    });
    
    test('deleteList should delete an email list', () async {
      // Arrange
      when(mockClient.delete(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 204));

      // Act
      await marketingApi.deleteList('123');

      // Assert
      verify(mockClient.delete(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123'),
        headers: anyNamed('headers'),
      )).called(1);
    });
    
    test('getSubscribers should return subscribers for a list', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Email': 'test@example.com',
            'FirstName': 'Test',
            'LastName': 'User',
          }
        ],
        'metadata': {
          'count': 1,
          'limit': 25,
          'offset': 0,
          'total': 1,
        },
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123/people')
            .replace(queryParameters: {'offset': '0', 'limit': '25'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getSubscribers('123');

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.email, equals('test@example.com'));
      expect(result.items.first.firstName, equals('Test'));
      expect(result.metadata.total, equals(1));
    });
    
    test('addSubscriber should add a subscriber to a list', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123/add-person/456'),
        headers: anyNamed('headers'),
        body: null,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.addSubscriber('123', '456');

      // Assert
      verify(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123/add-person/456'),
        headers: anyNamed('headers'),
        body: null,
      )).called(1);
    });
    
    test('removeSubscriber should remove a subscriber from a list', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123/remove-person/456'),
        headers: anyNamed('headers'),
        body: null,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.removeSubscriber('123', '456');

      // Assert
      verify(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/lists/123/remove-person/456'),
        headers: anyNamed('headers'),
        body: null,
      )).called(1);
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
          }
        ],
        'metadata': {
          'count': 1,
          'limit': 25,
          'offset': 0,
          'total': 1,
        },
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails')
            .replace(queryParameters: {'offset': '0', 'limit': '25'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getEmails();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.subject, equals('Test Email Campaign'));
      expect(result.items.first.fromName, equals('Test Sender'));
      expect(result.items.first.fromEmail, equals('test@example.com'));
      expect(result.metadata.total, equals(1));
    });
    
    test('getEmail should return an email by UID', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Test Email Campaign',
        'FromName': 'Test Sender',
        'FromEmail': 'test@example.com',
        'Status': 'Draft',
        'Content': '<h1>Email content</h1>',
        'ScheduledDate': '2023-01-15T00:00:00Z',
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.getEmail('123');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Test Email Campaign'));
      expect(result.fromName, equals('Test Sender'));
      expect(result.fromEmail, equals('test@example.com'));
      expect(result.status, equals('Draft'));
      expect(result.content, equals('<h1>Email content</h1>'));
      expect(result.scheduledDate, isA<DateTime>());
    });
    
    test('createEmail should create an email campaign', () async {
      // Arrange
      final email = Email(
        subject: 'New Email Campaign',
        fromName: 'Test Sender',
        fromEmail: 'test@example.com',
        content: '<h1>Email content</h1>',
        emailListUid: '456',
      );
      
      final responseData = {
        'Uid': '123',
        'Subject': 'New Email Campaign',
        'FromName': 'Test Sender',
        'FromEmail': 'test@example.com',
        'Content': '<h1>Email content</h1>',
        'EmailListUid': '456',
        'Status': 'Draft',
      };
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await marketingApi.createEmail(email);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('New Email Campaign'));
      expect(result.fromName, equals('Test Sender'));
      expect(result.fromEmail, equals('test@example.com'));
      expect(result.emailListUid, equals('456'));
      expect(result.status, equals('Draft'));
    });
    
    test('updateEmail should update an email campaign', () async {
      // Arrange
      final email = Email(
        uid: '123',
        subject: 'Updated Email Campaign',
        content: '<h1>Updated content</h1>',
      );
      
      final responseData = {
        'Uid': '123',
        'Subject': 'Updated Email Campaign',
        'FromName': 'Test Sender',
        'FromEmail': 'test@example.com',
        'Content': '<h1>Updated content</h1>',
        'Status': 'Draft',
      };
      
      when(mockClient.put(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await marketingApi.updateEmail(email);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Updated Email Campaign'));
      expect(result.content, equals('<h1>Updated content</h1>'));
    });
    
    test('updateEmail should throw ArgumentError if uid is null', () async {
      // Arrange
      final email = Email(
        subject: 'Invalid Email',
        content: '<h1>Content</h1>',
      );
      
      // Act & Assert
      expect(
        () => marketingApi.updateEmail(email),
        throwsA(isA<ArgumentError>()),
      );
    });
    
    test('deleteEmail should delete an email campaign', () async {
      // Arrange
      when(mockClient.delete(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 204));

      // Act
      await marketingApi.deleteEmail('123');

      // Assert
      verify(mockClient.delete(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123'),
        headers: anyNamed('headers'),
      )).called(1);
    });
    
    test('sendTestEmail should send a test email', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/send-test'),
        headers: anyNamed('headers'),
        body: jsonEncode({'RecipientEmail': 'test@example.com'}),
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.sendTestEmail('123', 'test@example.com');

      // Assert
      verify(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/send-test'),
        headers: anyNamed('headers'),
        body: jsonEncode({'RecipientEmail': 'test@example.com'}),
      )).called(1);
    });
    
    test('scheduleEmail should schedule an email campaign', () async {
      // Arrange
      final scheduledDate = DateTime.parse('2023-01-15T10:00:00Z');
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/schedule'),
        headers: anyNamed('headers'),
        body: jsonEncode({'ScheduledDate': '2023-01-15T10:00:00.000Z'}),
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.scheduleEmail('123', scheduledDate);

      // Assert
      verify(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/schedule'),
        headers: anyNamed('headers'),
        body: jsonEncode({'ScheduledDate': '2023-01-15T10:00:00.000Z'}),
      )).called(1);
    });
    
    test('sendEmailNow should send an email campaign immediately', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/send-now'),
        headers: anyNamed('headers'),
        body: null,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.sendEmailNow('123');

      // Assert
      verify(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/send-now'),
        headers: anyNamed('headers'),
        body: null,
      )).called(1);
    });
    
    test('cancelScheduledEmail should cancel a scheduled email campaign', () async {
      // Arrange
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/cancel'),
        headers: anyNamed('headers'),
        body: null,
      )).thenAnswer((_) async => http.Response('', 200));

      // Act
      await marketingApi.cancelScheduledEmail('123');

      // Assert
      verify(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/marketing/emails/123/cancel'),
        headers: anyNamed('headers'),
        body: null,
      )).called(1);
    });
  });
}