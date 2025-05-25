import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Metadata', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'user123',
      };

      // Act
      final metadata = Metadata.fromJson(json);

      // Assert
      expect(metadata.created, isA<DateTime>());
      expect(metadata.created, equals(DateTime.parse('2023-01-01T00:00:00Z')));
      expect(metadata.updated, isA<DateTime>());
      expect(metadata.updated, equals(DateTime.parse('2023-01-02T00:00:00Z')));
      expect(metadata.createdBy, equals('admin'));
      expect(metadata.updatedBy, equals('user123'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final metadata = Metadata(
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'user123',
      );

      // Act
      final json = metadata.toJson();

      // Assert
      expect(json['Created'], equals('2023-01-01T00:00:00.000Z'));
      expect(json['Updated'], equals('2023-01-02T00:00:00.000Z'));
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('user123'));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Created': '2023-01-01T00:00:00Z',
        // Missing or null fields
      };

      // Act
      final metadata = Metadata.fromJson(json);

      // Assert
      expect(metadata.created, isA<DateTime>());
      expect(metadata.updated, isNull);
      expect(metadata.createdBy, isNull);
      expect(metadata.updatedBy, isNull);
    });

    test('should handle empty constructor', () {
      // Arrange & Act
      final metadata = Metadata();

      // Assert
      expect(metadata.created, isNull);
      expect(metadata.updated, isNull);
      expect(metadata.createdBy, isNull);
      expect(metadata.updatedBy, isNull);
    });

    test('should handle serialization with partial fields', () {
      // Arrange
      final metadata = Metadata(
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        createdBy: 'admin',
        // No updated or updatedBy
      );

      // Act
      final json = metadata.toJson();
      final deserializedMetadata = Metadata.fromJson(json);

      // Assert
      expect(
        deserializedMetadata.created,
        equals(DateTime.parse('2023-01-01T00:00:00Z')),
      );
      expect(deserializedMetadata.createdBy, equals('admin'));
      expect(deserializedMetadata.updated, isNull);
      expect(deserializedMetadata.updatedBy, isNull);
    });
  });
}
