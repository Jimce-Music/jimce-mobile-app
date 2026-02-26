import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingGlassNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  // Hier definierst du deine Menüpunkte mit festen IDs
  final List<Map<String, dynamic>> navItems = const [
    {'id': 0, 'icon': Icons.home_filled},
    {'id': 1, 'icon': Icons.search},
    {'id': 2, 'icon': Icons.library_music},
    {'id': 3, 'icon': Icons.settings},
  ];

  const FloatingGlassNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Zugriff auf die Theme-Farben
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline;
    final accentColor = theme.colorScheme.primary;

    double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding + 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int visualIndex = navItems.indexWhere((item) => item['id'] == currentIndex);
          if (visualIndex == -1) visualIndex = 0;

          return ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: borderColor.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                ),
                // Das Padding hier sorgt dafür, dass die Pille den Border nie berührt
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), 
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Die Breite basiert jetzt auf dem bereits reduzierten Platz
                    double itemWidth = constraints.maxWidth / navItems.length;
                    int visualIndex = navItems.indexWhere((item) => item['id'] == currentIndex);
                    if (visualIndex == -1) visualIndex = 0;

                    return Stack(
                      clipBehavior: Clip.none, // Verhindert unschöne Abschneidungen
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutBack,
                          left: visualIndex * itemWidth,
                          top: 0,
                          bottom: 0, // Pille füllt die vertikale Höhe des Paddings aus
                          child: Container(
                            width: itemWidth,
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        Row(
                          children: navItems.map((item) {
                            return _buildNavItem(context, id: item['id'], icon: item['icon']);
                          }).toList(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // BuildNavItem leicht angepasst für Theme-Farben
  Widget _buildNavItem(BuildContext context, {required int id, required IconData icon}) {
    bool isSelected = currentIndex == id;
    final accentColor = Theme.of(context).colorScheme.primary;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(id),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 70,
          child: Icon(
            icon,
            // Bei Auswahl leuchtet das Icon in der Akzentfarbe (Gelb/Gold)
            color: isSelected ? accentColor : Colors.white.withValues(alpha: 0.4),
            size: 26,
          ),
        ),
      ),
    );
  }
}