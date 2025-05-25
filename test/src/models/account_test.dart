import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Account', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123-456-789',
        'Name': 'Test Company',
        'PhoneNumber': '555-123-4567',
        'ClientIdentifier': 'client-123',
        'DealUid': 'deal-789',
        'PlanUid': 'plan-456',
        'CancellationReason': 'Switched providers',
        'CustomFields': {'industry': 'Technology', 'size': 'Enterprise'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'BillingAddress': {
          'Uid': 'addr-123',
          'AddressLine1': '123 Main St',
          'AddressLine2': 'Suite 100',
          'City': 'San Francisco',
          'State': 'CA',
          'PostalCode': '94105',
          'Country': 'USA',
        },
        'MailingAddress': {
          'Uid': 'addr-456',
          'AddressLine1': '456 Market St',
          'City': 'San Francisco',
          'State': 'CA',
          'PostalCode': '94105',
          'Country': 'USA',
        },
        'PrimaryContact': {
          'Uid': 'person-123',
          'Email': 'contact@example.com',
          'FirstName': 'Jane',
          'LastName': 'Doe',
          'Title': 'CEO',
        },
        'People': [
          {
            'Uid': 'person-123',
            'Email': 'contact@example.com',
            'FirstName': 'Jane',
            'LastName': 'Doe',
          },
          {
            'Uid': 'person-456',
            'Email': 'employee@example.com',
            'FirstName': 'John',
            'LastName': 'Smith',
          },
        ],
        'Subscriptions': [
          {'Uid': 'sub-123', 'PlanUid': 'plan-456', 'Status': 'Active'},
        ],
      };

      // Act
      final account = Account.fromJson(json);

      // Assert
      expect(account.uid, equals('123-456-789'));
      expect(account.name, equals('Test Company'));
      expect(account.phoneNumber, equals('555-123-4567'));
      expect(account.clientIdentifier, equals('client-123'));
      expect(account.dealUid, equals('deal-789'));
      expect(account.planUid, equals('plan-456'));
      expect(account.cancellationReason, equals('Switched providers'));
      expect(
        account.customFields,
        equals({'industry': 'Technology', 'size': 'Enterprise'}),
      );
      expect(account.created, isA<DateTime>());
      expect(account.updated, isA<DateTime>());
      expect(account.createdBy, equals('admin'));
      expect(account.updatedBy, equals('admin'));

      // Check nested objects
      expect(account.billingAddress, isNotNull);
      expect(account.billingAddress?.addressLine1, equals('123 Main St'));
      expect(account.billingAddress?.addressLine2, equals('Suite 100'));
      expect(account.billingAddress?.city, equals('San Francisco'));

      expect(account.mailingAddress, isNotNull);
      expect(account.mailingAddress?.addressLine1, equals('456 Market St'));

      expect(account.primaryContact, isNotNull);
      expect(account.primaryContact?.email, equals('contact@example.com'));
      expect(account.primaryContact?.firstName, equals('Jane'));

      expect(account.people, isNotNull);
      expect(account.people?.length, equals(2));
      expect(account.people?[0].email, equals('contact@example.com'));

      expect(account.subscriptions, isNotNull);
      expect(account.subscriptions?.length, equals(1));
      expect(account.subscriptions?[0].planUid, equals('plan-456'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final account = Account(
        uid: '123-456-789',
        name: 'Test Company',
        phoneNumber: '555-123-4567',
        clientIdentifier: 'client-123',
        dealUid: 'deal-789',
        planUid: 'plan-456',
        cancellationReason: 'Switched providers',
        customFields: {'industry': 'Technology', 'size': 'Enterprise'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        billingAddress: Address(
          uid: 'addr-123',
          addressLine1: '123 Main St',
          addressLine2: 'Suite 100',
          city: 'San Francisco',
          state: 'CA',
          postalCode: '94105',
          country: 'USA',
        ),
        mailingAddress: Address(
          uid: 'addr-456',
          addressLine1: '456 Market St',
          city: 'San Francisco',
          state: 'CA',
          postalCode: '94105',
          country: 'USA',
        ),
        primaryContact: Person(
          uid: 'person-123',
          email: 'contact@example.com',
          firstName: 'Jane',
          lastName: 'Doe',
          title: 'CEO',
        ),
        people: [
          Person(
            uid: 'person-123',
            email: 'contact@example.com',
            firstName: 'Jane',
            lastName: 'Doe',
          ),
          Person(
            uid: 'person-456',
            email: 'employee@example.com',
            firstName: 'John',
            lastName: 'Smith',
          ),
        ],
        subscriptions: [
          Subscription(uid: 'sub-123', planUid: 'plan-456', status: 'Active'),
        ],
      );

      // Act
      final json = account.toJson();

      // Assert
      expect(json['Uid'], equals('123-456-789'));
      expect(json['Name'], equals('Test Company'));
      expect(json['PhoneNumber'], equals('555-123-4567'));
      expect(json['ClientIdentifier'], equals('client-123'));
      expect(json['DealUid'], equals('deal-789'));
      expect(json['PlanUid'], equals('plan-456'));
      expect(json['CancellationReason'], equals('Switched providers'));
      expect(
        json['CustomFields'],
        equals({'industry': 'Technology', 'size': 'Enterprise'}),
      );
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));

      // Check nested objects
      expect(json['BillingAddress'], isNotNull);
      expect(json['BillingAddress']['AddressLine1'], equals('123 Main St'));
      expect(json['BillingAddress']['AddressLine2'], equals('Suite 100'));

      expect(json['MailingAddress'], isNotNull);
      expect(json['MailingAddress']['AddressLine1'], equals('456 Market St'));

      expect(json['PrimaryContact'], isNotNull);
      expect(json['PrimaryContact']['Email'], equals('contact@example.com'));

      expect(json['People'], isNotNull);
      expect(json['People'].length, equals(2));

      expect(json['Subscriptions'], isNotNull);
      expect(json['Subscriptions'].length, equals(1));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final account = Account(
        uid: '123-456-789',
        name: 'Test Company',
        phoneNumber: '555-123-4567',
        billingAddress: Address(
          addressLine1: '123 Main St',
          city: 'San Francisco',
        ),
      );

      // Act
      final updatedAccount = account.copyWith(
        name: 'Updated Company',
        phoneNumber: '555-987-6543',
        billingAddress: Address(
          addressLine1: '789 New Ave',
          city: 'San Francisco',
        ),
        customFields: {'industry': 'Healthcare'},
      );

      // Assert
      expect(updatedAccount.uid, equals('123-456-789')); // Unchanged
      expect(updatedAccount.name, equals('Updated Company')); // Changed
      expect(updatedAccount.phoneNumber, equals('555-987-6543')); // Changed
      expect(
        updatedAccount.billingAddress?.addressLine1,
        equals('789 New Ave'),
      ); // Changed
      expect(
        updatedAccount.customFields,
        equals({'industry': 'Healthcare'}),
      ); // Added

      // Verify original is unchanged
      expect(account.name, equals('Test Company'));
      expect(account.phoneNumber, equals('555-123-4567'));
      expect(account.billingAddress?.addressLine1, equals('123 Main St'));
      expect(account.customFields, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final account1 = Account(
        uid: '123',
        name: 'Test Company',
        phoneNumber: '555-123-4567',
      );

      final account2 = Account(
        uid: '123',
        name: 'Test Company',
        phoneNumber: '555-123-4567',
      );

      final account3 = Account(
        uid: '123',
        name: 'Different Company',
        phoneNumber: '555-123-4567',
      );

      // Assert
      expect(account1 == account2, isTrue); // Same values should be equal
      expect(
        account1 == account3,
        isFalse,
      ); // Different values should not be equal

      // Check props content
      expect(account1.props, contains(account1.uid));
      expect(account1.props, contains(account1.name));
      expect(account1.props, contains(account1.phoneNumber));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Name': 'Test Company',
        // Missing or null fields
      };

      // Act
      final account = Account.fromJson(json);

      // Assert
      expect(account.uid, equals('123'));
      expect(account.name, equals('Test Company'));
      expect(account.billingAddress, isNull);
      expect(account.mailingAddress, isNull);
      expect(account.phoneNumber, isNull);
      expect(account.subscriptions, isNull);
      expect(account.people, isNull);
      expect(account.primaryContact, isNull);
      expect(account.clientIdentifier, isNull);
      expect(account.dealUid, isNull);
      expect(account.planUid, isNull);
      expect(account.cancellationReason, isNull);
      expect(account.customFields, isNull);
    });
  });
}
