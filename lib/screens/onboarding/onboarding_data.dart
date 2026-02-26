import 'package:flutter/material.dart';
import 'package:jimce/gen_l10n/app_localizations.dart';

class OnboardingContent {
  final String Function(AppLocalizations) getTitle;
  final String Function(AppLocalizations) getDescription;
  final IconData icon;

  OnboardingContent({required this.getTitle, required this.getDescription, required this.icon});
}

List<OnboardingContent> onboardingPages = [
  OnboardingContent(
    getTitle: (l10n) => l10n.welcomeTitle,
    getDescription: (l10n) => l10n.welcomeDescription,
    icon: Icons.music_note_rounded,
  ),
  OnboardingContent(
    getTitle: (l10n) => l10n.setupTitle,
    getDescription: (l10n) => l10n.setupDescription,
    icon: Icons.handyman,
  ),
];