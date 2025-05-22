import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Subscription', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'sub-123',
        'BillingRenewalTerm': 'Month',
        'PlanUid': 'plan-456',
        'AccountUid': 'account-789',
        'PersonUid': 'person-012',
        'StartDate': '2023-01-01T00:00:00Z',
        'EndDate': '2024-01-01T00:00:00Z',
        'CancelDate': '2023-06-01T00:00:00Z',
        'BillingStart': '2023-01-01T00:00:00Z',
        'BillingEnd': '2024-01-01T00:00:00Z',
        'CancellationReason': 'Changed plans',
        'Quantity': 2,
        'Amount': 99.99,
        'SetupFee': 10.0,
        'Discount': 5.0,
        'TaxAmount': 7.5,
        'Total': 112.49,
        'Status': 'Canceled',
        'SubscriptionAddOns': [
          {
            'Name': 'Extra Storage',
            'Quantity': 1,
            'Amount': 10.0
          }
        ],
        'PaymentMethod': 'CreditCard',
        'PlanName': 'Pro Plan',
        'CustomFields': {'referral': 'website'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-06-01T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
        'Plan': {
          'Uid': 'plan-456',
          'Name': 'Pro Plan',
          'Description': 'Professional tier',
          'BillingTerm': 'Month',
          'BillingTermCount': 1,
          'Amount': 99.99
        }
      };

      // Act
      final subscription = Subscription.fromJson(json);

      // Assert
      expect(subscription.uid, equals('sub-123'));
      expect(subscription.billingRenewalTerm, equals('Month'));
      expect(subscription.planUid, equals('plan-456'));
      expect(subscription.accountUid, equals('account-789'));
      expect(subscription.personUid, equals('person-012'));
      expect(subscription.startDate, isA<DateTime>());
      expect(subscription.endDate, isA<DateTime>());
      expect(subscription.cancelDate, isA<DateTime>());
      expect(subscription.billingStart, isA<DateTime>());
      expect(subscription.billingEnd, isA<DateTime>());
      expect(subscription.cancellationReason, equals('Changed plans'));
      expect(subscription.quantity, equals(2));
      expect(subscription.amount, equals(99.99));
      expect(subscription.setupFee, equals(10.0));
      expect(subscription.discount, equals(5.0));
      expect(subscription.taxAmount, equals(7.5));
      expect(subscription.total, equals(112.49));
      expect(subscription.status, equals('Canceled'));
      expect(subscription.subscriptionAddOns, isNotNull);
      expect(subscription.subscriptionAddOns?.length, equals(1));
      expect(subscription.paymentMethod, equals('CreditCard'));
      expect(subscription.planName, equals('Pro Plan'));
      expect(subscription.customFields, equals({'referral': 'website'}));
      expect(subscription.created, isA<DateTime>());
      expect(subscription.updated, isA<DateTime>());
      expect(subscription.createdBy, equals('admin'));
      expect(subscription.updatedBy, equals('admin'));
      
      // Check nested Plan object
      expect(subscription.plan, isNotNull);
      expect(subscription.plan?.uid, equals('plan-456'));
      expect(subscription.plan?.name, equals('Pro Plan'));
      expect(subscription.plan?.billingTerm, equals('Month'));
      expect(subscription.plan?.amount, equals(99.99));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final subscription = Subscription(
        uid: 'sub-123',
        billingRenewalTerm: 'Month',
        planUid: 'plan-456',
        accountUid: 'account-789',
        personUid: 'person-012',
        startDate: DateTime.parse('2023-01-01T00:00:00Z'),
        endDate: DateTime.parse('2024-01-01T00:00:00Z'),
        cancelDate: DateTime.parse('2023-06-01T00:00:00Z'),
        billingStart: DateTime.parse('2023-01-01T00:00:00Z'),
        billingEnd: DateTime.parse('2024-01-01T00:00:00Z'),
        cancellationReason: 'Changed plans',
        quantity: 2,
        amount: 99.99,
        setupFee: 10.0,
        discount: 5.0,
        taxAmount: 7.5,
        total: 112.49,
        status: 'Canceled',
        subscriptionAddOns: [
          {
            'Name': 'Extra Storage',
            'Quantity': 1,
            'Amount': 10.0
          }
        ],
        paymentMethod: 'CreditCard',
        planName: 'Pro Plan',
        customFields: {'referral': 'website'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-06-01T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
        plan: Plan(
          uid: 'plan-456',
          name: 'Pro Plan',
          description: 'Professional tier',
          billingTerm: 'Month',
          billingTermCount: 1,
          amount: 99.99,
        ),
      );

      // Act
      final json = subscription.toJson();

      // Assert
      expect(json['Uid'], equals('sub-123'));
      expect(json['BillingRenewalTerm'], equals('Month'));
      expect(json['PlanUid'], equals('plan-456'));
      expect(json['AccountUid'], equals('account-789'));
      expect(json['PersonUid'], equals('person-012'));
      expect(json['StartDate'], isA<String>());
      expect(json['EndDate'], isA<String>());
      expect(json['CancelDate'], isA<String>());
      expect(json['BillingStart'], isA<String>());
      expect(json['BillingEnd'], isA<String>());
      expect(json['CancellationReason'], equals('Changed plans'));
      expect(json['Quantity'], equals(2));
      expect(json['Amount'], equals(99.99));
      expect(json['SetupFee'], equals(10.0));
      expect(json['Discount'], equals(5.0));
      expect(json['TaxAmount'], equals(7.5));
      expect(json['Total'], equals(112.49));
      expect(json['Status'], equals('Canceled'));
      expect(json['SubscriptionAddOns'], isNotNull);
      expect(json['SubscriptionAddOns'].length, equals(1));
      expect(json['PaymentMethod'], equals('CreditCard'));
      expect(json['PlanName'], equals('Pro Plan'));
      expect(json['CustomFields'], equals({'referral': 'website'}));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
      
      // Check nested Plan object
      expect(json['Plan'], isNotNull);
      expect(json['Plan']['Uid'], equals('plan-456'));
      expect(json['Plan']['Name'], equals('Pro Plan'));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final subscription = Subscription(
        uid: 'sub-123',
        planUid: 'plan-456',
        accountUid: 'account-789',
        status: 'Active',
        amount: 99.99,
        billingRenewalTerm: 'Month',
      );

      // Act
      final updatedSubscription = subscription.copyWith(
        status: 'Canceled',
        cancellationReason: 'Changed plans',
        cancelDate: DateTime.parse('2023-06-01T00:00:00Z'),
        amount: 129.99,
      );

      // Assert
      expect(updatedSubscription.uid, equals('sub-123')); // Unchanged
      expect(updatedSubscription.planUid, equals('plan-456')); // Unchanged
      expect(updatedSubscription.accountUid, equals('account-789')); // Unchanged
      expect(updatedSubscription.billingRenewalTerm, equals('Month')); // Unchanged
      expect(updatedSubscription.status, equals('Canceled')); // Changed
      expect(updatedSubscription.cancellationReason, equals('Changed plans')); // Added
      expect(updatedSubscription.cancelDate, isA<DateTime>()); // Added
      expect(updatedSubscription.amount, equals(129.99)); // Changed
      
      // Verify original is unchanged
      expect(subscription.status, equals('Active'));
      expect(subscription.cancellationReason, isNull);
      expect(subscription.cancelDate, isNull);
      expect(subscription.amount, equals(99.99));
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final subscription1 = Subscription(
        uid: 'sub-123',
        planUid: 'plan-456',
        status: 'Active',
      );
      
      final subscription2 = Subscription(
        uid: 'sub-123',
        planUid: 'plan-456',
        status: 'Active',
      );
      
      final subscription3 = Subscription(
        uid: 'sub-123',
        planUid: 'plan-456',
        status: 'Canceled', // Different
      );

      // Assert
      expect(subscription1 == subscription2, isTrue); // Same values should be equal
      expect(subscription1 == subscription3, isFalse); // Different values should not be equal
      
      // Check props content
      expect(subscription1.props, contains(subscription1.uid));
      expect(subscription1.props, contains(subscription1.planUid));
      expect(subscription1.props, contains(subscription1.status));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'sub-123',
        'PlanUid': 'plan-456',
        // Missing or null fields
      };

      // Act
      final subscription = Subscription.fromJson(json);

      // Assert
      expect(subscription.uid, equals('sub-123'));
      expect(subscription.planUid, equals('plan-456'));
      expect(subscription.billingRenewalTerm, isNull);
      expect(subscription.accountUid, isNull);
      expect(subscription.personUid, isNull);
      expect(subscription.startDate, isNull);
      expect(subscription.endDate, isNull);
      expect(subscription.cancelDate, isNull);
      expect(subscription.billingStart, isNull);
      expect(subscription.billingEnd, isNull);
      expect(subscription.cancellationReason, isNull);
      expect(subscription.quantity, isNull);
      expect(subscription.amount, isNull);
      expect(subscription.setupFee, isNull);
      expect(subscription.discount, isNull);
      expect(subscription.taxAmount, isNull);
      expect(subscription.total, isNull);
      expect(subscription.status, isNull);
      expect(subscription.subscriptionAddOns, isNull);
      expect(subscription.paymentMethod, isNull);
      expect(subscription.planName, isNull);
      expect(subscription.customFields, isNull);
      expect(subscription.plan, isNull);
    });
    
    test('should handle different subscription status values', () {
      // Test various status values
      final statuses = ['Active', 'Canceled', 'Trial', 'Past Due', 'Pending'];
      
      for (final status in statuses) {
        // Arrange
        final subscription = Subscription(
          uid: 'sub-123',
          status: status,
        );
        
        // Act
        final json = subscription.toJson();
        final deserialized = Subscription.fromJson(json);
        
        // Assert
        expect(deserialized.status, equals(status));
      }
    });
  });
}