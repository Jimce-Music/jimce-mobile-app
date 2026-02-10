class OnboardingContent {
  final String title;
  final String description;

  OnboardingContent({required this.title, required this.description});
}

List<OnboardingContent> onboardingPages = [
  OnboardingContent(
    title: "Willkommen bei Jimce",
    description: "Deine Musik, dein Style, deine Regeln.",
  ),
  OnboardingContent(
    title: "Intelligente Suche",
    description: "Finde genau das, was du gerade hören willst.",
  ),
  OnboardingContent(
    title: "Alles bereit?",
    description: "Erstelle jetzt dein Konto und leg sofort los.",
  ),
];