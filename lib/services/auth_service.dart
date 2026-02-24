import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static Future<String?> login(String url, String username, String password) async {
    try {
      final uri = Uri.parse("${url}api/auth/login-basic");
      final response = await http.post(
        uri,
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Wir nehmen an, dass der Token im Feld 'token' zurückkommt
        return data['token'] as String?;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}