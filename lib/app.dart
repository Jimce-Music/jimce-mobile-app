import 'package:flutter/material.dart';
import 'package:jimce/screens/home_screen.dart';
import 'package:jimce/screens/search_screen.dart';
import 'package:jimce/screens/playlist_screen.dart';
import 'package:jimce/screens/settings_screen.dart';
import 'package:jimce/screens/onboarding/onboarding_screen.dart';
import 'package:jimce/components/navbar.dart';
import 'package:jimce/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSettedUp') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.blackTheme,
      home: FutureBuilder<bool>(
        future: _checkOnboardingStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (snapshot.data == true) {
            return const MainNavigationWrapper(); 
          } else {
            return const OnboardingScreen(); 
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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: FloatingGlassNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}