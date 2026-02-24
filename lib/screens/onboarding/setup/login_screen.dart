import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jimce/services/auth_service.dart';
import 'package:jimce/app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isObscured = true;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleLogin() async {
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      setState(() => _errorMessage = "Bitte fülle alle Felder aus.");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final prefs = await SharedPreferences.getInstance();
    final serverUrl = prefs.getString('serverUrl') ?? "";

    // 1. Login-Anfrage senden und Token erhalten
    final String? token = await AuthService.login(
      serverUrl, 
      _userController.text, 
      _passController.text
    );

    if (token != null) {
      // 2. Token in SharedPreferences speichern
      await prefs.setString('userToken', token);
      await prefs.setBool('isSetUp', true);
      
      if (!mounted) return;
      
      // 3. Weiterleitung zur App
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainNavigationWrapper()),
      );
    } else {
      FocusScope.of(context).unfocus();
      setState(() {
        _isLoading = false;
        _errorMessage = "Benutzername oder Passwort falsch.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock_person_rounded, size: 80, color: Colors.white),
                const SizedBox(height: 20),
                const Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 40),

                // Benutzername
                TextField(
                  controller: _userController,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Benutzername", Icons.person_outline),
                ),
                const SizedBox(height: 20),

                // Passwort
                TextField(
                  controller: _passController,
                  obscureText: _isObscured,
                  style: const TextStyle(color: Colors.white),
                  decoration: _inputDecoration("Passwort", Icons.lock_outline).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility, color: Colors.white54),
                      onPressed: () => setState(() => _isObscured = !_isObscured),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: _isLoading ? null : _handleLogin,
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text("ANMELDEN", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),

                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent)),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.white54),
      hintStyle: const TextStyle(color: Colors.white24),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
    );
  }
}