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
    double bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding + 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          int itemCount = navItems.length;
          double totalWidth = constraints.maxWidth;
          double usableWidth = totalWidth - 20; 
          double itemWidth = usableWidth / itemCount;

          // Wir suchen den visuellen Index basierend auf der ID, 
          // damit die Pille immer an der richtigen Stelle steht.
          int visualIndex = navItems.indexWhere((item) => item['id'] == currentIndex);
          // Falls die ID nicht gefunden wird (Sicherheit), nimm 0
          if (visualIndex == -1) visualIndex = 0;

          return ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Stack(
                  children: [
                    // DIE WANDERNDE PILLE
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutBack,
                      left: 10 + (visualIndex * itemWidth),
                      top: 10,
                      child: Container(
                        width: itemWidth,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    // DIE ICONS
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: navItems.map((item) {
                          return _buildNavItem(
                            id: item['id'], 
                            icon: item['icon'],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem({required int id, required IconData icon}) {
    bool isSelected = currentIndex == id;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(id), // Gibt die feste ID zurück
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 70,
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.4),
            size: 26,
          ),
        ),
      ),
    );
  }
}