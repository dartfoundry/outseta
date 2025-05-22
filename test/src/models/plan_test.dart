import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('Plan', () {
    test('fromJson should correctly parse JSON', () {
      // Arrange
      final json = {
        'Uid': 'plan-123',
        'Name': 'Pro Plan',
        'Description': 'Professional tier with advanced features',
        'BillingTerm': 'Month',
        'BillingTermCount': 1,
        'Amount': 99.99,
        'SetupFee': 49.99,
        'TrialPeriodDays': 14,
        'IsActive': true,
        'IsFree': false,
        'RecurringChargeAgreementRequired': true,
        'PlanAddOns': [
          {
            'Name': 'Extra Storage',
            'Amount': 9.99
          }
        ],
        'CustomFields': {'category': 'business'},
        'Created': '2023-01-01T00:00:00Z',
        'Updated': '2023-01-02T00:00:00Z',
        'CreatedBy': 'admin',
        'UpdatedBy': 'admin',
      };

      // Act
      final plan = Plan.fromJson(json);

      // Assert
      expect(plan.uid, equals('plan-123'));
      expect(plan.name, equals('Pro Plan'));
      expect(plan.description, equals('Professional tier with advanced features'));
      expect(plan.billingTerm, equals('Month'));
      expect(plan.billingTermCount, equals(1));
      expect(plan.amount, equals(99.99));
      expect(plan.setupFee, equals(49.99));
      expect(plan.trialPeriodDays, equals(14));
      expect(plan.isActive, isTrue);
      expect(plan.isFree, isFalse);
      expect(plan.recurringChargeAgreementRequired, isTrue);
      expect(plan.planAddOns, isNotNull);
      expect(plan.planAddOns?.length, equals(1));
      expect(plan.planAddOns?[0]['Name'], equals('Extra Storage'));
      expect(plan.customFields, equals({'category': 'business'}));
      expect(plan.created, isA<DateTime>());
      expect(plan.updated, isA<DateTime>());
      expect(plan.createdBy, equals('admin'));
      expect(plan.updatedBy, equals('admin'));
    });

    test('toJson should correctly serialize to JSON', () {
      // Arrange
      final plan = Plan(
        uid: 'plan-123',
        name: 'Pro Plan',
        description: 'Professional tier with advanced features',
        billingTerm: 'Month',
        billingTermCount: 1,
        amount: 99.99,
        setupFee: 49.99,
        trialPeriodDays: 14,
        isActive: true,
        isFree: false,
        recurringChargeAgreementRequired: true,
        planAddOns: [
          {
            'Name': 'Extra Storage',
            'Amount': 9.99
          }
        ],
        customFields: {'category': 'business'},
        created: DateTime.parse('2023-01-01T00:00:00Z'),
        updated: DateTime.parse('2023-01-02T00:00:00Z'),
        createdBy: 'admin',
        updatedBy: 'admin',
      );

      // Act
      final json = plan.toJson();

      // Assert
      expect(json['Uid'], equals('plan-123'));
      expect(json['Name'], equals('Pro Plan'));
      expect(json['Description'], equals('Professional tier with advanced features'));
      expect(json['BillingTerm'], equals('Month'));
      expect(json['BillingTermCount'], equals(1));
      expect(json['Amount'], equals(99.99));
      expect(json['SetupFee'], equals(49.99));
      expect(json['TrialPeriodDays'], equals(14));
      expect(json['IsActive'], isTrue);
      expect(json['IsFree'], isFalse);
      expect(json['RecurringChargeAgreementRequired'], isTrue);
      expect(json['PlanAddOns'], isNotNull);
      expect(json['PlanAddOns'].length, equals(1));
      expect(json['CustomFields'], equals({'category': 'business'}));
      expect(json['Created'], isA<String>());
      expect(json['Updated'], isA<String>());
      expect(json['CreatedBy'], equals('admin'));
      expect(json['UpdatedBy'], equals('admin'));
    });

    test('copyWith should return a new instance with updated values', () {
      // Arrange
      final plan = Plan(
        uid: 'plan-123',
        name: 'Basic Plan',
        billingTerm: 'Month',
        amount: 49.99,
        isActive: true,
      );

      // Act
      final updatedPlan = plan.copyWith(
        name: 'Premium Plan',
        description: 'Premium features added',
        amount: 79.99,
        setupFee: 29.99,
      );

      // Assert
      expect(updatedPlan.uid, equals('plan-123')); // Unchanged
      expect(updatedPlan.billingTerm, equals('Month')); // Unchanged
      expect(updatedPlan.isActive, isTrue); // Unchanged
      expect(updatedPlan.name, equals('Premium Plan')); // Changed
      expect(updatedPlan.description, equals('Premium features added')); // Added
      expect(updatedPlan.amount, equals(79.99)); // Changed
      expect(updatedPlan.setupFee, equals(29.99)); // Added
      
      // Verify original is unchanged
      expect(plan.name, equals('Basic Plan'));
      expect(plan.description, isNull);
      expect(plan.amount, equals(49.99));
      expect(plan.setupFee, isNull);
    });

    test('props should include all properties for comparison', () {
      // Arrange
      final plan1 = Plan(
        uid: 'plan-123',
        name: 'Basic Plan',
        billingTerm: 'Month',
        amount: 49.99,
      );
      
      final plan2 = Plan(
        uid: 'plan-123',
        name: 'Basic Plan',
        billingTerm: 'Month',
        amount: 49.99,
      );
      
      final plan3 = Plan(
        uid: 'plan-123',
        name: 'Basic Plan',
        billingTerm: 'Year', // Different
        amount: 49.99,
      );

      // Assert
      expect(plan1 == plan2, isTrue); // Same values should be equal
      expect(plan1 == plan3, isFalse); // Different values should not be equal
      
      // Check props content
      expect(plan1.props, contains(plan1.uid));
      expect(plan1.props, contains(plan1.name));
      expect(plan1.props, contains(plan1.billingTerm));
      expect(plan1.props, contains(plan1.amount));
    });

    test('should handle null values in JSON', () {
      // Arrange
      final json = {
        'Uid': 'plan-123',
        'Name': 'Basic Plan',
        // Missing or null fields
      };

      // Act
      final plan = Plan.fromJson(json);

      // Assert
      expect(plan.uid, equals('plan-123'));
      expect(plan.name, equals('Basic Plan'));
      expect(plan.description, isNull);
      expect(plan.billingTerm, isNull);
      expect(plan.billingTermCount, isNull);
      expect(plan.amount, isNull);
      expect(plan.setupFee, isNull);
      expect(plan.trialPeriodDays, isNull);
      expect(plan.isActive, isNull);
      expect(plan.isFree, isNull);
      expect(plan.recurringChargeAgreementRequired, isNull);
      expect(plan.planAddOns, isNull);
      expect(plan.customFields, isNull);
    });
    
    test('should handle different billing terms', () {
      // Test various billing terms
      final terms = ['Month', 'Year', 'Week', 'Day'];
      
      for (final term in terms) {
        // Arrange
        final plan = Plan(
          uid: 'plan-123',
          name: 'Test Plan',
          billingTerm: term,
        );
        
        // Act
        final json = plan.toJson();
        final deserialized = Plan.fromJson(json);
        
        // Assert
        expect(deserialized.billingTerm, equals(term));
      }
    });
  });
}