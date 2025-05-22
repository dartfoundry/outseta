import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

import 'support_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
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
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets')
            .replace(queryParameters: {'offset': '0', 'limit': '25'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.getTickets();

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.subject, equals('Help with subscription'));
      expect(result.items.first.status, equals('Open'));
      expect(result.items.first.priority, equals('Medium'));
      expect(result.metadata.total, equals(1));
    });

    test('getTicket should return a ticket', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Description': 'I need help with my subscription',
        'Status': 'Open',
        'Priority': 'Medium',
        'RequesterPersonUid': '456',
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.getTicket('123');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Help with subscription'));
      expect(result.status, equals('Open'));
      expect(result.priority, equals('Medium'));
      expect(result.requesterPersonUid, equals('456'));
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
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

      // Act
      final result = await supportApi.createTicket(ticket);

      // Assert
      expect(result.uid, equals('456'));
      expect(result.subject, equals('New Support Request'));
      expect(result.description, equals('This is a test ticket'));
      expect(result.status, equals('Open'));
      expect(result.priority, equals('High'));
    });

    test('updateTicket should update a ticket', () async {
      // Arrange
      final ticket = Ticket(
        uid: '123',
        subject: 'Updated Support Request',
        description: 'This is an updated ticket',
        priority: 'Low',
        status: 'In Progress',
      );
      
      final responseData = {
        'Uid': '123',
        'Subject': 'Updated Support Request',
        'Description': 'This is an updated ticket',
        'Status': 'In Progress',
        'Priority': 'Low',
      };
      
      when(mockClient.put(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.updateTicket(ticket);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Updated Support Request'));
      expect(result.status, equals('In Progress'));
      expect(result.priority, equals('Low'));
    });

    test('deleteTicket should delete a ticket', () async {
      // Arrange
      when(mockClient.delete(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response('', 204));

      // Act
      await supportApi.deleteTicket('123');

      // Assert
      verify(mockClient.delete(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123'),
        headers: anyNamed('headers'),
      )).called(1);
    });

    test('addComment should add a comment to a ticket', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Status': 'Open',
        'Comments': [
          {
            'Comment': 'This is a test comment',
            'IsPrivate': true,
          }
        ],
      };
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123/comments'),
        headers: anyNamed('headers'),
        body: jsonEncode({'Comment': 'This is a test comment', 'IsPrivate': true}),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.addComment('123', 'This is a test comment', isPrivate: true);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Help with subscription'));
      expect(result.comments, isNotNull);
      expect(result.comments?.length, equals(1));
      expect(result.comments?.first['Comment'], equals('This is a test comment'));
      expect(result.comments?.first['IsPrivate'], isTrue);
    });

    test('changeStatus should change the status of a ticket', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Status': 'In Progress',
      };
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123/change-status'),
        headers: anyNamed('headers'),
        body: jsonEncode({'Status': 'In Progress'}),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.changeStatus('123', 'In Progress');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Help with subscription'));
      expect(result.status, equals('In Progress'));
    });

    test('assignTicket should assign a ticket to a person', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Status': 'Open',
        'AssignedToPersonUid': '456',
      };
      
      when(mockClient.post(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets/123/assign'),
        headers: anyNamed('headers'),
        body: jsonEncode({'PersonUid': '456'}),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.assignTicket('123', '456');

      // Assert
      expect(result.uid, equals('123'));
      expect(result.subject, equals('Help with subscription'));
      expect(result.assignedToPersonUid, equals('456'));
    });

    test('getTicketsAssignedToPerson should return tickets assigned to a person', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Subject': 'Help with subscription',
            'Status': 'Open',
            'AssignedToPersonUid': '456',
          }
        ],
        'metadata': {
          'count': 1,
          'limit': 10,
          'offset': 0,
          'total': 1,
        },
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets')
            .replace(queryParameters: {'offset': '0', 'limit': '10', 'filter': 'AssignedToPersonUid eq 456'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.getTicketsAssignedToPerson('456', limit: 10);

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.subject, equals('Help with subscription'));
      expect(result.items.first.assignedToPersonUid, equals('456'));
      expect(result.metadata.total, equals(1));
    });

    test('getTicketsSubmittedByPerson should return tickets submitted by a person', () async {
      // Arrange
      final responseData = {
        'items': [
          {
            'Uid': '123',
            'Subject': 'Help with subscription',
            'Status': 'Open',
            'RequesterPersonUid': '456',
          }
        ],
        'metadata': {
          'count': 1,
          'limit': 10,
          'offset': 0,
          'total': 1,
        },
      };
      
      when(mockClient.get(
        Uri.parse('https://test-domain.outseta.com/api/v1/support/tickets')
            .replace(queryParameters: {'offset': '0', 'limit': '10', 'filter': 'CreatedBy eq 456'}),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await supportApi.getTicketsSubmittedByPerson('456', limit: 10);

      // Assert
      expect(result.items.length, equals(1));
      expect(result.items.first.subject, equals('Help with subscription'));
      expect(result.items.first.requesterPersonUid, equals('456'));
      expect(result.metadata.total, equals(1));
    });
  });
}