import '../models/pagination.dart';
import '../models/ticket.dart';
import '../outseta_client.dart';

/// The Support API client for managing help desk tickets
class SupportApi {
  /// Creates a new Support API client
  SupportApi(this._client);

  final OutsetaClient _client;

  // Tickets endpoints

  /// Get a paginated list of support tickets
  Future<PaginatedResponse<Ticket>> getTickets({
    int offset = 0,
    int limit = 25,
    String? filter,
  }) async {
    final queryParams = {'offset': offset.toString(), 'limit': limit.toString()};

    if (filter != null) {
      queryParams['filter'] = filter;
    }

    final response = await _client.get('support/tickets', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Ticket.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Ticket>(items: items, metadata: metadata);
  }

  /// Get a support ticket by UID
  Future<Ticket> getTicket(String uid) async {
    final response = await _client.get('support/tickets/$uid');
    return Ticket.fromJson(response);
  }

  /// Create a new support ticket
  Future<Ticket> createTicket(Ticket ticket) async {
    final response = await _client.post('support/tickets', body: ticket.toJson());
    return Ticket.fromJson(response);
  }

  /// Update an existing support ticket
  Future<Ticket> updateTicket(Ticket ticket) async {
    if (ticket.uid == null) {
      throw ArgumentError('Ticket uid cannot be null');
    }

    final response = await _client.put('support/tickets/${ticket.uid}', body: ticket.toJson());
    return Ticket.fromJson(response);
  }

  /// Delete a support ticket
  Future<void> deleteTicket(String uid) async {
    await _client.delete('support/tickets/$uid');
  }

  /// Add a comment to a support ticket
  Future<Ticket> addComment(String ticketUid, String comment, {bool isPrivate = false}) async {
    final response = await _client.post(
      'support/tickets/$ticketUid/comments',
      body: {'Comment': comment, 'IsPrivate': isPrivate},
    );
    return Ticket.fromJson(response);
  }

  /// Change the status of a support ticket
  Future<Ticket> changeStatus(String ticketUid, String status) async {
    final response = await _client.post(
      'support/tickets/$ticketUid/change-status',
      body: {'Status': status},
    );
    return Ticket.fromJson(response);
  }

  /// Assign a support ticket to a person
  Future<Ticket> assignTicket(String ticketUid, String personUid) async {
    final response = await _client.post(
      'support/tickets/$ticketUid/assign',
      body: {'PersonUid': personUid},
    );
    return Ticket.fromJson(response);
  }

  /// Get tickets assigned to a specific person
  Future<PaginatedResponse<Ticket>> getTicketsAssignedToPerson(
    String personUid, {
    int offset = 0,
    int limit = 25,
  }) async {
    final queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'filter': 'AssignedToPersonUid eq $personUid',
    };

    final response = await _client.get('support/tickets', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Ticket.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Ticket>(items: items, metadata: metadata);
  }

  /// Get tickets submitted by a specific person
  Future<PaginatedResponse<Ticket>> getTicketsSubmittedByPerson(
    String personUid, {
    int offset = 0,
    int limit = 25,
  }) async {
    final queryParams = {
      'offset': offset.toString(),
      'limit': limit.toString(),
      'filter': 'CreatedBy eq $personUid',
    };

    final response = await _client.get('support/tickets', queryParams: queryParams);
    final items = (response['items'] as List).map((item) => Ticket.fromJson(item)).toList();
    final metadata = Pagination.fromJson(response['metadata']);

    return PaginatedResponse<Ticket>(items: items, metadata: metadata);
  }
}
