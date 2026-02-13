import 'package:flutter/material.dart';
import 'package:jimce/screens/home_screen.dart';
import 'package:jimce/screens/onboarding/setup/login_screen.dart';
import 'package:jimce/screens/search_screen.dart';
import 'package:jimce/screens/playlist_screen.dart';
import 'package:jimce/screens/settings_screen.dart';
import 'package:jimce/screens/onboarding/onboarding_screen.dart';
import 'package:jimce/components/navbar.dart';
import 'package:jimce/utils/app_theme.dart';
import 'package:jimce/screens/onboarding/setup/server_setup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'), // English
        Locale('de'), // Spanish
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

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SizedBox.expand(child: _pages[_selectedIndex]),
      bottomNavigationBar: FloatingGlassNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}