import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('EmailList', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'list-123',
        'Name': 'Newsletter Subscribers',
        'Description': 'People who want to receive our newsletter',
        'SubscriberCount': 1250,
        'CustomFields': {'category': 'marketing', 'isActive': true},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
      };

      // Act
      final emailList = EmailList.fromJson(json);

      // Assert
      expect(emailList.uid, equals('list-123'));
      expect(emailList.name, equals('Newsletter Subscribers'));
      expect(emailList.description, equals('People who want to receive our newsletter'));
      expect(emailList.subscriberCount, equals(1250));
      expect(emailList.customFields, equals({'category': 'marketing', 'isActive': true}));
      expect(emailList.created, isA<DateTime>());
      expect(emailList.updated, isA<DateTime>());
      expect(emailList.createdBy, equals('admin'));
      expect(emailList.updatedBy, equals('admin'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final emailList = EmailList(
        uid: 'list-123',
        name: 'Newsletter Subscribers',
        description: 'People who want to receive our newsletter',
        subscriberCount: 1250,
        customFields: {'category': 'marketing', 'isActive': true},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
      );

      // Act
      final json = emailList.toJson();

      // Assert
      expect(json['Uid'], equals('list-123'));
      expect(json['Name'], equals('Newsletter Subscribers'));
      expect(json['Description'], equals('People who want to receive our newsletter'));
      expect(json['SubscriberCount'], equals(1250));
      expect(json['CustomFields'], equals({'category': 'marketing', 'isActive': true}));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final emailList = EmailList(
        uid: 'list-123',
        name: 'Newsletter Subscribers',
        description: 'People who want to receive our newsletter',
        subscriberCount: 1250,
      );

      // Act
      final updatedEmailList = emailList.copyWith(
        name: 'VIP Subscribers',
        subscriberCount: 500,
        customFields: {'type': 'vip'},
      );

      // Assert
      expect(updatedEmailList.uid, equals('list-123')); // Unchanged
      expect(updatedEmailList.description, equals('People who want to receive our newsletter')); // Unchanged
      expect(updatedEmailList.name, equals('VIP Subscribers')); // Changed
      expect(updatedEmailList.subscriberCount, equals(500)); // Changed
      expect(updatedEmailList.customFields, equals({'type': 'vip'})); // Added
      
      // Verify original is unchanged
      expect(emailList.name, equals('Newsletter Subscribers'));
      expect(emailList.subscriberCount, equals(1250));
      expect(emailList.customFields, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final emailList1 = EmailList(
        uid: 'list-123',
        name: 'Newsletter Subscribers',
        subscriberCount: 1250,
      );
      
      final emailList2 = EmailList(
        uid: 'list-123',
        name: 'Newsletter Subscribers',
        subscriberCount: 1250,
      );
      
      final emailList3 = EmailList(
        uid: 'list-123',
        name: 'Newsletter Subscribers',
        subscriberCount: 2000, // Different
      );

      // Assert
      expect(emailList1 == emailList2, isTrue); // Same values should be equal
      expect(emailList1 == emailList3, isFalse); // Different values should not be equal
      
      // Check props content
      expect(emailList1.props, contains(emailList1.uid));
      expect(emailList1.props, contains(emailList1.name));
      expect(emailList1.props, contains(emailList1.subscriberCount));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'list-123',
        'Name': 'Newsletter Subscribers',
        // Missing or null fields
      };

      // Act
      final emailList = EmailList.fromJson(json);

      // Assert
      expect(emailList.uid, equals('list-123'));
      expect(emailList.name, equals('Newsletter Subscribers'));
      expect(emailList.description, isNull);
      expect(emailList.subscriberCount, isNull);
      expect(emailList.customFields, isNull);
      expect(emailList.created, isNull);
      expect(emailList.updated, isNull);
      expect(emailList.createdBy, isNull);
      expect(emailList.updatedBy, isNull);
    });
    
    test('should handle empty subscriber count', () {
      // Arrange
      final emailList = EmailList(
        uid: 'list-123',
        name: 'New List',
        subscriberCount: 0,
      );
      
      // Act
      final json = emailList.toJson();
      final deserialized = EmailList.fromJson(json);
      
      // Assert
      expect(deserialized.subscriberCount, equals(0));
    });
  });
}