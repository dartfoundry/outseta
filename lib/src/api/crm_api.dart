import '../models/account.dart';
import '../models/deal.dart';
import '../models/pagination.dart';
import '../models/person.dart';
import '../outseta_client.dart';

/// The CRM API client for managing people, accounts, and deals
class CrmApi {
  /// Creates a new CRM API client
  CrmApi(this._client);

  final OutsetaClient _client;

  // People endpoints

  /// Get a paginated list of people
  Future<PaginatedResponse<Person>> getPeople({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('crm/people', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Person.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Person>(items: items, metadata: metadata);
  }

  /// Get a person by UID
  Future<Person> getPerson(String uid) async {
    final response = await _client.get('crm/people/$uid');
    return Person.fromJson(response);
  }

  /// Create a new person
  Future<Person> createPerson(Person person) async {
    final response = await _client.post('crm/people', body: person.toJson());
    return Person.fromJson(response);
  }

  /// Update an existing person
  Future<Person> updatePerson(Person person) async {
    if (person.uid == null) {
      throw ArgumentError('Person uid cannot be null');
    }

    final response = await _client.put('crm/people/${person.uid}', body: person.toJson());
    return Person.fromJson(response);
  }

  /// Delete a person
  Future<void> deletePerson(String uid) async {
    await _client.delete('crm/people/$uid');
  }

  // Accounts endpoints

  /// Get a paginated list of accounts
  Future<PaginatedResponse<Account>> getAccounts({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('crm/accounts', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Account.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Account>(items: items, metadata: metadata);
  }

  /// Get an account by UID
  Future<Account> getAccount(String uid) async {
    final response = await _client.get('crm/accounts/$uid');
    return Account.fromJson(response);
  }

  /// Create a new account
  Future<Account> createAccount(Account account) async {
    final response = await _client.post('crm/accounts', body: account.toJson());
    return Account.fromJson(response);
  }

  /// Update an existing account
  Future<Account> updateAccount(Account account) async {
    if (account.uid == null) {
      throw ArgumentError('Account uid cannot be null');
    }

    final response = await _client.put('crm/accounts/${account.uid}', body: account.toJson());
    return Account.fromJson(response);
  }

  /// Delete an account
  Future<void> deleteAccount(String uid) async {
    await _client.delete('crm/accounts/$uid');
  }

  /// Add a person to an account
  Future<void> addPersonToAccount(String accountUid, String personUid) async {
    await _client.post('crm/accounts/$accountUid/add-person/$personUid');
  }

  /// Remove a person from an account
  Future<void> removePersonFromAccount(String accountUid, String personUid) async {
    await _client.post('crm/accounts/$accountUid/remove-person/$personUid');
  }

  // Deals endpoints

  /// Get a paginated list of deals
  Future<PaginatedResponse<Deal>> getDeals({int offset = 0, int limit = 25, String? filter}) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('crm/deals', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Deal.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Deal>(items: items, metadata: metadata);
  }

  /// Get a deal by UID
  Future<Deal> getDeal(String uid) async {
    final response = await _client.get('crm/deals/$uid');
    return Deal.fromJson(response);
  }

  /// Create a new deal
  Future<Deal> createDeal(Deal deal) async {
    final response = await _client.post('crm/deals', body: deal.toJson());
    return Deal.fromJson(response);
  }

  /// Update an existing deal
  Future<Deal> updateDeal(Deal deal) async {
    if (deal.uid == null) {
      throw ArgumentError('Deal uid cannot be null');
    }

    final response = await _client.put('crm/deals/${deal.uid}', body: deal.toJson());
    return Deal.fromJson(response);
  }

  /// Delete a deal
  Future<void> deleteDeal(String uid) async {
    await _client.delete('crm/deals/$uid');
  }
}
