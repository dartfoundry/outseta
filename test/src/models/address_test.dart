import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Address', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'addr-123',
        'AddressLine1': '123 Main St',
        'AddressLine2': 'Suite 100',
        'AddressLine3': 'Building A',
        'City': 'San Francisco',
        'State': 'CA',
        'PostalCode': '94105',
        'Country': 'USA',
      };

      // Act
      final address = Address.fromJson(json);

      // Assert
      expect(address.uid, equals('addr-123'));
      expect(address.addressLine1, equals('123 Main St'));
      expect(address.addressLine2, equals('Suite 100'));
      expect(address.addressLine3, equals('Building A'));
      expect(address.city, equals('San Francisco'));
      expect(address.state, equals('CA'));
      expect(address.postalCode, equals('94105'));
      expect(address.country, equals('USA'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final address = Address(
        uid: 'addr-123',
        addressLine1: '123 Main St',
        addressLine2: 'Suite 100',
        addressLine3: 'Building A',
        city: 'San Francisco',
        state: 'CA',
        postalCode: '94105',
        country: 'USA',
      );

      // Act
      final json = address.toJson();

      // Assert
      expect(json['Uid'], equals('addr-123'));
      expect(json['AddressLine1'], equals('123 Main St'));
      expect(json['AddressLine2'], equals('Suite 100'));
      expect(json['AddressLine3'], equals('Building A'));
      expect(json['City'], equals('San Francisco'));
      expect(json['State'], equals('CA'));
      expect(json['PostalCode'], equals('94105'));
      expect(json['Country'], equals('USA'));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final address = Address(
        uid: 'addr-123',
        addressLine1: '123 Main St',
        city: 'San Francisco',
        state: 'CA',
        postalCode: '94105',
        country: 'USA',
      );

      // Act
      final updatedAddress = address.copyWith(
        addressLine1: '456 Market St',
        addressLine2: 'Floor 3',
        city: 'Oakland',
      );

      // Assert
      expect(updatedAddress.uid, equals('addr-123')); // Unchanged
      expect(updatedAddress.addressLine1, equals('456 Market St')); // Changed
      expect(updatedAddress.addressLine2, equals('Floor 3')); // Added
      expect(updatedAddress.city, equals('Oakland')); // Changed
      expect(updatedAddress.state, equals('CA')); // Unchanged
      expect(updatedAddress.postalCode, equals('94105')); // Unchanged
      expect(updatedAddress.country, equals('USA')); // Unchanged

      // Verify original is unchanged
      expect(address.addressLine1, equals('123 Main St'));
      expect(address.addressLine2, isNull);
      expect(address.city, equals('San Francisco'));
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final address1 = Address(
        uid: 'addr-123',
        addressLine1: '123 Main St',
        city: 'San Francisco',
        state: 'CA',
      );

      final address2 = Address(
        uid: 'addr-123',
        addressLine1: '123 Main St',
        city: 'San Francisco',
        state: 'CA',
      );

      final address3 = Address(
        uid: 'addr-123',
        addressLine1: '456 Market St', // Different
        city: 'San Francisco',
        state: 'CA',
      );

      // Assert
      expect(address1 == address2, isTrue); // Same values should be equal
      expect(
        address1 == address3,
        isFalse,
      ); // Different values should not be equal

      // Check props content
      expect(address1.props, contains(address1.uid));
      expect(address1.props, contains(address1.addressLine1));
      expect(address1.props, contains(address1.city));
      expect(address1.props, contains(address1.state));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'addr-123',
        'AddressLine1': '123 Main St',
        // Missing or null fields
      };

      // Act
      final address = Address.fromJson(json);

      // Assert
      expect(address.uid, equals('addr-123'));
      expect(address.addressLine1, equals('123 Main St'));
      expect(address.addressLine2, isNull);
      expect(address.addressLine3, isNull);
      expect(address.city, isNull);
      expect(address.state, isNull);
      expect(address.postalCode, isNull);
      expect(address.country, isNull);
    });

    test('should handle empty address', () {
      // Arrange
      final address = Address(uid: 'addr-123');

      // Act
      final json = address.toJson();
      final deserializedAddress = Address.fromJson(json);

      // Assert
      expect(deserializedAddress.uid, equals('addr-123'));
      expect(deserializedAddress.addressLine1, isNull);
      expect(deserializedAddress.addressLine2, isNull);
      expect(deserializedAddress.addressLine3, isNull);
      expect(deserializedAddress.city, isNull);
      expect(deserializedAddress.state, isNull);
      expect(deserializedAddress.postalCode, isNull);
      expect(deserializedAddress.country, isNull);
    });
  });
}
