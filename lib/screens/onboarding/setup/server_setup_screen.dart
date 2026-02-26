import 'package:flutter/material.dart';
import 'package:jimce/screens/onboarding/setup/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jimce/screens/onboarding/setup/utils/url_helper.dart';
import 'package:jimce/services/ping_server.dart';

class ServerSetupScreen extends StatefulWidget {
  const ServerSetupScreen({super.key});

  @override
  State<ServerSetupScreen> createState() => _ServerSetupScreenState();
}

class _ServerSetupScreenState extends State<ServerSetupScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isChecking = false;
  String? _errorMessage;

  Future<void> _completeSetup() async {
    final rawInput = _urlController.text;
    if (rawInput.isEmpty) return;

    setState(() {
      _isChecking = true;
      _errorMessage = null;
    });

    // Nutzt den Helper
    final finalUrl = UrlHelper.formatServerUrl(rawInput);

    // Nutzt den Service
    final isAlive = await PingServer.checkConnection(finalUrl);

    if (isAlive) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('serverUrl', finalUrl);
      await prefs.setBool('finishedServerSetup', true);
      
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      if (!mounted) return;

      FocusScope.of(context).unfocus();

      setState(() {
        _errorMessage = "Verbindung zum Server fehlgeschlagen.";
        _isChecking = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset ist standardmäßig true, was gut ist!
        body: SafeArea(
          child: LayoutBuilder( // Hilft uns, die verfügbare Höhe zu berechnen
            builder: (context, constraints) {
              return SingleChildScrollView(
                // Ermöglicht das Zentrieren innerhalb des ScrollViews
                physics: const ClampingScrollPhysics(), 
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    // Mindesthöhe ist die Bildschirmhöhe (minus Keyboard/SafeArea)
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Column(
                        // Zentriert den Inhalt solange Platz da ist
                        mainAxisAlignment: MainAxisAlignment.center, 
                        children: [
                          const Icon(Icons.dns_rounded, size: 100, color: Colors.white),
                          const SizedBox(height: 30),
                          Text(
                            "Server einrichten",
                            style: TextStyle(
                              fontSize: 28, 
                              fontWeight: FontWeight.bold, 
                              color: theme.textTheme.bodyLarge?.color
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "Verbinde die App mit deinem Jimce-Server.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                          ),
                          const SizedBox(height: 40),
                          TextField(
                            controller: _urlController,
                            style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                            keyboardType: TextInputType.url,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: "https://dein-server.de",
                              hintStyle: TextStyle(color: theme.textTheme.bodySmall?.color),
                              filled: true,
                              fillColor: Colors.white.withValues(alpha: 0.05),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15), 
                                borderSide: BorderSide.none
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: _isChecking ? null : _completeSetup,
                              child: _isChecking 
                                ? const SizedBox(
                                    height: 20, 
                                    width: 20, 
                                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)
                                  )
                                : const Text("VERBINDEN", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                            ),
                          ),
                          
                          // Platzhalter für Fehlermeldung
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: _errorMessage != null ? 1.0 : 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text(
                                _errorMessage ?? "",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: theme.colorScheme.error, fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}