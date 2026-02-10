import 'package:flutter/material.dart';

class OnboardingDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const OnboardingDotIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isActive = currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8, // Breiterer Punkt wenn aktiv
          decoration: BoxDecoration(
            color: isActive ? theme.textTheme.bodyLarge?.color : theme.textTheme.bodySmall?.color,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}