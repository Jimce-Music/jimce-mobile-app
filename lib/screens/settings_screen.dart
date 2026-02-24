import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jimce/screens/onboarding/onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _resetApp(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Löscht alle gespeicherten Daten (Onboarding-Status, Server-URL, etc.)
    await prefs.clear();

    if (!context.mounted) return;

    // Schickt den Nutzer zurück zum Anfang und löscht den gesamten Navigations-Stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      (route) => false,
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("App zurücksetzen?", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Alle Einstellungen und die Server-Verbindung werden gelöscht.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Abbrechen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resetApp(context);
            },
            child: const Text("Zurücksetzen", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Einstellungen"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Einstellungen verwalten',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const Spacer(),
            // Der Reset-Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.1),
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => _showResetDialog(context),
                child: const Text("APP ZURÜCKSETZEN", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 100), // Platz für die Navbar
          ],
        ),
      ),
    );
  }
}