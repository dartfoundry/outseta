import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

import 'crm_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
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

    // People endpoints tests
    group('People endpoints', () {
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
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people')
              .replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

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
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people')
              .replace(queryParameters: {'offset': '0', 'limit': '25', 'filter': "Email eq 'test@example.com'"}),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.getPeople(filter: "Email eq 'test@example.com'");

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
        
        when(mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

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
        
        when(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

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
        
        when(mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

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
        expect(
          () => crmApi.updatePerson(person),
          throwsA(isA<ArgumentError>()),
        );
      });
      
      test('deletePerson should delete a person', () async {
        // Arrange
        when(mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('', 204));

        // Act
        await crmApi.deletePerson('123');

        // Assert
        verify(mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/people/123'),
          headers: anyNamed('headers'),
        )).called(1);
      });
    });

    // Accounts endpoints tests
    group('Accounts endpoints', () {
      test('getAccounts should return paginated list of accounts', () async {
        // Arrange
        final responseData = {
          'items': [
            {
              'Uid': '123',
              'Name': 'Test Company',
              'ClientIdentifier': 'client123',
              'PhoneNumber': '555-1234',
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
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts')
              .replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.getAccounts();

        // Assert
        expect(result.items.length, equals(1));
        expect(result.items.first.name, equals('Test Company'));
        expect(result.items.first.clientIdentifier, equals('client123'));
        expect(result.items.first.phoneNumber, equals('555-1234'));
        expect(result.metadata.total, equals(1));
      });
      
      test('getAccount should return an account', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'Name': 'Test Company',
          'ClientIdentifier': 'client123',
          'PhoneNumber': '555-1234',
        };
        
        when(mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.getAccount('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.name, equals('Test Company'));
        expect(result.clientIdentifier, equals('client123'));
        expect(result.phoneNumber, equals('555-1234'));
      });
      
      test('createAccount should create an account', () async {
        // Arrange
        final account = Account(
          name: 'New Company',
          clientIdentifier: 'newclient123',
          phoneNumber: '555-5678',
        );
        
        final responseData = {
          'Uid': '456',
          'Name': 'New Company',
          'ClientIdentifier': 'newclient123',
          'PhoneNumber': '555-5678',
        };
        
        when(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

        // Act
        final result = await crmApi.createAccount(account);

        // Assert
        expect(result.uid, equals('456'));
        expect(result.name, equals('New Company'));
        expect(result.clientIdentifier, equals('newclient123'));
        expect(result.phoneNumber, equals('555-5678'));
      });
      
      test('updateAccount should update an account', () async {
        // Arrange
        final account = Account(
          uid: '123',
          name: 'Updated Company',
          clientIdentifier: 'updatedclient123',
          phoneNumber: '555-9999',
        );
        
        final responseData = {
          'Uid': '123',
          'Name': 'Updated Company',
          'ClientIdentifier': 'updatedclient123',
          'PhoneNumber': '555-9999',
        };
        
        when(mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.updateAccount(account);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.name, equals('Updated Company'));
        expect(result.clientIdentifier, equals('updatedclient123'));
        expect(result.phoneNumber, equals('555-9999'));
      });
      
      test('updateAccount should throw ArgumentError if uid is null', () async {
        // Arrange
        final account = Account(
          name: 'Invalid Company',
          clientIdentifier: 'invalidclient123',
        );
        
        // Act & Assert
        expect(
          () => crmApi.updateAccount(account),
          throwsA(isA<ArgumentError>()),
        );
      });
      
      test('deleteAccount should delete an account', () async {
        // Arrange
        when(mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('', 204));

        // Act
        await crmApi.deleteAccount('123');

        // Assert
        verify(mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123'),
          headers: anyNamed('headers'),
        )).called(1);
      });
      
      test('addPersonToAccount should add a person to an account', () async {
        // Arrange
        when(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123/add-person/456'),
          headers: anyNamed('headers'),
          body: null,
        )).thenAnswer((_) async => http.Response('', 200));

        // Act
        await crmApi.addPersonToAccount('123', '456');

        // Assert
        verify(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123/add-person/456'),
          headers: anyNamed('headers'),
          body: null,
        )).called(1);
      });
      
      test('removePersonFromAccount should remove a person from an account', () async {
        // Arrange
        when(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123/remove-person/456'),
          headers: anyNamed('headers'),
          body: null,
        )).thenAnswer((_) async => http.Response('', 200));

        // Act
        await crmApi.removePersonFromAccount('123', '456');

        // Assert
        verify(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/accounts/123/remove-person/456'),
          headers: anyNamed('headers'),
          body: null,
        )).called(1);
      });
    });

    // Deals endpoints tests
    group('Deals endpoints', () {
      test('getDeals should return paginated list of deals', () async {
        // Arrange
        final responseData = {
          'items': [
            {
              'Uid': '123',
              'Name': 'Test Deal',
              'Amount': 5000.0,
              'Stage': 'Qualified',
              'AccountUid': '456',
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
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/deals')
              .replace(queryParameters: {'offset': '0', 'limit': '25'}),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.getDeals();

        // Assert
        expect(result.items.length, equals(1));
        expect(result.items.first.name, equals('Test Deal'));
        expect(result.items.first.amount, equals(5000.0));
        expect(result.items.first.stage, equals('Qualified'));
        expect(result.items.first.accountUid, equals('456'));
        expect(result.metadata.total, equals(1));
      });
      
      test('getDeal should return a deal', () async {
        // Arrange
        final responseData = {
          'Uid': '123',
          'Name': 'Test Deal',
          'Amount': 5000.0,
          'Stage': 'Qualified',
          'AccountUid': '456',
        };
        
        when(mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/deals/123'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.getDeal('123');

        // Assert
        expect(result.uid, equals('123'));
        expect(result.name, equals('Test Deal'));
        expect(result.amount, equals(5000.0));
        expect(result.stage, equals('Qualified'));
        expect(result.accountUid, equals('456'));
      });
      
      test('createDeal should create a deal', () async {
        // Arrange
        final deal = Deal(
          name: 'New Deal',
          amount: 10000.0,
          stage: 'Prospecting',
          accountUid: '456',
        );
        
        final responseData = {
          'Uid': '789',
          'Name': 'New Deal',
          'Amount': 10000.0,
          'Stage': 'Prospecting',
          'AccountUid': '456',
        };
        
        when(mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/deals'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 201));

        // Act
        final result = await crmApi.createDeal(deal);

        // Assert
        expect(result.uid, equals('789'));
        expect(result.name, equals('New Deal'));
        expect(result.amount, equals(10000.0));
        expect(result.stage, equals('Prospecting'));
        expect(result.accountUid, equals('456'));
      });
      
      test('updateDeal should update a deal', () async {
        // Arrange
        final deal = Deal(
          uid: '123',
          name: 'Updated Deal',
          amount: 15000.0,
          stage: 'Closed Won',
          accountUid: '456',
        );
        
        final responseData = {
          'Uid': '123',
          'Name': 'Updated Deal',
          'Amount': 15000.0,
          'Stage': 'Closed Won',
          'AccountUid': '456',
        };
        
        when(mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/deals/123'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

        // Act
        final result = await crmApi.updateDeal(deal);

        // Assert
        expect(result.uid, equals('123'));
        expect(result.name, equals('Updated Deal'));
        expect(result.amount, equals(15000.0));
        expect(result.stage, equals('Closed Won'));
        expect(result.accountUid, equals('456'));
      });
      
      test('updateDeal should throw ArgumentError if uid is null', () async {
        // Arrange
        final deal = Deal(
          name: 'Invalid Deal',
          amount: 5000.0,
          stage: 'Prospecting',
        );
        
        // Act & Assert
        expect(
          () => crmApi.updateDeal(deal),
          throwsA(isA<ArgumentError>()),
        );
      });
      
      test('deleteDeal should delete a deal', () async {
        // Arrange
        when(mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/deals/123'),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response('', 204));

        // Act
        await crmApi.deleteDeal('123');

        // Assert
        verify(mockClient.delete(
          Uri.parse('https://test-domain.outseta.com/api/v1/crm/deals/123'),
          headers: anyNamed('headers'),
        )).called(1);
      });
    });
  });
}