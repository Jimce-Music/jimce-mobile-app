import 'package:jimce_api_flutter/jimce_api_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _serverUrlPrefKey = 'serverUrl';
const String _userTokenPrefKey = 'userToken';
const String _defaultServerUrl = 'http://192.168.188.27:8080';

JimceApiFlutter _apiClient = JimceApiFlutter(
  basePathOverride: _defaultServerUrl,
);

DefaultApi _api = _apiClient.getDefaultApi();

JimceApiFlutter get apiClient => _apiClient;
DefaultApi get api => _api;

String _normalizeBaseUrl(String baseUrl) {
  final trimmed = baseUrl.trim();
  if (trimmed.isEmpty) return _defaultServerUrl;
  return trimmed.endsWith('/') ? trimmed.substring(0, trimmed.length - 1) : trimmed;
}

void _rebuildApiClient({required String baseUrl, String? token}) {
  _apiClient = JimceApiFlutter(basePathOverride: _normalizeBaseUrl(baseUrl));

  if (token != null && token.isNotEmpty) {
    _apiClient.setBearerAuth('bearerAuth', token);
  }

  _api = _apiClient.getDefaultApi();
}

Future<void> initializeApiFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final serverUrl = prefs.getString(_serverUrlPrefKey) ?? _defaultServerUrl;
  final token = prefs.getString(_userTokenPrefKey);

  _rebuildApiClient(baseUrl: serverUrl, token: token);
}

Future<void> setApiAuthToken(String? token) async {
  final prefs = await SharedPreferences.getInstance();
  final serverUrl = prefs.getString(_serverUrlPrefKey) ?? _defaultServerUrl;

  if (token == null || token.isEmpty) {
    await prefs.remove(_userTokenPrefKey);
  } else {
    await prefs.setString(_userTokenPrefKey, token);
  }

  _rebuildApiClient(baseUrl: serverUrl, token: token);
}

Future<void> setApiServerUrl(String serverUrl) async {
  final prefs = await SharedPreferences.getInstance();
  final normalizedServerUrl = _normalizeBaseUrl(serverUrl);
  final token = prefs.getString(_userTokenPrefKey);

  await prefs.setString(_serverUrlPrefKey, normalizedServerUrl);
  _rebuildApiClient(baseUrl: normalizedServerUrl, token: token);
}

Future<void> resetApiToDefault() async {
  _rebuildApiClient(baseUrl: _defaultServerUrl);
}
