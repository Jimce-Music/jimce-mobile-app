import 'package:http/http.dart' as http;

class PingServer {
  static Future<bool> checkConnection(String finalUrl) async {
    try {
      final baseUrl = Uri.parse(finalUrl);
      final fullUrl = baseUrl.replace(
        path: baseUrl.path.endsWith('/') 
            ? "${baseUrl.path}api/ping" 
            : "${baseUrl.path}/api/ping"
      );

      final response = await http.get(fullUrl).timeout(const Duration(seconds: 5));

      if (response.statusCode != 200) return false;

      final responseText = response.body;

      if (responseText != 'pong by jimce backend') return false;

      return response.statusCode == 200;
      
    } catch (_) {
      return false;
    }
  }
}