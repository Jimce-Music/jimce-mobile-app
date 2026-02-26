// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get homeTab => 'Startseite';

  @override
  String get searchTab => 'Suchen';

  @override
  String get libraryTab => 'Bibliothek';

  @override
  String get settingsTab => 'Einstellungen';

  @override
  String get searchHint => 'Song oder Künstler suchen...';

  @override
  String get resetAppTitle => 'App zurücksetzen?';

  @override
  String get resetAppMessage =>
      'Alle Einstellungen und die Server-Verbindung werden gelöscht.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get resetAppButton => 'APP ZURÜCKSETZEN';

  @override
  String get letsGo => 'LOS GEHT\'S';

  @override
  String get next => 'WEITER';

  @override
  String get welcomeTitle => 'Willkommen bei Jimce';

  @override
  String get welcomeDescription => 'Deine Musik, dein Style, deine Regeln.';

  @override
  String get setupTitle => 'Setup';

  @override
  String get setupDescription =>
      'Das folgende Setup wird dir bei der einrichtung der App helfen';

  @override
  String get serverSetupTitle => 'Server einrichten';

  @override
  String get serverSetupDescription =>
      'Verbinde die App mit deinem Jimce-Server.';

  @override
  String get serverUrlHint => 'https://dein-server.de';

  @override
  String get connect => 'VERBINDEN';

  @override
  String get serverConnectionFailed => 'Verbindung zum Server fehlgeschlagen.';

  @override
  String get loginTitle => 'Login';

  @override
  String get username => 'Benutzername';

  @override
  String get password => 'Passwort';

  @override
  String get signIn => 'ANMELDEN';

  @override
  String get fillAllFields => 'Bitte fülle alle Felder aus.';

  @override
  String get invalidCredentials => 'Benutzername oder Passwort falsch.';
}
