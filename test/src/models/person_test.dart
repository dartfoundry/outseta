import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Person', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'person-123',
        'Email': 'jane.doe@example.com',
        'FirstName': 'Jane',
        'LastName': 'Doe',
        'FullName': 'Jane Doe',
        'EmailConfirmed': true,
        'IsPrimaryContact': true,
        'Title': 'CEO',
        'PhoneNumber': '555-123-4567',
        'AccountUid': 'account-456',
        'SubscriptionUid': 'sub-789',
        'ProfileImageS3Key': 'profiles/jane-doe.jpg',
        'LastLoggedInDate': '2023-01-15T10:30:00Z',
        'MarketingConsent': true,
        'BillingInvoiceEmail': true,
        'CommunicationEmail': true,
        'MarketingEmail': true,
        'CustomFields': {'department': 'Executive', 'employeeId': '1001'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'MailingAddress': {
          'Uid': 'addr-123',
          'AddressLine1': '123 Main St',
          'City': 'San Francisco',
          'State': 'CA',
          'PostalCode': '94105',
          'Country': 'USA'
        },
        'PersonAccount': {
          'AccountUid': 'account-456',
          'Name': 'Acme Inc'
        },
        'DemographicInfo': {
          'Age': 35,
          'Gender': 'Female'
        }
      };

      // Act
      final person = Person.fromJson(json);

      // Assert
      expect(person.uid, equals('person-123'));
      expect(person.email, equals('jane.doe@example.com'));
      expect(person.firstName, equals('Jane'));
      expect(person.lastName, equals('Doe'));
      expect(person.fullName, equals('Jane Doe'));
      expect(person.emailConfirmed, isTrue);
      expect(person.isPrimaryContact, isTrue);
      expect(person.title, equals('CEO'));
      expect(person.phoneNumber, equals('555-123-4567'));
      expect(person.accountUid, equals('account-456'));
      expect(person.subscriptionUid, equals('sub-789'));
      expect(person.profileImageS3Key, equals('profiles/jane-doe.jpg'));
      expect(person.lastLoggedInDate, isA<DateTime>());
      expect(person.marketingConsent, isTrue);
      expect(person.billingInvoiceEmail, isTrue);
      expect(person.communicationEmail, isTrue);
      expect(person.marketingEmail, isTrue);
      expect(person.customFields, equals({'department': 'Executive', 'employeeId': '1001'}));
      expect(person.created, isA<DateTime>());
      expect(person.updated, isA<DateTime>());
      expect(person.createdBy, equals('admin'));
      expect(person.updatedBy, equals('admin'));
      
      // Check nested objects
      expect(person.mailingAddress, isNotNull);
      expect(person.mailingAddress?.addressLine1, equals('123 Main St'));
      expect(person.mailingAddress?.city, equals('San Francisco'));
      
      expect(person.personAccount, isNotNull);
      expect(person.demographicInfo, isNotNull);
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final person = Person(
        uid: 'person-123',
        email: 'jane.doe@example.com',
        firstName: 'Jane',
        lastName: 'Doe',
        fullName: 'Jane Doe',
        emailConfirmed: true,
        isPrimaryContact: true,
        title: 'CEO',
        phoneNumber: '555-123-4567',
        accountUid: 'account-456',
        subscriptionUid: 'sub-789',
        profileImageS3Key: 'profiles/jane-doe.jpg',
        lastLoggedInDate: DateTime.parse('2023-01-15T10:30:00Z'),
        password: 'securePassword123', // Should be included in toJson
        confirmPassword: 'securePassword123', // Should be included in toJson
        marketingConsent: true,
        billingInvoiceEmail: true,
        communicationEmail: true,
        marketingEmail: true,
        customFields: {'department': 'Executive', 'employeeId': '1001'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        mailingAddress: Address(
          uid: 'addr-123',
          addressLine1: '123 Main St',
          city: 'San Francisco',
          state: 'CA',
          postalCode: '94105',
          country: 'USA',
        ),
        personAccount: {
          'AccountUid': 'account-456',
          'Name': 'Acme Inc'
        },
        demographicInfo: {
          'Age': 35,
          'Gender': 'Female'
        },
      );

      // Act
      final json = person.toJson();

      // Assert
      expect(json['Uid'], equals('person-123'));
      expect(json['Email'], equals('jane.doe@example.com'));
      expect(json['FirstName'], equals('Jane'));
      expect(json['LastName'], equals('Doe'));
      expect(json['FullName'], equals('Jane Doe'));
      expect(json['EmailConfirmed'], isTrue);
      expect(json['IsPrimaryContact'], isTrue);
      expect(json['Title'], equals('CEO'));
      expect(json['PhoneNumber'], equals('555-123-4567'));
      expect(json['AccountUid'], equals('account-456'));
      expect(json['SubscriptionUid'], equals('sub-789'));
      expect(json['ProfileImageS3Key'], equals('profiles/jane-doe.jpg'));
      expect(json['LastLoggedInDate'], isA<String>());
      expect(json['Password'], equals('securePassword123'));
      expect(json['ConfirmPassword'], equals('securePassword123'));
      expect(json['MarketingConsent'], isTrue);
      expect(json['BillingInvoiceEmail'], isTrue);
      expect(json['CommunicationEmail'], isTrue);
      expect(json['MarketingEmail'], isTrue);
      expect(json['CustomFields'], equals({'department': 'Executive', 'employeeId': '1001'}));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      
      // Check nested objects
      expect(json['MailingAddress'], isNotNull);
      expect(json['MailingAddress']['AddressLine1'], equals('123 Main St'));
      expect(json['PersonAccount'], isNotNull);
      expect(json['DemographicInfo'], isNotNull);
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final person = Person(
        uid: 'person-123',
        email: 'jane.doe@example.com',
        firstName: 'Jane',
        lastName: 'Doe',
        title: 'Manager',
      );

      // Act
      final updatedPerson = person.copyWith(
        firstName: 'Janet',
        title: 'Director',
        phoneNumber: '555-987-6543',
        mailingAddress: Address(
          addressLine1: '789 New Ave',
          city: 'San Francisco',
        ),
      );

      // Assert
      expect(updatedPerson.uid, equals('person-123')); // Unchanged
      expect(updatedPerson.email, equals('jane.doe@example.com')); // Unchanged
      expect(updatedPerson.firstName, equals('Janet')); // Changed
      expect(updatedPerson.lastName, equals('Doe')); // Unchanged
      expect(updatedPerson.title, equals('Director')); // Changed
      expect(updatedPerson.phoneNumber, equals('555-987-6543')); // Added
      expect(updatedPerson.mailingAddress?.addressLine1, equals('789 New Ave')); // Added
      
      // Verify original is unchanged
      expect(person.firstName, equals('Jane'));
      expect(person.title, equals('Manager'));
      expect(person.phoneNumber, isNull);
      expect(person.mailingAddress, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final person1 = Person(
        uid: 'person-123',
        email: 'jane.doe@example.com',
        firstName: 'Jane',
        lastName: 'Doe',
      );
      
      final person2 = Person(
        uid: 'person-123',
        email: 'jane.doe@example.com',
        firstName: 'Jane',
        lastName: 'Doe',
      );
      
      final person3 = Person(
        uid: 'person-123',
        email: 'jane.doe@example.com',
        firstName: 'Janet', // Different
        lastName: 'Doe',
      );

      // Assert
      expect(person1 == person2, isTrue); // Same values should be equal
      expect(person1 == person3, isFalse); // Different values should not be equal
      
      // Check props content
      expect(person1.props, contains(person1.uid));
      expect(person1.props, contains(person1.email));
      expect(person1.props, contains(person1.firstName));
      expect(person1.props, contains(person1.lastName));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'person-123',
        'Email': 'jane.doe@example.com',
        // Missing or null fields
      };

      // Act
      final person = Person.fromJson(json);

      // Assert
      expect(person.uid, equals('person-123'));
      expect(person.email, equals('jane.doe@example.com'));
      expect(person.firstName, isNull);
      expect(person.lastName, isNull);
      expect(person.fullName, isNull);
      expect(person.emailConfirmed, isNull);
      expect(person.isPrimaryContact, isNull);
      expect(person.mailingAddress, isNull);
      expect(person.title, isNull);
      expect(person.phoneNumber, isNull);
      expect(person.personAccount, isNull);
      expect(person.accountUid, isNull);
      expect(person.subscriptionUid, isNull);
      expect(person.demographicInfo, isNull);
      expect(person.profileImageS3Key, isNull);
      expect(person.lastLoggedInDate, isNull);
      expect(person.password, isNull);
      expect(person.confirmPassword, isNull);
      expect(person.marketingConsent, isNull);
      expect(person.billingInvoiceEmail, isNull);
      expect(person.communicationEmail, isNull);
      expect(person.marketingEmail, isNull);
      expect(person.customFields, isNull);
    });
    
    test('should handle special cases with password fields', () {
      // Arrange
      final person = Person(
        uid: 'person-123',
        email: 'jane.doe@example.com',
        password: 'securePassword',
        confirmPassword: 'securePassword',
      );
      
      // Act
      final json = person.toJson();
      // Password fields should be included in JSON for API calls
      
      // Assert
      expect(json['Password'], equals('securePassword'));
      expect(json['ConfirmPassword'], equals('securePassword'));
      
      // When deserializing, password fields are not included in the response
      final responseJson = {
        'Uid': 'person-123',
        'Email': 'jane.doe@example.com',
        // No password fields
      };
      
      final deserializedPerson = Person.fromJson(responseJson);
      expect(deserializedPerson.password, isNull);
      expect(deserializedPerson.confirmPassword, isNull);
    });
  });
}