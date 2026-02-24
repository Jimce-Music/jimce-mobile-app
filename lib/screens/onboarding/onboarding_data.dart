import 'package:flutter/material.dart';

class OnboardingContent {
  final String title;
  final String description;
  final IconData icon;

  OnboardingContent({required this.title, required this.description, required this.icon});
}

List<OnboardingContent> onboardingPages = [
  OnboardingContent(
    title: "Willkommen bei Jimce",
    description: "Deine Musik, dein Style, deine Regeln.",
    icon: Icons.music_note_rounded,
  ),
  OnboardingContent(
    title: "Setup",
    description: "Das folgende Setup wird dir bei der einrichtung der App helfen",
    icon: Icons.handyman,
  ),
];