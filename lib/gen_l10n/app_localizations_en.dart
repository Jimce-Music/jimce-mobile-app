// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTab => 'Home';

  @override
  String get searchTab => 'Search';

  @override
  String get libraryTab => 'Library';

  @override
  String get settingsTab => 'Settings';

  @override
  String get searchHint => 'Search for song or artist...';

  @override
  String get resetAppTitle => 'Reset app?';

  @override
  String get resetAppMessage =>
      'All settings and the server connection will be deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get resetAppButton => 'RESET APP';

  @override
  String get letsGo => 'LET\'S GO';

  @override
  String get next => 'NEXT';

  @override
  String get welcomeTitle => 'Welcome to Jimce';

  @override
  String get welcomeDescription => 'Your music, your style, your rules.';

  @override
  String get setupTitle => 'Setup';

  @override
  String get setupDescription =>
      'The following setup will help you configure the app';

  @override
  String get serverSetupTitle => 'Set up server';

  @override
  String get serverSetupDescription => 'Connect the app to your Jimce server.';

  @override
  String get serverUrlHint => 'https://your-server.com';

  @override
  String get connect => 'CONNECT';

  @override
  String get serverConnectionFailed => 'Connection to server failed.';

  @override
  String get loginTitle => 'Login';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'SIGN IN';

  @override
  String get fillAllFields => 'Please fill in all fields.';

  @override
  String get invalidCredentials => 'Username or password incorrect.';
}
