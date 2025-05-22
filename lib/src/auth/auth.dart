import 'dart:convert';

import 'package:http/http.dart' as http;

/// Base class for Outseta authentication methods
abstract class OutsetaAuth {
  /// Returns the authentication headers needed for API requests
  Future<Map<String, String>> getHeaders();
}

/// API key authentication for server-side use
class ApiKeyAuth implements OutsetaAuth {
  /// Creates a new API key authentication method
  ///
  /// [apiKey] - The API key from Outseta (Settings > Integrations > API Keys)
  /// [secretKey] - The secret key from Outseta
  ApiKeyAuth({
    required this.apiKey,
    required this.secretKey,
  });

  /// The API key from Outseta
  final String apiKey;

  /// The secret key from Outseta
  final String secretKey;

  @override
  Future<Map<String, String>> getHeaders() async {
    return {
      'Authorization': 'Outseta $apiKey:$secretKey',
    };
  }
}

/// Bearer token authentication for client-side use
class BearerTokenAuth implements OutsetaAuth {
  /// Creates a new bearer token authentication method
  ///
  /// [accessToken] - The access token from Outseta
  BearerTokenAuth({
    required this.accessToken,
  });

  /// The access token from Outseta
  final String accessToken;

  @override
  Future<Map<String, String>> getHeaders() async {
    return {
      'Authorization': 'bearer $accessToken',
    };
  }
}

/// Function that generates a bearer token from username and password
/// This should be used server-side only to get a token for client-side use
///
/// Note: This function is excluded from test coverage as it requires
/// actual network connections to Outseta's API. See test/coverage_exclusions/README.md
/// for more information.
Future<String> getAuthToken({
  required String baseUrl,
  required String username,
  required String password,
}) async {
  final client = http.Client();
  try {
    final response = await client.post(
      Uri.parse('$baseUrl/tokens'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to get authentication token: ${response.statusCode}');
    }
  } finally {
    client.close();
  }
}