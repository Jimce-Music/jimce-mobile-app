import 'package:flutter/material.dart';
import 'package:jimce/screens/home_screen.dart';
import 'package:jimce/screens/onboarding/setup/login_screen.dart';
import 'package:jimce/screens/search_screen.dart';
import 'package:jimce/screens/library_screen.dart';
import 'package:jimce/screens/settings_screen.dart';
import 'package:jimce/screens/onboarding/onboarding_screen.dart';
import 'package:jimce/components/navbar.dart';
import 'package:jimce/utils/app_theme.dart';
import 'package:jimce/screens/onboarding/setup/server_setup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jimce/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Prüft jetzt beide Status-Werte
  Future<Map<String, bool>> _checkAppState() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'finishedOnboarding': prefs.getBool('finishedOnboarding') ?? false,
      'finishedServerSetup': prefs.getBool('finishedServerSetup') ?? false,
      'isSetUp': prefs.getBool('isSetUp') ?? false
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.blackTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // Englisch als Fallback
        Locale('de'),
      ],
      home: FutureBuilder<Map<String, bool>>(
        future: _checkAppState(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          final bool finishedOnboarding = snapshot.data?['finishedOnboarding'] ?? false;
          final bool finishedServerSetup = snapshot.data?['finishedServerSetup'] ?? false;
          final bool isSetUp = snapshot.data?['isSetUp'] ?? false;

          // Logik-Weiche:
          if (!finishedOnboarding) {
            // 1. Wenn Onboarding nicht fertig -> Onboarding
            return const OnboardingScreen();
          } else if (!finishedServerSetup) {
            // 2. Wenn Onboarding fertig, aber kein Server-Setup -> Setup Screen
            return const ServerSetupScreen();
          } else if (!isSetUp) {
            // 3. Wenn Server Setup fertig, aber kein Login -> Login Screen
            return const LoginScreen();
          } else {
            // 4. Beides erledigt -> Haupt-App
            return const MainNavigationWrapper();
          }
        },
      ),
    );
  }
}

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;
  
  // Key für den SearchScreen erstellen
  final GlobalKey<SearchScreenState> _searchKey = GlobalKey<SearchScreenState>();

  // Pages als Methode oder spät initialisierte Liste, damit der Key übergeben werden kann
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      SearchScreen(key: _searchKey), // Key hier übergeben
      const PlaylistScreen(),
      const SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // Wenn der Nutzer bereits auf der Suche ist (Index 1)
      if (index == 1) {
        // Rufe die Methode im SearchScreenState auf
        _searchKey.currentState?.openKeyboard();
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // IndexedStack nutzen, damit der SearchScreen (und sein Key) im Speicher bleibt
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: FloatingGlassNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Neue Logik-Funktion nutzen
      ),
    );
  }
}