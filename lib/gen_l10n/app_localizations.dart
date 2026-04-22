import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @searchTab.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTab;

  /// No description provided for @libraryTab.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTab;

  /// No description provided for @settingsTab.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTab;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for song or artist...'**
  String get searchHint;

  /// No description provided for @resetAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset app?'**
  String get resetAppTitle;

  /// No description provided for @resetAppMessage.
  ///
  /// In en, this message translates to:
  /// **'All settings and the server connection will be deleted.'**
  String get resetAppMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @resetAppButton.
  ///
  /// In en, this message translates to:
  /// **'RESET APP'**
  String get resetAppButton;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'LET\'S GO'**
  String get letsGo;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get next;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Jimce'**
  String get welcomeTitle;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your music, your style, your rules.'**
  String get welcomeDescription;

  /// No description provided for @setupTitle.
  ///
  /// In en, this message translates to:
  /// **'Setup'**
  String get setupTitle;

  /// No description provided for @setupDescription.
  ///
  /// In en, this message translates to:
  /// **'The following setup will help you configure the app'**
  String get setupDescription;

  /// No description provided for @serverSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up server'**
  String get serverSetupTitle;

  /// No description provided for @serverSetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect the app to your Jimce server.'**
  String get serverSetupDescription;

  /// No description provided for @serverUrlHint.
  ///
  /// In en, this message translates to:
  /// **'https://your-server.com'**
  String get serverUrlHint;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'CONNECT'**
  String get connect;

  /// No description provided for @serverConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection to server failed.'**
  String get serverConnectionFailed;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields.'**
  String get fillAllFields;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Username or password incorrect.'**
  String get invalidCredentials;

  /// No description provided for @settingsGroupGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get settingsGroupGeneral;

  /// No description provided for @settingsGroupPlayback.
  ///
  /// In en, this message translates to:
  /// **'Playback'**
  String get settingsGroupPlayback;

  /// No description provided for @settingsGroupLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get settingsGroupLibrary;

  /// No description provided for @settingsMenuAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsMenuAccount;

  /// No description provided for @settingsMenuDesign.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get settingsMenuDesign;

  /// No description provided for @settingsMenuLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsMenuLanguage;

  /// No description provided for @settingsMenuAutoplay.
  ///
  /// In en, this message translates to:
  /// **'Autoplay'**
  String get settingsMenuAutoplay;

  /// No description provided for @settingsMenuCrossfade.
  ///
  /// In en, this message translates to:
  /// **'Crossfade'**
  String get settingsMenuCrossfade;

  /// No description provided for @settingsMenuDownloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get settingsMenuDownloads;

  /// No description provided for @settingsMenuAboutJimce.
  ///
  /// In en, this message translates to:
  /// **'About Jimce'**
  String get settingsMenuAboutJimce;

  /// No description provided for @settingsMenuHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settingsMenuHelp;

  /// No description provided for @settingsChangePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsChangePasswordTitle;

  /// No description provided for @settingsPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsPasswordHint;

  /// No description provided for @settingsConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get settingsConfirmPasswordHint;

  /// No description provided for @settingsChangePasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsChangePasswordButton;

  /// No description provided for @settingsThemeBlack.
  ///
  /// In en, this message translates to:
  /// **'Theme: Black'**
  String get settingsThemeBlack;

  /// No description provided for @settingsLanguageGerman.
  ///
  /// In en, this message translates to:
  /// **'Language: German'**
  String get settingsLanguageGerman;

  /// No description provided for @settingsAutoplayTitle.
  ///
  /// In en, this message translates to:
  /// **'Autoplay'**
  String get settingsAutoplayTitle;

  /// No description provided for @settingsAutoplayDescription.
  ///
  /// In en, this message translates to:
  /// **'Automatically play similar songs'**
  String get settingsAutoplayDescription;

  /// No description provided for @settingsCrossfadeSongs.
  ///
  /// In en, this message translates to:
  /// **'Crossfade songs'**
  String get settingsCrossfadeSongs;

  /// No description provided for @settingsDownloadsTitle.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get settingsDownloadsTitle;

  /// No description provided for @settingsDownloadsWifiOnly.
  ///
  /// In en, this message translates to:
  /// **'Download only on Wi-Fi'**
  String get settingsDownloadsWifiOnly;

  /// No description provided for @settingsDownloadQualityHigh.
  ///
  /// In en, this message translates to:
  /// **'Download quality: High'**
  String get settingsDownloadQualityHigh;

  /// No description provided for @settingsAboutJimceTitle.
  ///
  /// In en, this message translates to:
  /// **'About Jimce'**
  String get settingsAboutJimceTitle;

  /// No description provided for @settingsAboutJimceDescription.
  ///
  /// In en, this message translates to:
  /// **'Information about app version, development, and licenses.'**
  String get settingsAboutJimceDescription;

  /// No description provided for @settingsAboutJimceAction.
  ///
  /// In en, this message translates to:
  /// **'Open app information'**
  String get settingsAboutJimceAction;

  /// No description provided for @settingsHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get settingsHelpTitle;

  /// No description provided for @settingsHelpFaq.
  ///
  /// In en, this message translates to:
  /// **'Frequently asked questions'**
  String get settingsHelpFaq;

  /// No description provided for @settingsHelpContact.
  ///
  /// In en, this message translates to:
  /// **'Contact support'**
  String get settingsHelpContact;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
