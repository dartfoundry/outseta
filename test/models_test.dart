import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Person', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Test',
        'LastName': 'User',
        'FullName': 'Test User',
        'EmailConfirmed': true,
        'IsPrimaryContact': true,
        'Title': 'Developer',
        'PhoneNumber': '555-1234',
        'AccountUid': '456',
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'CustomFields': {'field1': 'value1'},
      };

      // Act
      final person = Person.fromJson(json);

      // Assert
      expect(person.uid, equals('123'));
      expect(person.email, equals('test@example.com'));
      expect(person.firstName, equals('Test'));
      expect(person.lastName, equals('User'));
      expect(person.fullName, equals('Test User'));
      expect(person.emailConfirmed, isTrue);
      expect(person.isPrimaryContact, isTrue);
      expect(person.title, equals('Developer'));
      expect(person.phoneNumber, equals('555-1234'));
      expect(person.accountUid, equals('456'));
      expect(person.created, isA<DateTime>());
      expect(person.updated, isA<DateTime>());
      expect(person.createdBy, equals('admin'));
      expect(person.updatedBy, equals('admin'));
      expect(person.customFields, equals({'field1': 'value1'}));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final person = Person(
        uid: '123',
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
        fullName: 'Test User',
        emailConfirmed: true,
        isPrimaryContact: true,
        title: 'Developer',
        phoneNumber: '555-1234',
        accountUid: '456',
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        customFields: {'field1': 'value1'},
      );

      // Act
      final json = person.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['Email'], equals('test@example.com'));
      expect(json['FirstName'], equals('Test'));
      expect(json['LastName'], equals('User'));
      expect(json['FullName'], equals('Test User'));
      expect(json['EmailConfirmed'], isTrue);
      expect(json['IsPrimaryContact'], isTrue);
      expect(json['Title'], equals('Developer'));
      expect(json['PhoneNumber'], equals('555-1234'));
      expect(json['AccountUid'], equals('456'));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['CustomFields'], equals({'field1': 'value1'}));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final person = Person(
        uid: '123',
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
      );

      // Act
      final updatedPerson = person.copyWith(
        firstName: 'Updated',
        lastName: 'Name',
      );

      // Assert
      expect(updatedPerson.uid, equals('123'));
      expect(updatedPerson.email, equals('test@example.com'));
      expect(updatedPerson.firstName, equals('Updated'));
      expect(updatedPerson.lastName, equals('Name'));
      expect(person.firstName, equals('Test')); // Original unchanged
      expect(person.lastName, equals('User')); // Original unchanged
    });

    test('props should include all properties for equality comparison', () {
      // Arrange
      final person1 = Person(
        uid: '123',
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
      );

      final person2 = Person(
        uid: '123',
        email: 'test@example.com',
        firstName: 'Test',
        lastName: 'User',
      );

      final person3 = Person(
        uid: '123',
        email: 'different@example.com',
        firstName: 'Test',
        lastName: 'User',
      );

      // Assert
      expect(person1, equals(person2));
      expect(person1, isNot(equals(person3)));
    });
  });

  group('Address', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'AddressLine1': '123 Main St',
        'AddressLine2': 'Apt 4B',
        'City': 'New York',
        'State': 'NY',
        'PostalCode': '10001',
        'Country': 'USA',
      };

      // Act
      final address = Address.fromJson(json);

      // Assert
      expect(address.uid, equals('123'));
      expect(address.addressLine1, equals('123 Main St'));
      expect(address.addressLine2, equals('Apt 4B'));
      expect(address.city, equals('New York'));
      expect(address.state, equals('NY'));
      expect(address.postalCode, equals('10001'));
      expect(address.country, equals('USA'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final address = Address(
        uid: '123',
        addressLine1: '123 Main St',
        addressLine2: 'Apt 4B',
        city: 'New York',
        state: 'NY',
        postalCode: '10001',
        country: 'USA',
      );

      // Act
      final json = address.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['AddressLine1'], equals('123 Main St'));
      expect(json['AddressLine2'], equals('Apt 4B'));
      expect(json['City'], equals('New York'));
      expect(json['State'], equals('NY'));
      expect(json['PostalCode'], equals('10001'));
      expect(json['Country'], equals('USA'));
    });
  });

  group('Account', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Name': 'Test Company',
        'PhoneNumber': '555-1234',
        'ClientIdentifier': 'client123',
        'CustomFields': {'industry': 'Technology'},
      };

      // Act
      final account = Account.fromJson(json);

      // Assert
      expect(account.uid, equals('123'));
      expect(account.name, equals('Test Company'));
      expect(account.phoneNumber, equals('555-1234'));
      expect(account.clientIdentifier, equals('client123'));
      expect(account.customFields, equals({'industry': 'Technology'}));
    });
  });

  group('Subscription', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'PlanUid': '456',
        'AccountUid': '789',
        'StartDate': '2023-01-01T00:00:00Z',
        'BillingStart': '2023-01-01T00:00:00Z',
        'BillingRenewalTerm': 'Month',
        'Status': 'Active',
        'Amount': 19.99,
      };

      // Act
      final subscription = Subscription.fromJson(json);

      // Assert
      expect(subscription.uid, equals('123'));
      expect(subscription.planUid, equals('456'));
      expect(subscription.accountUid, equals('789'));
      expect(subscription.startDate, isA<DateTime>());
      expect(subscription.billingStart, isA<DateTime>());
      expect(subscription.billingRenewalTerm, equals('Month'));
      expect(subscription.status, equals('Active'));
      expect(subscription.amount, equals(19.99));
    });
  });

  group('Plan', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Name': 'Basic Plan',
        'Description': 'Basic subscription plan',
        'BillingTerm': 'Month',
        'BillingTermCount': 1,
        'Amount': 19.99,
        'SetupFee': 9.99,
        'TrialPeriodDays': 30,
        'IsActive': true,
        'IsFree': false,
      };

      // Act
      final plan = Plan.fromJson(json);

      // Assert
      expect(plan.uid, equals('123'));
      expect(plan.name, equals('Basic Plan'));
      expect(plan.description, equals('Basic subscription plan'));
      expect(plan.billingTerm, equals('Month'));
      expect(plan.billingTermCount, equals(1));
      expect(plan.amount, equals(19.99));
      expect(plan.setupFee, equals(9.99));
      expect(plan.trialPeriodDays, equals(30));
      expect(plan.isActive, isTrue);
      expect(plan.isFree, isFalse);
    });
  });

  group('Pagination', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {'count': 10, 'limit': 25, 'offset': 0, 'total': 100};

      // Act
      final pagination = Pagination.fromJson(json);

      // Assert
      expect(pagination.count, equals(10));
      expect(pagination.limit, equals(25));
      expect(pagination.offset, equals(0));
      expect(pagination.total, equals(100));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final pagination = Pagination(
        count: 10,
        limit: 25,
        offset: 0,
        total: 100,
      );

      // Act
      final json = pagination.toJson();

      // Assert
      expect(json['count'], equals(10));
      expect(json['limit'], equals(25));
      expect(json['offset'], equals(0));
      expect(json['total'], equals(100));
    });
  });

  group('BaseModel', () {
    test('props should include uid', () {
      // Arrange
      final model1 = Address(uid: '123');
      final model2 = Address(uid: '123');
      final model3 = Address(uid: '456');

      // Assert
      expect(model1, equals(model2));
      expect(model1, isNot(equals(model3)));
    });
  });

  group('BaseModelWithMetadata', () {
    test('props should include metadata fields', () {
      // Arrange
      final created = DateTime.now();
      final updated = DateTime.now();

      final model1 = Person(
        uid: '123',
        created: created,
        updated: updated,
        createdBy: 'user1',
        updatedBy: 'user2',
      );

      final model2 = Person(
        uid: '123',
        created: created,
        updated: updated,
        createdBy: 'user1',
        updatedBy: 'user2',
      );

      final model3 = Person(
        uid: '123',
        created: created,
        updated: DateTime.now().add(Duration(days: 1)),
        createdBy: 'user1',
        updatedBy: 'user3',
      );

      // Assert
      expect(model1, equals(model2));
      expect(model1, isNot(equals(model3)));
    });
  });
}
