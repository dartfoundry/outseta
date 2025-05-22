import 'dart:io';

import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

/// This is an example of how getAuthToken could be tested in an integration test environment.
///
/// IMPORTANT: This test is NOT meant to be run automatically in CI pipelines.
/// It requires actual Outseta credentials and will make real API calls.
///
/// To run this test:
/// 1. Create a .env file with OUTSETA_BASE_URL, OUTSETA_USERNAME, and OUTSETA_PASSWORD
/// 2. Run with: dart test integration_test/auth_integration_test.dart
void main() {
  // Only run these tests if explicitly requested with the integration tag
  // and if credentials are available
  if (!Platform.environment.containsKey('OUTSETA_BASE_URL')) {
    return;
  }

  final baseUrl = Platform.environment['OUTSETA_BASE_URL']!;
  final username = Platform.environment['OUTSETA_USERNAME']!;
  final password = Platform.environment['OUTSETA_PASSWORD']!;

  group('Auth Integration Tests', () {
    test('getAuthToken returns valid token', () async {
      // Act
      final token = await getAuthToken(baseUrl: baseUrl, username: username, password: password);

      // Assert
      expect(token, isNotEmpty);
      expect(token.length, greaterThan(20)); // Tokens are typically longer

      // Verify token works by making an authenticated request
      final auth = BearerTokenAuth(accessToken: token);
      final headers = await auth.getHeaders();

      expect(headers['Authorization'], startsWith('bearer '));
    });

    test('getAuthToken throws exception with invalid credentials', () async {
      // Act & Assert
      expect(
        () => getAuthToken(
          baseUrl: baseUrl,
          username: 'invalid@example.com',
          password: 'wrongpassword',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}
