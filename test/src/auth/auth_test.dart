import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('OutsetaAuth Tests', () {
    group('ApiKeyAuth', () {
      test('should return correct headers', () async {
        // Arrange
        final auth = ApiKeyAuth(
          apiKey: 'test-api-key',
          secretKey: 'test-secret-key',
        );

        // Act
        final headers = await auth.getHeaders();

        // Assert
        expect(headers, {
          'Authorization': 'Outseta test-api-key:test-secret-key',
        });
      });

      test('should handle empty api key and secret', () async {
        // Arrange
        final auth = ApiKeyAuth(apiKey: '', secretKey: '');

        // Act
        final headers = await auth.getHeaders();

        // Assert
        expect(headers, {'Authorization': 'Outseta :'});
      });

      test('should handle whitespace in keys', () async {
        // Arrange
        final auth = ApiKeyAuth(
          apiKey: ' test-api-key ',
          secretKey: ' test-secret-key ',
        );

        // Act
        final headers = await auth.getHeaders();

        // Assert
        expect(headers, {
          'Authorization': 'Outseta  test-api-key : test-secret-key ',
        });
      });
    });

    group('BearerTokenAuth', () {
      test('should return correct headers', () async {
        // Arrange
        final auth = BearerTokenAuth(accessToken: 'test-token');

        // Act
        final headers = await auth.getHeaders();

        // Assert
        expect(headers, {'Authorization': 'bearer test-token'});
      });

      test('should handle empty token', () async {
        // Arrange
        final auth = BearerTokenAuth(accessToken: '');

        // Act
        final headers = await auth.getHeaders();

        // Assert
        expect(headers, {'Authorization': 'bearer '});
      });

      test('should handle whitespace in token', () async {
        // Arrange
        final auth = BearerTokenAuth(accessToken: ' test-token ');

        // Act
        final headers = await auth.getHeaders();

        // Assert
        expect(headers, {'Authorization': 'bearer  test-token '});
      });

      test(
        'should include token in headers even if token is invalid',
        () async {
          // Arrange
          final auth = BearerTokenAuth(accessToken: 'invalid.token.format');

          // Act
          final headers = await auth.getHeaders();

          // Assert
          expect(headers, {'Authorization': 'bearer invalid.token.format'});
        },
      );
    });

    group('OutsetaAuth Abstract Class', () {
      test('should be properly implemented by concrete classes', () async {
        // Arrange
        final apiKeyAuth = ApiKeyAuth(
          apiKey: 'test-api-key',
          secretKey: 'test-secret-key',
        );
        final bearerAuth = BearerTokenAuth(accessToken: 'test-token');

        // Act & Assert
        expect(apiKeyAuth, isA<OutsetaAuth>());
        expect(bearerAuth, isA<OutsetaAuth>());

        // Both should implement getHeaders() method
        expect(await apiKeyAuth.getHeaders(), isA<Map<String, String>>());
        expect(await bearerAuth.getHeaders(), isA<Map<String, String>>());
      });
    });
  });

  // Note: We're not testing getAuthToken() directly because:
  // 1. It would require actual network connections to Outseta's API
  // 2. It's difficult to mock the HTTP client creation without significantly
  //    changing the function's implementation
  // 3. The function is relatively simple and primarily relies on the HTTP client
  //
  // In a real-world scenario, this function would typically be used in an integration
  // test rather than a unit test, or would be refactored to make the HTTP client
  // more easily injectable for testing purposes.
  //
  // This test file has been consolidated from multiple separate files to improve
  // organization and reduce redundancy. We focus on testing the auth classes that
  // don't require HTTP mocking.
  //
  // See the test/coverage_exclusions/README.md file for more information about
  // coverage exclusions and the integration_test directory for examples of
  // how getAuthToken() functionality could be tested in an integration environment.
}
