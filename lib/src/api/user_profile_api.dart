import '../models/user.dart';
import '../outseta_client.dart';

/// The User Profile API client for managing user profiles
class UserProfileApi {
  /// Creates a new User Profile API client
  UserProfileApi(this._client);

  final OutsetaClient _client;

  /// Get the current user's profile
  Future<User> getCurrentUser() async {
    final response = await _client.get('profile/user');
    return User.fromJson(response);
  }

  /// Update the current user's profile
  Future<User> updateCurrentUser(User user) async {
    final response = await _client.put('profile/user', body: user.toJson());
    return User.fromJson(response);
  }

  /// Change the current user's password
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    await _client.post(
      'profile/user/change-password',
      body: {
        'CurrentPassword': currentPassword,
        'NewPassword': newPassword,
        'ConfirmPassword': confirmPassword,
      },
    );
  }

  /// Request a password reset for a user
  Future<void> requestPasswordReset(String email) async {
    await _client.post('profile/user/request-password-reset', body: {'Email': email});
  }

  /// Reset a user's password using a reset token
  Future<void> resetPassword(String token, String newPassword, String confirmPassword) async {
    await _client.post(
      'profile/user/reset-password',
      body: {'Token': token, 'NewPassword': newPassword, 'ConfirmPassword': confirmPassword},
    );
  }

  /// Get the user's access token for client-side authentication
  Future<String> getAccessToken(String username, String password) async {
    final response = await _client.post(
      'tokens',
      body: {'username': username, 'password': password},
    );
    return response['access_token'];
  }

  /// Verify an email address using a verification token
  Future<void> verifyEmail(String token) async {
    await _client.post('profile/user/verify-email', body: {'Token': token});
  }

  /// Request a new email verification token
  Future<void> requestEmailVerification(String email) async {
    await _client.post('profile/user/request-email-verification', body: {'Email': email});
  }

  /// Update the user's profile picture
  Future<User> updateProfilePicture(String base64Image) async {
    final response = await _client.post(
      'profile/user/update-profile-picture',
      body: {'ProfileImage': base64Image},
    );
    return User.fromJson(response);
  }
}
