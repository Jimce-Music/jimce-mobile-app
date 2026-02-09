import 'package:flutter/material.dart';
import 'package:jimce/components/navbar.dart'; // Pfad zu deiner navbar.dart

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 1. Variable zum Speichern des aktuellen Tabs
  int _selectedIndex = 0;

  // 2. Liste der Screens, die angezeigt werden sollen
  final List<Widget> _pages = [
    const Center(child: Text('Home Page', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Search Page', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Playlist Page', style: TextStyle(color: Colors.white, fontSize: 24))),
    const Center(child: Text('Settings Page', style: TextStyle(color: Colors.white, fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Wichtig für den Blur-Effekt
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A1A), Color(0xFF4A148C)], // Dunkler Musik-Vibe
          ),
        ),
        // 3. Zeige die Seite an, die zum aktuellen Index passt
        child: _pages[_selectedIndex],
      ),
      
      // 4. Deine Custom NavBar einbinden
      bottomNavigationBar: FloatingGlassNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // 5. Hier passiert die Magie: UI wird aktualisiert
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}