import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavBar extends StatefulWidget {
  final int activeIndex;
  final ValueChanged<int> onTabTap;

  const NavBar({super.key, required this.activeIndex, required this.onTabTap});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isMenuOpen = false;

  final List<String> _navItems = [
    'Home',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 750;
    final topPadding = MediaQuery.of(context).padding.top;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: size.width,
          height: !isDesktop && _isMenuOpen ? (300.0 + topPadding) : (70.0 + topPadding),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: topPadding,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0E).withValues(alpha: 0.7),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Main Top Header Bar
              SizedBox(
                height: 69,
                child: Row(
                  mainAxisAlignment: isDesktop ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
                  children: [
                    // Nav links
                    if (isDesktop)
                      Row(
                        children: List.generate(_navItems.length, (index) {
                          return _buildDesktopNavItem(_navItems[index], index);
                        }),
                      )
                    else
                      IconButton(
                        icon: Icon(
                          _isMenuOpen ? Icons.close : Icons.menu,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isMenuOpen = !_isMenuOpen;
                          });
                        },
                      ),
                  ],
                ),
              ),

              // Mobile Menu Expansion
              if (!isDesktop && _isMenuOpen)
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_navItems.length, (index) {
                          return _buildMobileNavItem(_navItems[index], index);
                        }),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavItem(String label, int index) {
    final isActive = widget.activeIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTabTap(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: isActive
                      ? const Color(0xFFFFB703)
                      : Colors.white.withValues(alpha: 0.7),
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              // Indicator line
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: isActive ? 16 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFB703),
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String label, int index) {
    final isActive = widget.activeIndex == index;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isMenuOpen = false;
          });
          widget.onTabTap(index);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.outfit(
              color: isActive
                  ? const Color(0xFFFFB703)
                  : Colors.white.withValues(alpha: 0.8),
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
