import 'package:jimce/utils/init_api.dart';
import 'package:dio/dio.dart';
import 'package:jimce_api_flutter/jimce_api_flutter.dart';

enum LoginFailureReason {
  invalidCredentials,
  serverUnreachable,
  unknown,
}

class LoginResult {
  final String? token;
  final LoginFailureReason? failureReason;

  const LoginResult._({this.token, this.failureReason});

  const LoginResult.success(String token) : this._(token: token);
  const LoginResult.failure(LoginFailureReason reason)
      : this._(failureReason: reason);

  bool get isSuccess => token != null;
}

class AuthService {
  static Future<LoginResult> login(String username, String password) async {
    try {
      await initializeApiFromStorage();
      final response = await api.apiAuthLoginBasicPost(
        apiAuthLoginBasicPostRequest: ApiAuthLoginBasicPostRequest(
          username: username,
          password: password,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return LoginResult.success(response.data!.token);
      }

      return const LoginResult.failure(LoginFailureReason.invalidCredentials);
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;

      if (statusCode == 401 || statusCode == 403) {
        return const LoginResult.failure(LoginFailureReason.invalidCredentials);
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.connectionError) {
        return const LoginResult.failure(LoginFailureReason.serverUnreachable);
      }

      return const LoginResult.failure(LoginFailureReason.unknown);
    } catch (_) {
      return const LoginResult.failure(LoginFailureReason.unknown);
    }
  }
}