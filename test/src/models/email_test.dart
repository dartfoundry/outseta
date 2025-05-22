import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Email', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'email-123',
        'Subject': 'Monthly Newsletter',
        'FromName': 'Company Name',
        'FromEmail': 'newsletter@example.com',
        'ReplyToEmail': 'support@example.com',
        'Content': '<h1>Newsletter</h1><p>This is the newsletter content.</p>',
        'Status': 'Draft',
        'ScheduledDate': '2023-01-15T10:00:00Z',
        'SentDate': null,
        'OpenCount': 0,
        'ClickCount': 0,
        'EmailListUid': 'list-456',
        'PersonSegmentUid': 'segment-789',
        'CustomFields': {'campaign': 'January2023'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'EmailList': {
          'Uid': 'list-456',
          'Name': 'Newsletter Subscribers',
          'SubscriberCount': 1250,
        },
      };

      // Act
      final email = Email.fromJson(json);

      // Assert
      expect(email.uid, equals('email-123'));
      expect(email.subject, equals('Monthly Newsletter'));
      expect(email.fromName, equals('Company Name'));
      expect(email.fromEmail, equals('newsletter@example.com'));
      expect(email.replyToEmail, equals('support@example.com'));
      expect(email.content, equals('<h1>Newsletter</h1><p>This is the newsletter content.</p>'));
      expect(email.status, equals('Draft'));
      expect(email.scheduledDate, isA<DateTime>());
      expect(email.sentDate, isNull);
      expect(email.openCount, equals(0));
      expect(email.clickCount, equals(0));
      expect(email.emailListUid, equals('list-456'));
      expect(email.personSegmentUid, equals('segment-789'));
      expect(email.customFields, equals({'campaign': 'January2023'}));
      expect(email.created, isA<DateTime>());
      expect(email.updated, isA<DateTime>());
      expect(email.createdBy, equals('admin'));
      expect(email.updatedBy, equals('admin'));
      expect(email.emailList, isNotNull);
      expect(email.emailList?.uid, equals('list-456'));
      expect(email.emailList?.name, equals('Newsletter Subscribers'));
      expect(email.emailList?.subscriberCount, equals(1250));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final email = Email(
        uid: 'email-123',
        subject: 'Monthly Newsletter',
        fromName: 'Company Name',
        fromEmail: 'newsletter@example.com',
        replyToEmail: 'support@example.com',
        content: '<h1>Newsletter</h1><p>This is the newsletter content.</p>',
        status: 'Draft',
        scheduledDate: DateTime.parse('2023-01-15T10:00:00Z'),
        openCount: 0,
        clickCount: 0,
        emailListUid: 'list-456',
        personSegmentUid: 'segment-789',
        customFields: {'campaign': 'January2023'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        emailList: EmailList(
          uid: 'list-456',
          name: 'Newsletter Subscribers',
          subscriberCount: 1250,
        ),
      );

      // Act
      final json = email.toJson();

      // Assert
      expect(json['Uid'], equals('email-123'));
      expect(json['Subject'], equals('Monthly Newsletter'));
      expect(json['FromName'], equals('Company Name'));
      expect(json['FromEmail'], equals('newsletter@example.com'));
      expect(json['ReplyToEmail'], equals('support@example.com'));
      expect(json['Content'], equals('<h1>Newsletter</h1><p>This is the newsletter content.</p>'));
      expect(json['Status'], equals('Draft'));
      expect(json['ScheduledDate'], isA<String>());
      expect(json['SentDate'], isNull);
      expect(json['OpenCount'], equals(0));
      expect(json['ClickCount'], equals(0));
      expect(json['EmailListUid'], equals('list-456'));
      expect(json['PersonSegmentUid'], equals('segment-789'));
      expect(json['CustomFields'], equals({'campaign': 'January2023'}));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['EmailList'], isNotNull);
      expect(json['EmailList']['Uid'], equals('list-456'));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final email = Email(
        uid: 'email-123',
        subject: 'Monthly Newsletter',
        status: 'Draft',
        scheduledDate: DateTime.parse('2023-01-15T10:00:00Z'),
      );

      // Act
      final updatedEmail = email.copyWith(
        subject: 'Updated Newsletter',
        status: 'Scheduled',
        sentDate: DateTime.parse('2023-01-15T12:00:00Z'),
      );

      // Assert
      expect(updatedEmail.uid, equals('email-123')); // Unchanged
      expect(updatedEmail.subject, equals('Updated Newsletter')); // Changed
      expect(updatedEmail.status, equals('Scheduled')); // Changed
      expect(updatedEmail.scheduledDate, equals(DateTime.parse('2023-01-15T10:00:00Z'))); // Unchanged
      expect(updatedEmail.sentDate, equals(DateTime.parse('2023-01-15T12:00:00Z'))); // Added
      
      // Verify original is unchanged
      expect(email.subject, equals('Monthly Newsletter'));
      expect(email.status, equals('Draft'));
      expect(email.sentDate, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final email1 = Email(
        uid: 'email-123',
        subject: 'Monthly Newsletter',
        status: 'Draft',
      );
      
      final email2 = Email(
        uid: 'email-123',
        subject: 'Monthly Newsletter',
        status: 'Draft',
      );
      
      final email3 = Email(
        uid: 'email-123',
        subject: 'Different Newsletter', // Different
        status: 'Draft',
      );

      // Assert
      expect(email1 == email2, isTrue); // Same values should be equal
      expect(email1 == email3, isFalse); // Different values should not be equal
      
      // Check props content
      expect(email1.props, contains(email1.uid));
      expect(email1.props, contains(email1.subject));
      expect(email1.props, contains(email1.status));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'email-123',
        'Subject': 'Monthly Newsletter',
        // Missing or null fields
      };

      // Act
      final email = Email.fromJson(json);

      // Assert
      expect(email.uid, equals('email-123'));
      expect(email.subject, equals('Monthly Newsletter'));
      expect(email.fromName, isNull);
      expect(email.fromEmail, isNull);
      expect(email.replyToEmail, isNull);
      expect(email.content, isNull);
      expect(email.status, isNull);
      expect(email.scheduledDate, isNull);
      expect(email.sentDate, isNull);
      expect(email.openCount, isNull);
      expect(email.clickCount, isNull);
      expect(email.emailListUid, isNull);
      expect(email.personSegmentUid, isNull);
      expect(email.customFields, isNull);
      expect(email.emailList, isNull);
    });
    
    test('should handle different status values', () {
      // Test various status values
      final statuses = ['Draft', 'Scheduled', 'Sending', 'Sent', 'Failed'];
      
      for (final status in statuses) {
        // Arrange
        final email = Email(
          uid: 'email-123',
          subject: 'Monthly Newsletter',
          status: status,
        );
        
        // Act
        final json = email.toJson();
        final deserialized = Email.fromJson(json);
        
        // Assert
        expect(deserialized.status, equals(status));
      }
    });
  });
}