import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Deal', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Name': 'Test Deal',
        'Amount': 5000.0,
        'Stage': 'Qualified',
        'Description': 'Test deal description',
        'AccountUid': '456',
        'PersonUid': '789',
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'CustomFields': {'field1': 'value1'},
      };

      // Act
      final deal = Deal.fromJson(json);

      // Assert
      expect(deal.uid, equals('123'));
      expect(deal.name, equals('Test Deal'));
      expect(deal.amount, equals(5000.0));
      expect(deal.stage, equals('Qualified'));
      expect(deal.description, equals('Test deal description'));
      expect(deal.accountUid, equals('456'));
      expect(deal.personUid, equals('789'));
      expect(deal.created, isA<DateTime>());
      expect(deal.updated, isA<DateTime>());
      expect(deal.createdBy, equals('admin'));
      expect(deal.updatedBy, equals('admin'));
      expect(deal.customFields, equals({'field1': 'value1'}));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final deal = Deal(
        uid: '123',
        name: 'Test Deal',
        amount: 5000.0,
        stage: 'Qualified',
        description: 'Test deal description',
        accountUid: '456',
        personUid: '789',
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        customFields: {'field1': 'value1'},
      );

      // Act
      final json = deal.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['Name'], equals('Test Deal'));
      expect(json['Amount'], equals(5000.0));
      expect(json['Stage'], equals('Qualified'));
      expect(json['Description'], equals('Test deal description'));
      expect(json['AccountUid'], equals('456'));
      expect(json['PersonUid'], equals('789'));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      expect(json['CustomFields'], equals({'field1': 'value1'}));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final deal = Deal(
        uid: '123',
        name: 'Test Deal',
        amount: 5000.0,
        stage: 'Qualified',
      );

      // Act
      final updatedDeal = deal.copyWith(name: 'Updated Deal', amount: 6000.0);

      // Assert
      expect(updatedDeal.uid, equals('123'));
      expect(updatedDeal.name, equals('Updated Deal'));
      expect(updatedDeal.amount, equals(6000.0));
      expect(updatedDeal.stage, equals('Qualified'));
      expect(deal.name, equals('Test Deal')); // Original unchanged
      expect(deal.amount, equals(5000.0)); // Original unchanged
    });
  });

  group('EmailList', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Name': 'Newsletter Subscribers',
        'Description': 'People who want to receive our newsletter',
        'SubscriberCount': 42,
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
      };

      // Act
      final list = EmailList.fromJson(json);

      // Assert
      expect(list.uid, equals('123'));
      expect(list.name, equals('Newsletter Subscribers'));
      expect(
        list.description,
        equals('People who want to receive our newsletter'),
      );
      expect(list.subscriberCount, equals(42));
      expect(list.created, isA<DateTime>());
      expect(list.updated, isA<DateTime>());
      expect(list.createdBy, equals('admin'));
      expect(list.updatedBy, equals('admin'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final list = EmailList(
        uid: '123',
        name: 'Newsletter Subscribers',
        description: 'People who want to receive our newsletter',
        subscriberCount: 42,
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
      );

      // Act
      final json = list.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['Name'], equals('Newsletter Subscribers'));
      expect(
        json['Description'],
        equals('People who want to receive our newsletter'),
      );
      expect(json['SubscriberCount'], equals(42));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
    });
  });

  group('Email', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Subject': 'Monthly Newsletter',
        'FromName': 'Company Name',
        'FromEmail': 'newsletter@example.com',
        'Content': '<h1>Newsletter</h1>',
        'EmailListUid': '456',
        'Status': 'Draft',
        'ScheduledDate': '2023-01-15T00:00:00Z',
        'SentDate': '2023-01-16T00:00:00Z',
      };

      // Act
      final email = Email.fromJson(json);

      // Assert
      expect(email.uid, equals('123'));
      expect(email.subject, equals('Monthly Newsletter'));
      expect(email.fromName, equals('Company Name'));
      expect(email.fromEmail, equals('newsletter@example.com'));
      expect(email.content, equals('<h1>Newsletter</h1>'));
      expect(email.emailListUid, equals('456'));
      expect(email.status, equals('Draft'));
      expect(email.scheduledDate, isA<DateTime>());
      expect(email.sentDate, isA<DateTime>());
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final email = Email(
        uid: '123',
        subject: 'Monthly Newsletter',
        fromName: 'Company Name',
        fromEmail: 'newsletter@example.com',
        content: '<h1>Newsletter</h1>',
        emailListUid: '456',
        status: 'Draft',
        scheduledDate: DateTime.parse('2023-01-15T00:00:00Z'),
        sentDate: DateTime.parse('2023-01-16T00:00:00Z'),
      );

      // Act
      final json = email.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['Subject'], equals('Monthly Newsletter'));
      expect(json['FromName'], equals('Company Name'));
      expect(json['FromEmail'], equals('newsletter@example.com'));
      expect(json['Content'], equals('<h1>Newsletter</h1>'));
      expect(json['EmailListUid'], equals('456'));
      expect(json['Status'], equals('Draft'));
      expect(json['ScheduledDate'], isA<String>());
      expect(json['SentDate'], isA<String>());
    });
  });

  group('Invoice', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'InvoiceNumber': 'INV-123',
        'AccountUid': '456',
        'Amount': 99.99,
        'DueDate': '2023-02-01T00:00:00Z',
        'Status': 'Unpaid',
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
      };

      // Act
      final invoice = Invoice.fromJson(json);

      // Assert
      expect(invoice.uid, equals('123'));
      expect(invoice.invoiceNumber, equals('INV-123'));
      expect(invoice.accountUid, equals('456'));
      expect(invoice.amount, equals(99.99));
      expect(invoice.dueDate, isA<DateTime>());
      expect(invoice.status, equals('Unpaid'));
      expect(invoice.created, isA<DateTime>());
      expect(invoice.updated, isA<DateTime>());
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final invoice = Invoice(
        uid: '123',
        invoiceNumber: 'INV-123',
        accountUid: '456',
        amount: 99.99,
        dueDate: DateTime.parse('2023-02-01T00:00:00Z'),
        status: 'Unpaid',
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
      );

      // Act
      final json = invoice.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['InvoiceNumber'], equals('INV-123'));
      expect(json['AccountUid'], equals('456'));
      expect(json['Amount'], equals(99.99));
      expect(json['DueDate'], isA<String>());
      expect(json['Status'], equals('Unpaid'));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
    });
  });

  group('Payment', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'InvoiceUid': '456',
        'Amount': 99.99,
        'PaymentDate': '2023-01-15T00:00:00Z',
        'PaymentMethod': 'CreditCard',
        'Status': 'Completed',
        'RefundAmount': 0.0,
      };

      // Act
      final payment = Payment.fromJson(json);

      // Assert
      expect(payment.uid, equals('123'));
      expect(payment.invoiceUid, equals('456'));
      expect(payment.amount, equals(99.99));
      expect(payment.paymentDate, isA<DateTime>());
      expect(payment.paymentMethod, equals('CreditCard'));
      expect(payment.status, equals('Completed'));
      expect(payment.refundAmount, equals(0.0));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final payment = Payment(
        uid: '123',
        invoiceUid: '456',
        amount: 99.99,
        paymentDate: DateTime.parse('2023-01-15T00:00:00Z'),
        paymentMethod: 'CreditCard',
        status: 'Completed',
        refundAmount: 0.0,
      );

      // Act
      final json = payment.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['InvoiceUid'], equals('456'));
      expect(json['Amount'], equals(99.99));
      expect(json['PaymentDate'], isA<String>());
      expect(json['PaymentMethod'], equals('CreditCard'));
      expect(json['Status'], equals('Completed'));
      expect(json['RefundAmount'], equals(0.0));
    });
  });

  group('Ticket', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Subject': 'Help with subscription',
        'Description': 'I need help with my subscription',
        'Status': 'Open',
        'Priority': 'Medium',
        'RequesterPersonUid': '456',
        'AssignedToPersonUid': '789',
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'Comments': [
          {
            'Comment': 'This is a comment',
            'IsPrivate': false,
            'PersonUid': '456',
            'Created': '2023-01-02T00:00:00Z',
          },
        ],
      };

      // Act
      final ticket = Ticket.fromJson(json);

      // Assert
      expect(ticket.uid, equals('123'));
      expect(ticket.subject, equals('Help with subscription'));
      expect(ticket.description, equals('I need help with my subscription'));
      expect(ticket.status, equals('Open'));
      expect(ticket.priority, equals('Medium'));
      expect(ticket.requesterPersonUid, equals('456'));
      expect(ticket.assignedToPersonUid, equals('789'));
      expect(ticket.created, isA<DateTime>());
      expect(ticket.updated, isA<DateTime>());
      expect(ticket.comments, isNotNull);
      expect(ticket.comments?.length, equals(1));
      expect(ticket.comments?.first['Comment'], equals('This is a comment'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final ticket = Ticket(
        uid: '123',
        subject: 'Help with subscription',
        description: 'I need help with my subscription',
        status: 'Open',
        priority: 'Medium',
        requesterPersonUid: '456',
        assignedToPersonUid: '789',
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        comments: [
          {
            'Comment': 'This is a comment',
            'IsPrivate': false,
            'PersonUid': '456',
            'Created': '2023-01-02T00:00:00Z',
          },
        ],
      );

      // Act
      final json = ticket.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['Subject'], equals('Help with subscription'));
      expect(json['Description'], equals('I need help with my subscription'));
      expect(json['Status'], equals('Open'));
      expect(json['Priority'], equals('Medium'));
      expect(json['RequesterPersonUid'], equals('456'));
      expect(json['AssignedToPersonUid'], equals('789'));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['Comments'], isNotNull);
      expect(json['Comments']?.length, equals(1));
      expect(json['Comments']?.first['Comment'], equals('This is a comment'));
    });
  });

  group('Profile', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': '123',
        'Email': 'user@example.com',
        'FirstName': 'Test',
        'LastName': 'User',

        'EmailConfirmed': true,
        'ProfileImageS3Key': 'profile/image.jpg',
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
      };

      // Act
      final profile = Profile.fromJson(json);

      // Assert
      expect(profile.uid, equals('123'));
      expect(profile.email, equals('user@example.com'));
      expect(profile.firstName, equals('Test'));
      expect(profile.lastName, equals('User'));

      expect(profile.emailConfirmed, isTrue);
      expect(profile.profileImageS3Key, equals('profile/image.jpg'));
      expect(profile.created, isA<DateTime>());
      expect(profile.updated, isA<DateTime>());
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final profile = Profile(
        uid: '123',
        email: 'user@example.com',
        firstName: 'Test',
        lastName: 'User',

        emailConfirmed: true,
        profileImageS3Key: 'profile/image.jpg',
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
      );

      // Act
      final json = profile.toJson();

      // Assert
      expect(json['Uid'], equals('123'));
      expect(json['Email'], equals('user@example.com'));
      expect(json['FirstName'], equals('Test'));
      expect(json['LastName'], equals('User'));

      expect(json['EmailConfirmed'], isTrue);
      expect(json['ProfileImageS3Key'], equals('profile/image.jpg'));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final profile = Profile(
        uid: '123',
        email: 'user@example.com',
        firstName: 'Test',
        lastName: 'User',
      );

      // Act
      final updatedProfile = profile.copyWith(
        firstName: 'Updated',
        profileImageS3Key: 'profile/new-image.jpg',
      );

      // Assert
      expect(updatedProfile.uid, equals('123'));
      expect(updatedProfile.email, equals('user@example.com'));
      expect(updatedProfile.firstName, equals('Updated'));
      expect(updatedProfile.lastName, equals('User'));
      expect(updatedProfile.profileImageS3Key, equals('profile/new-image.jpg'));
      expect(profile.firstName, equals('Test')); // Original unchanged
      expect(profile.profileImageS3Key, isNull); // Original unchanged
    });
  });
}
