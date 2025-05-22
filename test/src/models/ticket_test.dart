import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Ticket', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'ticket-123',
        'Subject': 'Help with subscription',
        'Description': 'I need help with my subscription',
        'Status': 'Open',
        'Priority': 'Medium',
        'RequesterPersonUid': 'person-456',
        'AssignedToPersonUid': 'person-789',
        'AccountUid': 'account-012',
        'Source': 'Email',
        'CustomFields': {'category': 'billing', 'importance': 'high'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'RequesterPerson': {
          'Uid': 'person-456',
          'Email': 'customer@example.com',
          'FirstName': 'John',
          'LastName': 'Doe',
        },
        'AssignedToPerson': {
          'Uid': 'person-789',
          'Email': 'agent@example.com',
          'FirstName': 'Jane',
          'LastName': 'Smith',
        },
        'Comments': [
          {
            'Comment': 'This is a comment',
            'IsPrivate': false,
            'PersonUid': 'person-456',
            'Created': '2023-01-02T00:00:00Z',
          }
        ],
      };

      // Act
      final ticket = Ticket.fromJson(json);

      // Assert
      expect(ticket.uid, equals('ticket-123'));
      expect(ticket.subject, equals('Help with subscription'));
      expect(ticket.description, equals('I need help with my subscription'));
      expect(ticket.status, equals('Open'));
      expect(ticket.priority, equals('Medium'));
      expect(ticket.requesterPersonUid, equals('person-456'));
      expect(ticket.assignedToPersonUid, equals('person-789'));
      expect(ticket.accountUid, equals('account-012'));
      expect(ticket.source, equals('Email'));
      expect(ticket.customFields, equals({'category': 'billing', 'importance': 'high'}));
      expect(ticket.created, isA<DateTime>());
      expect(ticket.updated, isA<DateTime>());
      expect(ticket.createdBy, equals('admin'));
      expect(ticket.updatedBy, equals('admin'));
      expect(ticket.requesterPerson, isNotNull);
      expect(ticket.requesterPerson?.email, equals('customer@example.com'));
      expect(ticket.assignedToPerson, isNotNull);
      expect(ticket.assignedToPerson?.email, equals('agent@example.com'));
      expect(ticket.comments, isNotNull);
      expect(ticket.comments?.length, equals(1));
      expect(ticket.comments?[0]['Comment'], equals('This is a comment'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final ticket = Ticket(
        uid: 'ticket-123',
        subject: 'Help with subscription',
        description: 'I need help with my subscription',
        status: 'Open',
        priority: 'Medium',
        requesterPersonUid: 'person-456',
        assignedToPersonUid: 'person-789',
        accountUid: 'account-012',
        source: 'Email',
        customFields: {'category': 'billing', 'importance': 'high'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        requesterPerson: Person(
          uid: 'person-456',
          email: 'customer@example.com',
          firstName: 'John',
          lastName: 'Doe',
        ),
        assignedToPerson: Person(
          uid: 'person-789',
          email: 'agent@example.com',
          firstName: 'Jane',
          lastName: 'Smith',
        ),
        comments: [
          {
            'Comment': 'This is a comment',
            'IsPrivate': false,
            'PersonUid': 'person-456',
            'Created': '2023-01-02T00:00:00Z',
          }
        ],
      );

      // Act
      final json = ticket.toJson();

      // Assert
      expect(json['Uid'], equals('ticket-123'));
      expect(json['Subject'], equals('Help with subscription'));
      expect(json['Description'], equals('I need help with my subscription'));
      expect(json['Status'], equals('Open'));
      expect(json['Priority'], equals('Medium'));
      expect(json['RequesterPersonUid'], equals('person-456'));
      expect(json['AssignedToPersonUid'], equals('person-789'));
      expect(json['AccountUid'], equals('account-012'));
      expect(json['Source'], equals('Email'));
      expect(json['CustomFields'], equals({'category': 'billing', 'importance': 'high'}));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['RequesterPerson'], isNotNull);
      expect(json['AssignedToPerson'], isNotNull);
      expect(json['Comments'], isNotNull);
      expect(json['Comments'].length, equals(1));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final ticket = Ticket(
        uid: 'ticket-123',
        subject: 'Help with subscription',
        status: 'Open',
        priority: 'Medium',
        requesterPersonUid: 'person-456',
      );

      // Act
      final updatedTicket = ticket.copyWith(
        status: 'In Progress',
        priority: 'High',
        assignedToPersonUid: 'person-789',
      );

      // Assert
      expect(updatedTicket.uid, equals('ticket-123')); // Unchanged
      expect(updatedTicket.subject, equals('Help with subscription')); // Unchanged
      expect(updatedTicket.requesterPersonUid, equals('person-456')); // Unchanged
      expect(updatedTicket.status, equals('In Progress')); // Changed
      expect(updatedTicket.priority, equals('High')); // Changed
      expect(updatedTicket.assignedToPersonUid, equals('person-789')); // Added
      
      // Verify original is unchanged
      expect(ticket.status, equals('Open'));
      expect(ticket.priority, equals('Medium'));
      expect(ticket.assignedToPersonUid, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final ticket1 = Ticket(
        uid: 'ticket-123',
        subject: 'Help with subscription',
        status: 'Open',
        priority: 'Medium',
      );
      
      final ticket2 = Ticket(
        uid: 'ticket-123',
        subject: 'Help with subscription',
        status: 'Open',
        priority: 'Medium',
      );
      
      final ticket3 = Ticket(
        uid: 'ticket-123',
        subject: 'Help with subscription',
        status: 'In Progress', // Different
        priority: 'Medium',
      );

      // Assert
      expect(ticket1 == ticket2, isTrue); // Same values should be equal
      expect(ticket1 == ticket3, isFalse); // Different values should not be equal
      
      // Check props content
      expect(ticket1.props, contains(ticket1.uid));
      expect(ticket1.props, contains(ticket1.subject));
      expect(ticket1.props, contains(ticket1.status));
      expect(ticket1.props, contains(ticket1.priority));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'ticket-123',
        'Subject': 'Help with subscription',
        // Missing or null fields
      };

      // Act
      final ticket = Ticket.fromJson(json);

      // Assert
      expect(ticket.uid, equals('ticket-123'));
      expect(ticket.subject, equals('Help with subscription'));
      expect(ticket.description, isNull);
      expect(ticket.status, isNull);
      expect(ticket.priority, isNull);
      expect(ticket.requesterPersonUid, isNull);
      expect(ticket.assignedToPersonUid, isNull);
      expect(ticket.accountUid, isNull);
      expect(ticket.source, isNull);
      expect(ticket.customFields, isNull);
      expect(ticket.requesterPerson, isNull);
      expect(ticket.assignedToPerson, isNull);
      expect(ticket.comments, isNull);
    });
    
    test('should handle different status values', () {
      // Test various status values
      final statuses = ['Open', 'In Progress', 'Resolved', 'Closed', 'Waiting on Customer'];
      
      for (final status in statuses) {
        // Arrange
        final ticket = Ticket(
          uid: 'ticket-123',
          subject: 'Help with subscription',
          status: status,
        );
        
        // Act
        final json = ticket.toJson();
        final deserialized = Ticket.fromJson(json);
        
        // Assert
        expect(deserialized.status, equals(status));
      }
    });
    
    test('should handle different priority values', () {
      // Test various priority values
      final priorities = ['Low', 'Medium', 'High', 'Urgent'];
      
      for (final priority in priorities) {
        // Arrange
        final ticket = Ticket(
          uid: 'ticket-123',
          subject: 'Help with subscription',
          priority: priority,
        );
        
        // Act
        final json = ticket.toJson();
        final deserialized = Ticket.fromJson(json);
        
        // Assert
        expect(deserialized.priority, equals(priority));
      }
    });
  });
}