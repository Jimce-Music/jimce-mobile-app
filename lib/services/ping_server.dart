import 'package:jimce_api_flutter/jimce_api_flutter.dart';

class PingServer {
  static Future<bool> checkConnection(String finalUrl) async {
    try {
      final client = JimceApiFlutter(basePathOverride: finalUrl);
      final response = await client.getDefaultApi().apiPingGet();

      if (response.statusCode != 200) return false;

      final responseText = response.data;
      if (responseText != 'pong by jimce backend') return false;

      return response.statusCode == 200;
      
    } catch (_) {
      return false;
    }
  }
}