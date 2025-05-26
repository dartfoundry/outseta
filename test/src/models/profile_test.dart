import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Profile', () {
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
      final profile = Profile.fromJson(json);

      // Assert
      expect(profile.uid, equals('user-123'));
      expect(profile.username, equals('johndoe'));
      expect(profile.email, equals('john.doe@example.com'));
      expect(profile.emailConfirmed, isTrue);
      expect(profile.firstName, equals('John'));
      expect(profile.lastName, equals('Doe'));
      expect(profile.phoneNumber, equals('555-123-4567'));
      expect(profile.personUid, equals('person-456'));
      expect(profile.profileImageS3Key, equals('profiles/johndoe.jpg'));
      expect(profile.lastLoggedInDate, isA<DateTime>());
      expect(profile.isAdmin, isFalse);
      expect(profile.marketingConsent, isTrue);
      expect(
        profile.customFields,
        equals({'department': 'Sales', 'employeeId': '12345'}),
      );
      expect(profile.created, isA<DateTime>());
      expect(profile.updated, isA<DateTime>());
      expect(profile.createdBy, equals('admin'));
      expect(profile.updatedBy, equals('admin'));
      expect(profile.person, isNotNull);
      expect(profile.person?.email, equals('john.doe@example.com'));
      expect(profile.person?.firstName, equals('John'));
      expect(profile.person?.lastName, equals('Doe'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final profile = Profile(
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
      final json = profile.toJson();

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
      final profile = Profile(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      // Act
      final updatedProfile = profile.copyWith(
        firstName: 'Jonathan',
        lastName: 'Smith',
        phoneNumber: '555-987-6543',
        isAdmin: true,
      );

      // Assert
      expect(updatedProfile.uid, equals('user-123')); // Unchanged
      expect(updatedProfile.username, equals('johndoe')); // Unchanged
      expect(updatedProfile.email, equals('john.doe@example.com')); // Unchanged
      expect(updatedProfile.firstName, equals('Jonathan')); // Changed
      expect(updatedProfile.lastName, equals('Smith')); // Changed
      expect(updatedProfile.phoneNumber, equals('555-987-6543')); // Added
      expect(updatedProfile.isAdmin, isTrue); // Added

      // Verify original is unchanged
      expect(profile.firstName, equals('John'));
      expect(profile.lastName, equals('Doe'));
      expect(profile.phoneNumber, isNull);
      expect(profile.isAdmin, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final profile1 = Profile(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      final profile2 = Profile(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'John',
        lastName: 'Doe',
      );

      final profile3 = Profile(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        firstName: 'Jonathan', // Different
        lastName: 'Doe',
      );

      // Assert
      expect(profile1 == profile2, isTrue); // Same values should be equal
      expect(profile1 == profile3, isFalse); // Different values should not be equal

      // Check props content
      expect(profile1.props, contains(profile1.uid));
      expect(profile1.props, contains(profile1.username));
      expect(profile1.props, contains(profile1.email));
      expect(profile1.props, contains(profile1.firstName));
      expect(profile1.props, contains(profile1.lastName));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'user-123',
        'Username': 'johndoe',
        // Missing or null fields
      };

      // Act
      final profile = Profile.fromJson(json);

      // Assert
      expect(profile.uid, equals('user-123'));
      expect(profile.username, equals('johndoe'));
      expect(profile.email, isNull);
      expect(profile.emailConfirmed, isNull);
      expect(profile.firstName, isNull);
      expect(profile.lastName, isNull);
      expect(profile.phoneNumber, isNull);
      expect(profile.personUid, isNull);
      expect(profile.profileImageS3Key, isNull);
      expect(profile.lastLoggedInDate, isNull);
      expect(profile.isAdmin, isNull);
      expect(profile.password, isNull);
      expect(profile.confirmPassword, isNull);
      expect(profile.marketingConsent, isNull);
      expect(profile.customFields, isNull);
      expect(profile.person, isNull);
    });

    test('should handle special cases with password fields', () {
      // Arrange
      final profile = Profile(
        uid: 'user-123',
        username: 'johndoe',
        email: 'john.doe@example.com',
        password: 'securePassword',
        confirmPassword: 'securePassword',
      );

      // Act
      final json = profile.toJson();
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

      final deserializedProfile = Profile.fromJson(responseJson);
      expect(deserializedProfile.password, isNull);
      expect(deserializedProfile.confirmPassword, isNull);
    });
  });
}