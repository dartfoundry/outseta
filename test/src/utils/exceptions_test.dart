import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

void main() {
  group('API Exceptions', () {
    group('ApiException', () {
      test('should have correct message and status code', () {
        // Arrange & Act
        final exception = ApiException('Test error message', statusCode: 500);

        // Assert
        expect(exception.message, equals('Test error message'));
        expect(exception.statusCode, equals(500));
        expect(
          exception.toString(),
          equals('ApiException: Test error message'),
        );
      });

      test('should handle null status code', () {
        // Arrange & Act
        final exception = ApiException('Error without status code');

        // Assert
        expect(exception.message, equals('Error without status code'));
        expect(exception.statusCode, isNull);
        expect(
          exception.toString(),
          equals('ApiException: Error without status code'),
        );
      });

      test('should handle empty message', () {
        // Arrange & Act
        final exception = ApiException('', statusCode: 500);

        // Assert
        expect(exception.message, equals(''));
        expect(exception.statusCode, equals(500));
        expect(exception.toString(), equals('ApiException: '));
      });
    });

    group('BadRequestException', () {
      test('should have correct status code and message format', () {
        // Arrange & Act
        final exception = BadRequestException('Invalid request parameters');

        // Assert
        expect(exception.message, equals('Invalid request parameters'));
        expect(exception.statusCode, equals(400));
        expect(
          exception.toString(),
          equals('BadRequestException: Invalid request parameters'),
        );
      });

      test('should handle empty message', () {
        // Arrange & Act
        final exception = BadRequestException('');

        // Assert
        expect(exception.message, equals(''));
        expect(exception.statusCode, equals(400));
        expect(exception.toString(), equals('BadRequestException: '));
      });

      test('should handle detailed error messages', () {
        // Arrange & Act
        final exception = BadRequestException(
          '{"field": "email", "error": "Invalid format"}',
        );

        // Assert
        expect(
          exception.message,
          equals('{"field": "email", "error": "Invalid format"}'),
        );
        expect(exception.statusCode, equals(400));
      });
    });

    group('UnauthorizedException', () {
      test('should have correct status code and message format', () {
        // Arrange & Act
        final exception = UnauthorizedException('Authentication failed');

        // Assert
        expect(exception.message, equals('Authentication failed'));
        expect(exception.statusCode, equals(401));
        expect(
          exception.toString(),
          equals('UnauthorizedException: Authentication failed'),
        );
      });

      test('should handle empty message', () {
        // Arrange & Act
        final exception = UnauthorizedException('');

        // Assert
        expect(exception.message, equals(''));
        expect(exception.statusCode, equals(401));
        expect(exception.toString(), equals('UnauthorizedException: '));
      });
    });

    group('ForbiddenException', () {
      test('should have correct status code and message format', () {
        // Arrange & Act
        final exception = ForbiddenException('Insufficient permissions');

        // Assert
        expect(exception.message, equals('Insufficient permissions'));
        expect(exception.statusCode, equals(403));
        expect(
          exception.toString(),
          equals('ForbiddenException: Insufficient permissions'),
        );
      });

      test('should handle empty message', () {
        // Arrange & Act
        final exception = ForbiddenException('');

        // Assert
        expect(exception.message, equals(''));
        expect(exception.statusCode, equals(403));
        expect(exception.toString(), equals('ForbiddenException: '));
      });
    });

    group('NotFoundException', () {
      test('should have correct status code and message format', () {
        // Arrange & Act
        final exception = NotFoundException('Resource not found');

        // Assert
        expect(exception.message, equals('Resource not found'));
        expect(exception.statusCode, equals(404));
        expect(
          exception.toString(),
          equals('NotFoundException: Resource not found'),
        );
      });

      test('should handle empty message', () {
        // Arrange & Act
        final exception = NotFoundException('');

        // Assert
        expect(exception.message, equals(''));
        expect(exception.statusCode, equals(404));
        expect(exception.toString(), equals('NotFoundException: '));
      });

      test('should handle resource identifiers in message', () {
        // Arrange & Act
        final exception = NotFoundException('Resource with ID 12345 not found');

        // Assert
        expect(exception.message, equals('Resource with ID 12345 not found'));
        expect(exception.statusCode, equals(404));
      });
    });

    group('RateLimitExceededException', () {
      test('should have correct status code and message format', () {
        // Arrange & Act
        final exception = RateLimitExceededException('Too many requests');

        // Assert
        expect(exception.message, equals('Too many requests'));
        expect(exception.statusCode, equals(429));
        expect(
          exception.toString(),
          equals('RateLimitExceededException: Too many requests'),
        );
      });

      test('should handle empty message', () {
        // Arrange & Act
        final exception = RateLimitExceededException('');

        // Assert
        expect(exception.message, equals(''));
        expect(exception.statusCode, equals(429));
        expect(exception.toString(), equals('RateLimitExceededException: '));
      });

      test('should handle message with retry information', () {
        // Arrange & Act
        final exception = RateLimitExceededException(
          'Rate limit exceeded. Try again in 60 seconds.',
        );

        // Assert
        expect(
          exception.message,
          equals('Rate limit exceeded. Try again in 60 seconds.'),
        );
        expect(exception.statusCode, equals(429));
      });
    });

    test('exception classes should inherit from ApiException', () {
      // Arrange & Act
      final badRequest = BadRequestException('Bad request');
      final unauthorized = UnauthorizedException('Unauthorized');
      final forbidden = ForbiddenException('Forbidden');
      final notFound = NotFoundException('Not found');
      final rateLimit = RateLimitExceededException('Rate limit exceeded');

      // Assert
      expect(badRequest, isA<ApiException>());
      expect(unauthorized, isA<ApiException>());
      expect(forbidden, isA<ApiException>());
      expect(notFound, isA<ApiException>());
      expect(rateLimit, isA<ApiException>());
    });

    test('exception should preserve message in inheritance chain', () {
      // Arrange
      const testMessage = 'Test error message';

      // Act
      final apiException = ApiException(testMessage);
      final badRequest = BadRequestException(testMessage);
      final unauthorized = UnauthorizedException(testMessage);
      final forbidden = ForbiddenException(testMessage);
      final notFound = NotFoundException(testMessage);
      final rateLimit = RateLimitExceededException(testMessage);

      // Assert
      expect(apiException.message, equals(testMessage));
      expect(badRequest.message, equals(testMessage));
      expect(unauthorized.message, equals(testMessage));
      expect(forbidden.message, equals(testMessage));
      expect(notFound.message, equals(testMessage));
      expect(rateLimit.message, equals(testMessage));
    });

    test(
      'exceptions with same message should have different string representations',
      () {
        // Arrange
        const testMessage = 'Test error message';

        // Act
        final apiException = ApiException(testMessage);
        final badRequest = BadRequestException(testMessage);
        final unauthorized = UnauthorizedException(testMessage);

        // Assert
        expect(apiException.toString(), equals('ApiException: $testMessage'));
        expect(
          badRequest.toString(),
          equals('BadRequestException: $testMessage'),
        );
        expect(
          unauthorized.toString(),
          equals('UnauthorizedException: $testMessage'),
        );
        expect(apiException.toString() != badRequest.toString(), isTrue);
        expect(badRequest.toString() != unauthorized.toString(), isTrue);
      },
    );

    test(
      'should handle different exception types with different status codes',
      () {
        // Arrange & Act
        final exceptions = [
          ApiException('Generic error', statusCode: 500),
          BadRequestException('Bad request error'),
          UnauthorizedException('Unauthorized error'),
          ForbiddenException('Forbidden error'),
          NotFoundException('Not found error'),
          RateLimitExceededException('Rate limit error'),
        ];

        // Assert
        expect(exceptions[0].statusCode, equals(500));
        expect(exceptions[1].statusCode, equals(400));
        expect(exceptions[2].statusCode, equals(401));
        expect(exceptions[3].statusCode, equals(403));
        expect(exceptions[4].statusCode, equals(404));
        expect(exceptions[5].statusCode, equals(429));
      },
    );

    test('should be able to throw and catch different exception types', () {
      // Act & Assert
      expect(
        () => throw ApiException('Generic error'),
        throwsA(isA<ApiException>()),
      );
      expect(
        () => throw BadRequestException('Bad request'),
        throwsA(isA<BadRequestException>()),
      );
      expect(
        () => throw UnauthorizedException('Unauthorized'),
        throwsA(isA<UnauthorizedException>()),
      );
      expect(
        () => throw ForbiddenException('Forbidden'),
        throwsA(isA<ForbiddenException>()),
      );
      expect(
        () => throw NotFoundException('Not found'),
        throwsA(isA<NotFoundException>()),
      );
      expect(
        () => throw RateLimitExceededException('Rate limit'),
        throwsA(isA<RateLimitExceededException>()),
      );
    });
  });
}
