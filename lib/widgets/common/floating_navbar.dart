import 'package:flutter/material.dart';

class FloatingNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final List<NavbarItem> items;

  const FloatingNavbar({
    required this.currentIndex,
    required this.onTabTapped,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get theme colors
    final screenWidth = MediaQuery.of(context).size.width; // Get screen width
    final buttonWidth = (screenWidth * 0.9) / items.length; // Ensure equal button width

    return Padding(

      padding: const EdgeInsets.only(bottom: 10.0), // Extra padding for floating effect
      child: Container(
        width: screenWidth * 0.95, // Set navbar width slightly less than screen
        constraints: BoxConstraints(maxWidth: 400), // Prevent extreme stretching
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: theme.cardColor, // Background color from theme
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Even spacing
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isActive = index == currentIndex;

            return GestureDetector(
              onTap: () => onTabTapped(index),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: buttonWidth, // Fixed width for each button
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: isActive
                    ? BoxDecoration(
                  color: theme.primaryColor, // Active button color
                  borderRadius: BorderRadius.circular(15.0),
                )
                    : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: isActive ? Colors.white : theme.primaryColor,
                      size: 24,
                    ),
                    SizedBox(height: 2),
                    Text(
                      item.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isActive ? Colors.white : theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class NavbarItem {
  final IconData icon;
  final String label;

  NavbarItem({required this.icon, required this.label});
}