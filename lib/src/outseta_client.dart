import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api/billing_api.dart';
import 'api/crm_api.dart';
import 'api/marketing_api.dart';
import 'api/support_api.dart';
import 'api/user_profile_api.dart';
import 'auth/auth.dart';
import 'utils/exceptions.dart';

/// The main client for interacting with the Outseta API
class OutsetaClient {
  /// Creates a new Outseta API client
  ///
  /// [baseUrl] - Your Outseta domain (e.g., "https://your-domain.outseta.com/api/v1")
  /// [auth] - Authentication method (ApiKeyAuth or BearerTokenAuth)
  /// [httpClient] - Optional HTTP client for custom configuration or testing
  OutsetaClient({
    required String baseUrl,
    required OutsetaAuth auth,
    http.Client? httpClient,
  }) : _baseUrl = baseUrl.endsWith('/')
           ? baseUrl.substring(0, baseUrl.length - 1)
           : baseUrl,
       _auth = auth,
       _httpClient = httpClient ?? http.Client() {
    _initializeApiModules();
  }

  final String _baseUrl;
  final OutsetaAuth _auth;
  final http.Client _httpClient;

  /// CRM API module for managing people, accounts, deals, etc.
  late final CrmApi crm;

  /// Billing API module for managing subscriptions, invoices, etc.
  late final BillingApi billing;

  /// Marketing API module for managing lists, campaigns, etc.
  late final MarketingApi marketing;

  /// Support API module for managing tickets, knowledge base, etc.
  late final SupportApi support;

  /// User Profile API module for managing user profiles
  late final UserProfileApi userProfile;

  void _initializeApiModules() {
    crm = CrmApi(this);
    billing = BillingApi(this);
    marketing = MarketingApi(this);
    support = SupportApi(this);
    userProfile = UserProfileApi(this);
  }

  /// Makes a GET request to the Outseta API
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse(
      '$_baseUrl/$path',
    ).replace(queryParameters: queryParams);
    final response = await _httpClient.get(
      uri,
      headers: await _auth.getHeaders(),
    );
    return _handleResponse(response);
  }

  /// Makes a POST request to the Outseta API
  Future<Map<String, dynamic>> post(String path, {Object? body}) async {
    final uri = Uri.parse('$_baseUrl/$path');
    final response = await _httpClient.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        ...(await _auth.getHeaders()),
      },
      body: body != null ? jsonEncode(body) : null,
    );
    return _handleResponse(response);
  }

  /// Makes a PUT request to the Outseta API
  Future<Map<String, dynamic>> put(String path, {required Object body}) async {
    final uri = Uri.parse('$_baseUrl/$path');
    final response = await _httpClient.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        ...(await _auth.getHeaders()),
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  /// Makes a DELETE request to the Outseta API
  Future<Map<String, dynamic>> delete(String path) async {
    final uri = Uri.parse('$_baseUrl/$path');
    final response = await _httpClient.delete(
      uri,
      headers: await _auth.getHeaders(),
    );
    return _handleResponse(response);
  }

  /// Handle API response and error cases
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final responseBody = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : null;

    if (statusCode >= 200 && statusCode < 300) {
      return responseBody ?? {};
    } else {
      final errorMessage = responseBody is Map
          ? responseBody['error']?.toString() ?? 'Unknown error'
          : 'Unknown error';
      switch (statusCode) {
        case 400:
          throw BadRequestException(errorMessage);
        case 401:
          throw UnauthorizedException(errorMessage);
        case 403:
          throw ForbiddenException(errorMessage);
        case 404:
          throw NotFoundException(errorMessage);
        case 429:
          throw RateLimitExceededException(errorMessage);
        default:
          throw ApiException(
            'API error: $statusCode, message: $errorMessage',
            statusCode: statusCode,
          );
      }
    }
  }

  /// Closes the HTTP client to free up resources
  void close() {
    _httpClient.close();
  }
}
