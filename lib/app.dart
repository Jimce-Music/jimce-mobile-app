import 'package:flutter/material.dart';
import 'package:jimce/screens/home_screen.dart';
import 'package:jimce/screens/search_screen.dart';
import 'package:jimce/screens/playlist_screen.dart';
import 'package:jimce/screens/settings_screen.dart';
import 'package:jimce/components/navbar.dart';
import 'package:jimce/utils/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // Hier definierst du die Liste der Screens
  final List<Widget> _pages = [
    const HomeScreen(), // Dein eigentlicher Home-Inhalt
    const SearchScreen(),
    const PlaylistScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.blackTheme,
      home: Scaffold(
        extendBody: true,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // Das Handling der Anzeige erfolgt jetzt hier zentral
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
      ),
    );
  }
}
