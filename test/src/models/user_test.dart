import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'user-123',
        'Username': 'johndoe',
        'Email': 'john.doe@example.com',
        'EmailConfirmed': true,
        'FirstName': 'John',
        'LastName': 'Doe',
        'PhoneNumber': '555-123-4567',
        'PersonUid': 'person-456',
        'ProfileImageS3Key': 'profiles/johndoe.jpg',
        'LastLoggedInDate': '2023-01-15T10:00:00Z',
        'IsAdmin': false,
        'MarketingConsent': true,
        'CustomFields': {'department': 'Sales', 'employeeId': '12345'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'Person': {
          'Uid': 'person-456',
          'Email': 'john.doe@example.com',
          'FirstName': 'John',
          'LastName': 'Doe',
        },
      };

      // Act
      final user = User.fromJson(json);

      // Assert
      expect(user.uid, equals('user-123'));
      expect(user.username, equals('johndoe'));
      expect(user.email, equals('john.doe@example.com'));
      expect(user.emailConfirmed, isTrue);
      expect(user.firstName, equals('John'));
      expect(user.lastName, equals('Doe'));
      expect(user.phoneNumber, equals('555-123-4567'));
      expect(user.personUid, equals('person-456'));
      expect(user.profileImageS3Key, equals('profiles/johndoe.jpg'));
      expect(user.lastLoggedInDate, isA<DateTime>());
      expect(user.isAdmin, isFalse);
      expect(user.marketingConsent, isTrue);
      expect(
        user.customFields,
        equals({'department': 'Sales', 'employeeId': '12345'}),
      );
      expect(user.created, isA<DateTime>());
      expect(user.updated, isA<DateTime>());
      expect(user.createdBy, equals('admin'));
      expect(user.updatedBy, equals('admin'));
      expect(user.person, isNotNull);
      expect(user.person?.email, equals('john.doe@example.com'));
      expect(user.person?.firstName, equals('John'));
      expect(user.person?.lastName, equals('Doe'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final user = User(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        emailConfirmed: true,
        firstName: 'John',
        lastName: 'Doe',
        phoneNumber: '555-123-4567',
        personUid: 'person-456',
        profileImageS3Key: 'profiles/johndoe.jpg',
        lastLoggedInDate: DateTime.parse('2023-01-15T10:00:00Z'),
        isAdmin: false,
        password: 'securePassword', // Should be included in toJson
        confirmPassword: 'securePassword', // Should be included in toJson
        marketingConsent: true,
        customFields: {'department': 'Sales', 'employeeId': '12345'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        person: Person(
          uid: 'person-456',
          email: 'john.doe@example.com',
          firstName: 'John',
          lastName: 'Doe',
        ),
      );

      // Act
      final json = user.toJson();

      // Assert
      expect(json['Uid'], equals('user-123'));
      expect(json['Username'], equals('johndoe'));
      expect(json['Email'], equals('john.doe@example.com'));
      expect(json['EmailConfirmed'], isTrue);
      expect(json['FirstName'], equals('John'));
      expect(json['LastName'], equals('Doe'));
      expect(json['PhoneNumber'], equals('555-123-4567'));
      expect(json['PersonUid'], equals('person-456'));
      expect(json['ProfileImageS3Key'], equals('profiles/johndoe.jpg'));
      expect(json['LastLoggedInDate'], isA<String>());
      expect(json['IsAdmin'], isFalse);
      expect(json['Password'], equals('securePassword'));
      expect(json['ConfirmPassword'], equals('securePassword'));
      expect(json['MarketingConsent'], isTrue);
      expect(
        json['CustomFields'],
        equals({'department': 'Sales', 'employeeId': '12345'}),
      );
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['Person'], isNotNull);
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final user = User(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      // Act
      final updatedUser = user.copyWith(
        firstName: 'Jonathan',
        lastName: 'Smith',
        phoneNumber: '555-987-6543',
        isAdmin: true,
      );

      // Assert
      expect(updatedUser.uid, equals('user-123')); // Unchanged
      expect(updatedUser.username, equals('johndoe')); // Unchanged
      expect(updatedUser.email, equals('john.doe@example.com')); // Unchanged
      expect(updatedUser.firstName, equals('Jonathan')); // Changed
      expect(updatedUser.lastName, equals('Smith')); // Changed
      expect(updatedUser.phoneNumber, equals('555-987-6543')); // Added
      expect(updatedUser.isAdmin, isTrue); // Added

      // Verify original is unchanged
      expect(user.firstName, equals('John'));
      expect(user.lastName, equals('Doe'));
      expect(user.phoneNumber, isNull);
      expect(user.isAdmin, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final user1 = User(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      final user2 = User(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      final user3 = User(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'Jonathan', // Different
        lastName: 'Doe',
      );

      // Assert
      expect(user1 == user2, isTrue); // Same values should be equal
      expect(user1 == user3, isFalse); // Different values should not be equal

      // Check props content
      expect(user1.props, contains(user1.uid));
      expect(user1.props, contains(user1.username));
      expect(user1.props, contains(user1.email));
      expect(user1.props, contains(user1.firstName));
      expect(user1.props, contains(user1.lastName));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'user-123',
        'Username': 'johndoe',
        // Missing or null fields
      };

      // Act
      final user = User.fromJson(json);

      // Assert
      expect(user.uid, equals('user-123'));
      expect(user.username, equals('johndoe'));
      expect(user.email, isNull);
      expect(user.emailConfirmed, isNull);
      expect(user.firstName, isNull);
      expect(user.lastName, isNull);
      expect(user.phoneNumber, isNull);
      expect(user.personUid, isNull);
      expect(user.profileImageS3Key, isNull);
      expect(user.lastLoggedInDate, isNull);
      expect(user.isAdmin, isNull);
      expect(user.password, isNull);
      expect(user.confirmPassword, isNull);
      expect(user.marketingConsent, isNull);
      expect(user.customFields, isNull);
      expect(user.person, isNull);
    });

    test('should handle special cases with password fields', () {
      // Arrange
      final user = User(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        password: 'securePassword',
        confirmPassword: 'securePassword',
      );

      // Act
      final json = user.toJson();
      // Password fields should be included in JSON for API calls

      // Assert
      expect(json['Password'], equals('securePassword'));
      expect(json['ConfirmPassword'], equals('securePassword'));

      // When deserializing, password fields are not included in the response
      final responseJson = {
        'Uid': 'user-123',
        'Username': 'johndoe',
        'Email': 'john.doe@example.com',
        // No password fields
      };

      final deserializedUser = User.fromJson(responseJson);
      expect(deserializedUser.password, isNull);
      expect(deserializedUser.confirmPassword, isNull);
    });
  });
}
