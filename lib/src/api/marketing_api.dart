import '../models/email.dart';
import '../models/list.dart';
import '../models/pagination.dart';
import '../models/person.dart';
import '../outseta_client.dart';

/// The Marketing API client for managing email campaigns, lists, and subscribers
class MarketingApi {
  /// Creates a new Marketing API client
  MarketingApi(this._client);

  final OutsetaClient _client;

  // Email Lists endpoints

  /// Get a paginated list of email lists
  Future<PaginatedResponse<EmailList>> getLists({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('marketing/lists', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => EmailList.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<EmailList>(items: items, metadata: metadata);
  }

  /// Get an email list by UID
  Future<EmailList> getList(String uid) async {
    final response = await _client.get('marketing/lists/$uid');
    return EmailList.fromJson(response);
  }

  /// Create a new email list
  Future<EmailList> createList(EmailList list) async {
    final response = await _client.post('marketing/lists', body: list.toJson());
    return EmailList.fromJson(response);
  }

  /// Update an existing email list
  Future<EmailList> updateList(EmailList list) async {
    if (list.uid == null) {
      throw ArgumentError('List uid cannot be null');
    }

    final response = await _client.put('marketing/lists/${list.uid}', body: list.toJson());
    return EmailList.fromJson(response);
  }

  /// Delete an email list
  Future<void> deleteList(String uid) async {
    await _client.delete('marketing/lists/$uid');
  }

  // Subscribers endpoints

  /// Get a paginated list of subscribers for a specific email list
  Future<PaginatedResponse<Person>> getSubscribers(
    String listUid, {
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('marketing/lists/$listUid/people', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Person.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Person>(items: items, metadata: metadata);
  }

  /// Add a subscriber to an email list
  Future<void> addSubscriber(String listUid, String personUid) async {
    await _client.post('marketing/lists/$listUid/add-person/$personUid');
  }

  /// Remove a subscriber from an email list
  Future<void> removeSubscriber(String listUid, String personUid) async {
    await _client.post('marketing/lists/$listUid/remove-person/$personUid');
  }

  // Email Campaigns endpoints

  /// Get a paginated list of email campaigns
  Future<PaginatedResponse<Email>> getEmails({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('marketing/emails', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Email.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Email>(items: items, metadata: metadata);
  }

  /// Get an email campaign by UID
  Future<Email> getEmail(String uid) async {
    final response = await _client.get('marketing/emails/$uid');
    return Email.fromJson(response);
  }

  /// Create a new email campaign
  Future<Email> createEmail(Email email) async {
    final response = await _client.post('marketing/emails', body: email.toJson());
    return Email.fromJson(response);
  }

  /// Update an existing email campaign
  Future<Email> updateEmail(Email email) async {
    if (email.uid == null) {
      throw ArgumentError('Email uid cannot be null');
    }

    final response = await _client.put('marketing/emails/${email.uid}', body: email.toJson());
    return Email.fromJson(response);
  }

  /// Delete an email campaign
  Future<void> deleteEmail(String uid) async {
    await _client.delete('marketing/emails/$uid');
  }

  /// Send a test email of a campaign
  Future<void> sendTestEmail(String emailUid, String recipientEmail) async {
    await _client.post(
      'marketing/emails/$emailUid/send-test',
      body: {'RecipientEmail': recipientEmail},
    );
  }

  /// Schedule an email campaign to be sent
  Future<Email> scheduleEmail(String emailUid, DateTime scheduledDate) async {
    final response = await _client.post(
      'marketing/emails/$emailUid/schedule',
      body: {'ScheduledDate': scheduledDate.toIso8601String()},
    );
    return Email.fromJson(response);
  }

  /// Send an email campaign immediately
  Future<Email> sendEmailNow(String emailUid) async {
    final response = await _client.post('marketing/emails/$emailUid/send-now');
    return Email.fromJson(response);
  }

  /// Cancel a scheduled email campaign
  Future<Email> cancelScheduledEmail(String emailUid) async {
    final response = await _client.post('marketing/emails/$emailUid/cancel');
    return Email.fromJson(response);
  }
}
