import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jimce/app.dart';
import 'package:jimce/screens/onboarding/onboarding_data.dart';
import 'package:jimce/screens/onboarding/onboarding_dot_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSettedUp', true);
    
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainNavigationWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            // Obere Anzeige der Steps
            OnboardingDotIndicator(
              itemCount: onboardingPages.length,
              currentIndex: _currentPage,
            ),
            
            // Hauptinhalt (Slider)
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) => _buildPage(onboardingPages[index]),
              ),
            ),

            // Button unten
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: _buildButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingContent content) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Placeholder for Picture/Icon
          const Icon(Icons.music_note_rounded, size: 120, color: Colors.white),
          const SizedBox(height: 40),
          Text(
            content.title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            content.description,
            style: TextStyle(fontSize: 16, color: theme.textTheme.bodyMedium?.color),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    final theme = Theme.of(context);

    bool isLastPage = _currentPage == onboardingPages.length - 1;
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () {
          if (isLastPage) {
            _completeOnboarding();
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Text(
          isLastPage ? "LOS GEHT'S" : "WEITER",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}