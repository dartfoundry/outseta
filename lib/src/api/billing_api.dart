import '../models/invoice.dart';
import '../models/pagination.dart';
import '../models/payment.dart';
import '../models/plan.dart';
import '../models/subscription.dart';
import '../outseta_client.dart';

/// The Billing API client for managing subscriptions, invoices, and payments
class BillingApi {
  /// Creates a new Billing API client
  BillingApi(this._client);

  final OutsetaClient _client;

  // Plans endpoints

  /// Get a paginated list of plans
  Future<PaginatedResponse<Plan>> getPlans({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get(
      'billing/plans',
      queryParams: queryParams,
    );
    final items = (response['items'] as List)
        .map((item) => Plan.fromJson(item))
        .toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Plan>(items: items, metadata: metadata);
  }

  /// Get a plan by UID
  Future<Plan> getPlan(String uid) async {
    final response = await _client.get('billing/plans/$uid');
    return Plan.fromJson(response);
  }

  /// Create a new plan
  Future<Plan> createPlan(Plan plan) async {
    final response = await _client.post('billing/plans', body: plan.toJson());
    return Plan.fromJson(response);
  }

  /// Update an existing plan
  Future<Plan> updatePlan(Plan plan) async {
    if (plan.uid == null) {
      throw ArgumentError('Plan uid cannot be null');
    }

    final response = await _client.put(
      'billing/plans/${plan.uid}',
      body: plan.toJson(),
    );
    return Plan.fromJson(response);
  }

  /// Delete a plan
  Future<void> deletePlan(String uid) async {
    await _client.delete('billing/plans/$uid');
  }

  // Subscriptions endpoints

  /// Get a paginated list of subscriptions
  Future<PaginatedResponse<Subscription>> getSubscriptions({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get(
      'billing/subscriptions',
      queryParams: queryParams,
    );
    final items = (response['items'] as List)
        .map((item) => Subscription.fromJson(item))
        .toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Subscription>(items: items, metadata: metadata);
  }

  /// Get a subscription by UID
  Future<Subscription> getSubscription(String uid) async {
    final response = await _client.get('billing/subscriptions/$uid');
    return Subscription.fromJson(response);
  }

  /// Create a new subscription
  Future<Subscription> createSubscription(Subscription subscription) async {
    final response = await _client.post(
      'billing/subscriptions',
      body: subscription.toJson(),
    );
    return Subscription.fromJson(response);
  }

  /// Update an existing subscription
  Future<Subscription> updateSubscription(Subscription subscription) async {
    if (subscription.uid == null) {
      throw ArgumentError('Subscription uid cannot be null');
    }

    final response = await _client.put(
      'billing/subscriptions/${subscription.uid}',
      body: subscription.toJson(),
    );
    return Subscription.fromJson(response);
  }

  /// Cancel a subscription
  Future<Subscription> cancelSubscription(
    String uid, {
    String? cancellationReason,
  }) async {
    final body = cancellationReason != null
        ? {'CancellationReason': cancellationReason}
        : null;
    final response = await _client.post(
      'billing/subscriptions/$uid/cancel',
      body: body,
    );
    return Subscription.fromJson(response);
  }

  // Invoices endpoints

  /// Get a paginated list of invoices
  Future<PaginatedResponse<Invoice>> getInvoices({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get(
      'billing/invoices',
      queryParams: queryParams,
    );
    final items = (response['items'] as List)
        .map((item) => Invoice.fromJson(item))
        .toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Invoice>(items: items, metadata: metadata);
  }

  /// Get an invoice by UID
  Future<Invoice> getInvoice(String uid) async {
    final response = await _client.get('billing/invoices/$uid');
    return Invoice.fromJson(response);
  }

  /// Create a new invoice
  Future<Invoice> createInvoice(Invoice invoice) async {
    final response = await _client.post(
      'billing/invoices',
      body: invoice.toJson(),
    );
    return Invoice.fromJson(response);
  }

  /// Update an existing invoice
  Future<Invoice> updateInvoice(Invoice invoice) async {
    if (invoice.uid == null) {
      throw ArgumentError('Invoice uid cannot be null');
    }

    final response = await _client.put(
      'billing/invoices/${invoice.uid}',
      body: invoice.toJson(),
    );
    return Invoice.fromJson(response);
  }

  /// Mark an invoice as paid
  Future<Invoice> markInvoiceAsPaid(String uid) async {
    final response = await _client.post('billing/invoices/$uid/mark-as-paid');
    return Invoice.fromJson(response);
  }

  // Payments endpoints

  /// Get a paginated list of payments
  Future<PaginatedResponse<Payment>> getPayments({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
    };

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get(
      'billing/payments',
      queryParams: queryParams,
    );
    final items = (response['items'] as List)
        .map((item) => Payment.fromJson(item))
        .toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Payment>(items: items, metadata: metadata);
  }

  /// Get a payment by UID
  Future<Payment> getPayment(String uid) async {
    final response = await _client.get('billing/payments/$uid');
    return Payment.fromJson(response);
  }

  /// Create a new payment
  Future<Payment> createPayment(Payment payment) async {
    final response = await _client.post(
      'billing/payments',
      body: payment.toJson(),
    );
    return Payment.fromJson(response);
  }

  /// Refund a payment
  Future<Payment> refundPayment(String uid, {double? amount}) async {
    final body = amount != null ? {'Amount': amount} : null;
    final response = await _client.post(
      'billing/payments/$uid/refund',
      body: body,
    );
    return Payment.fromJson(response);
  }
}
