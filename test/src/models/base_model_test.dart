import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

// Create a concrete implementation of BaseModel for testing
class TestModel extends BaseModel {
  const TestModel({super.uid});
  
  @override
  Map<String, dynamic> toJson() => {'Uid': uid};
}

// Create a concrete implementation of BaseModelWithMetadata for testing
class TestModelWithMetadata extends BaseModelWithMetadata {
  const TestModelWithMetadata({
    super.uid, 
    super.created, 
    super.updated, 
    super.createdBy, 
    super.updatedBy,
    this.name,
  });
  
  final String? name;
  
  @override
  Map<String, dynamic> toJson() => {
    'Uid': uid,
    'Created': created?.toIso8601String(),
    'Updated': updated?.toIso8601String(),
    'CreatedBy': createdBy,
    'UpdatedBy': updatedBy,
    'Name': name,
  };
  
  @override
  List<Object?> get props => [...super.props, name];
}

void main() {
  group('BaseModel', () {
    test('props should include uid', () {
      // Arrange
      final model = TestModel(uid: 'test-123');
      
      // Assert
      expect(model.props, contains('test-123'));
      expect(model.props.length, equals(1));
    });
    
    test('equality should work correctly', () {
      // Arrange
      final model1 = TestModel(uid: 'test-123');
      final model2 = TestModel(uid: 'test-123');
      final model3 = TestModel(uid: 'test-456');
      
      // Assert
      expect(model1 == model2, isTrue);
      expect(model1 == model3, isFalse);
    });
    
    test('toJson should convert model to JSON map', () {
      // Arrange
      final model = TestModel(uid: 'test-123');
      
      // Act
      final json = model.toJson();
      
      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['Uid'], equals('test-123'));
    });
    
    test('should handle null uid', () {
      // Arrange
      final model = TestModel();
      
      // Act
      final json = model.toJson();
      
      // Assert
      expect(json['Uid'], isNull);
    });
  });
  
  group('BaseModelWithMetadata', () {
    test('props should include metadata fields', () {
      // Arrange
      final created = DateTime.parse('2023-01-01T00:00:00Z');
      final updated = DateTime.parse('2023-01-02T00:00:00Z');
      final model = TestModelWithMetadata(
        uid: 'test-123',
        created: created,
        updated: updated,
        createdBy: 'admin',
        updatedBy: 'admin',
        name: 'Test Model',
      );
      
      // Assert
      expect(model.props, contains('test-123'));
      expect(model.props, contains(created));
      expect(model.props, contains(updated));
      expect(model.props, contains('admin')); // CreatedBy
      expect(model.props, contains('admin')); // UpdatedBy
      expect(model.props, contains('Test Model')); // Custom property
    });
    
    test('equality should work correctly with metadata', () {
      // Arrange
      final created1 = DateTime.parse('2023-01-01T00:00:00Z');
      final created2 = DateTime.parse('2023-01-01T01:00:00Z'); // Different time
      
      final model1 = TestModelWithMetadata(
        uid: 'test-123',
        created: created1,
        createdBy: 'admin',
      );
      
      final model2 = TestModelWithMetadata(
        uid: 'test-123',
        created: created1, // Same time
        createdBy: 'admin',
      );
      
      final model3 = TestModelWithMetadata(
        uid: 'test-123',
        created: created2, // Different time
        createdBy: 'admin',
      );
      
      // Assert
      expect(model1 == model2, isTrue);
      expect(model1 == model3, isFalse); // Different due to created time
    });
    
    test('toJson should convert metadata to JSON map', () {
      // Arrange
      final created = DateTime.parse('2023-01-01T00:00:00Z');
      final updated = DateTime.parse('2023-01-02T00:00:00Z');
      final model = TestModelWithMetadata(
        uid: 'test-123',
        created: created,
        updated: updated,
        createdBy: 'admin',
        updatedBy: 'admin',
        name: 'Test Model',
      );
      
      // Act
      final json = model.toJson();
      
      // Assert
      expect(json, isA<Map<String, dynamic>>());
      expect(json['Uid'], equals('test-123'));
      expect(json['Created'], equals(created.toIso8601String()));
      expect(json['Updated'], equals(updated.toIso8601String()));
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['Name'], equals('Test Model'));
    });
    
    test('should handle null metadata fields', () {
      // Arrange
      final model = TestModelWithMetadata(
        uid: 'test-123',
        // All metadata fields are null
      );
      
      // Act
      final json = model.toJson();
      
      // Assert
      expect(json['Uid'], equals('test-123'));
      expect(json['Created'], isNull);
      expect(json['Updated'], isNull);
      expect(json['CreatedBy'], isNull);
      expect(json['UpdatedBy'], isNull);
    });
  });
}