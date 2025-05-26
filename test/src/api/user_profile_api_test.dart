import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:outseta/outseta.dart';
import 'package:test/test.dart';

import 'user_profile_api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('UserProfileApi', () {
    late MockClient mockClient;
    late OutsetaClient outsetaClient;
    late UserProfileApi userProfileApi;

    setUp(() {
      mockClient = MockClient();
      outsetaClient = OutsetaClient(
        baseUrl: 'https://test-domain.outseta.com/api/v1',
        auth: ApiKeyAuth(apiKey: 'test-api-key', secretKey: 'test-secret-key'),
        httpClient: mockClient,
      );
      userProfileApi = UserProfileApi(outsetaClient);
    });

    test('getCurrentUser should return the current user', () async {
      // Arrange
      final responseData = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Test',
        'LastName': 'User',
        'FullName': 'Test User',
        'EmailConfirmed': true,
        'ProfileImageS3Key': 'profile/image.jpg',
      };

      when(
        mockClient.get(
          Uri.parse('https://test-domain.outseta.com/api/v1/profile/user'),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.getCurrentUser();

      // Assert
      expect(result.uid, equals('123'));
      expect(result.email, equals('test@example.com'));
      expect(result.firstName, equals('Test'));
      expect(result.lastName, equals('User'));
      expect(result.emailConfirmed, isTrue);
      expect(result.profileImageS3Key, equals('profile/image.jpg'));
    });

    test('updateCurrentUser should update the current user', () async {
      // Arrange
      final profile = Profile(
        uid: '123',
        firstName: 'Updated',
        lastName: 'User',
        email: 'test@example.com',
      );

      final responseData = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Updated',
        'LastName': 'User',
      };

      when(
        mockClient.put(
          Uri.parse('https://test-domain.outseta.com/api/v1/profile/user'),
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.updateCurrentUser(profile);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.firstName, equals('Updated'));
      expect(result.lastName, equals('User'));
      expect(result.lastName, equals('User'));
    });

    test('changePassword should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/change-password',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'CurrentPassword': 'old-password',
            'NewPassword': 'new-password',
            'ConfirmPassword': 'new-password',
          }),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.changePassword(
        'old-password',
        'new-password',
        'new-password',
      );

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/change-password',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'CurrentPassword': 'old-password',
            'NewPassword': 'new-password',
            'ConfirmPassword': 'new-password',
          }),
        ),
      ).called(1);
    });

    test('requestPasswordReset should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/request-password-reset',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Email': 'test@example.com'}),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.requestPasswordReset('test@example.com');

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/request-password-reset',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Email': 'test@example.com'}),
        ),
      ).called(1);
    });

    test('resetPassword should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/reset-password',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'Token': 'reset-token',
            'NewPassword': 'new-password',
            'ConfirmPassword': 'new-password',
          }),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.resetPassword(
        'reset-token',
        'new-password',
        'new-password',
      );

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/reset-password',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'Token': 'reset-token',
            'NewPassword': 'new-password',
            'ConfirmPassword': 'new-password',
          }),
        ),
      ).called(1);
    });

    test('getAccessToken should return access token', () async {
      // Arrange
      final responseData = {
        'access_token': 'test-access-token',
        'token_type': 'bearer',
        'expires_in': 3600,
      };

      when(
        mockClient.post(
          Uri.parse('https://test-domain.outseta.com/api/v1/tokens'),
          headers: anyNamed('headers'),
          body: jsonEncode({
            'username': 'test@example.com',
            'password': 'password123',
          }),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.getAccessToken(
        'test@example.com',
        'password123',
      );

      // Assert
      expect(result, equals('test-access-token'));
    });

    test('verifyEmail should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/verify-email',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Token': 'verification-token'}),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.verifyEmail('verification-token');

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/verify-email',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Token': 'verification-token'}),
        ),
      ).called(1);
    });

    test('requestEmailVerification should call the correct endpoint', () async {
      // Arrange
      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/request-email-verification',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Email': 'test@example.com'}),
        ),
      ).thenAnswer((_) async => http.Response('', 200));

      // Act
      await userProfileApi.requestEmailVerification('test@example.com');

      // Assert
      verify(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/request-email-verification',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'Email': 'test@example.com'}),
        ),
      ).called(1);
    });

    test('updateProfilePicture should update the profile picture', () async {
      // Arrange
      final base64Image = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA...';
      final responseData = {
        'Uid': '123',
        'Email': 'test@example.com',
        'FirstName': 'Test',
        'LastName': 'User',
        'ProfileImageS3Key': 'profile/updated-image.jpg',
      };

      when(
        mockClient.post(
          Uri.parse(
            'https://test-domain.outseta.com/api/v1/profile/user/update-profile-picture',
          ),
          headers: anyNamed('headers'),
          body: jsonEncode({'ProfileImage': base64Image}),
        ),
      ).thenAnswer((_) async => http.Response(jsonEncode(responseData), 200));

      // Act
      final result = await userProfileApi.updateProfilePicture(base64Image);

      // Assert
      expect(result.uid, equals('123'));
      expect(result.profileImageS3Key, equals('profile/updated-image.jpg'));
    });
  });
}
