import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/experience_section.dart';
import '../widgets/footer_section.dart';
import '../widgets/nav_bar.dart';
import '../widgets/projects_section.dart';
import '../widgets/skills_rotator.dart';
import '../widgets/skills_section.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _footerKey = GlobalKey();

  int _activeNavIndex = 0;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // 1. Scroll to top button visibility
    final showFab = _scrollController.offset > 400;
    if (showFab != _showBackToTop) {
      setState(() {
        _showBackToTop = showFab;
      });
    }

    // 2. Active section highlights on scroll
    double? getOffset(GlobalKey key) {
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null) {
          return box.localToGlobal(Offset.zero).dy + _scrollController.offset;
        }
      }
      return null;
    }

    final skillsY = getOffset(_skillsKey) ?? 500.0;
    final projectsY = getOffset(_projectsKey) ?? 1100.0;
    final experienceY = getOffset(_experienceKey) ?? 1900.0;
    final footerY = getOffset(_footerKey) ?? 2600.0;

    final currentScroll =
        _scrollController.offset + 140; // 140px offset trigger

    int newIndex = 0;
    if (currentScroll >= footerY - 200) {
      newIndex = 4; // Contact
    } else if (currentScroll >= experienceY) {
      newIndex = 3; // Experience
    } else if (currentScroll >= projectsY) {
      newIndex = 2; // Projects
    } else if (currentScroll >= skillsY) {
      newIndex = 1; // Skills
    } else {
      newIndex = 0; // Home
    }

    if (newIndex != _activeNavIndex) {
      setState(() {
        _activeNavIndex = newIndex;
      });
    }
  }

  void _scrollToSection(int index) {
    GlobalKey key;
    switch (index) {
      case 0:
        key = _heroKey;
        break;
      case 1:
        key = _skillsKey;
        break;
      case 2:
        key = _projectsKey;
        break;
      case 3:
        key = _experienceKey;
        break;
      case 4:
        key = _footerKey;
        break;
      default:
        return;
    }

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1000;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0E),
      body: Stack(
        children: [
          // Cyber Grid Background
          Positioned.fill(child: CustomPaint(painter: GridBackgroundPainter())),

          // Main Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 94,
                bottom: 30,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1280),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        key: _heroKey,
                        child: _buildMobileLayout(isDesktop),
                      ),
                      const SizedBox(height: 100),
                      Container(key: _skillsKey, child: const SkillsSection()),
                      const SizedBox(height: 100),
                      Container(
                        key: _projectsKey,
                        child: const ProjectsSection(),
                      ),
                      const SizedBox(height: 100),
                      Container(
                        key: _experienceKey,
                        child: const ExperienceSection(),
                      ),
                      const SizedBox(height: 100),
                      Container(
                        key: _footerKey,
                        child: FooterSection(onTabTap: _scrollToSection),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Sticky Navigation Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              activeIndex: _activeNavIndex,
              onTabTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        _buildHeading(isCentered: !isDesktop),
        const SizedBox(height: 12),
        _buildRotatingSubheading(isCentered: !isDesktop),
        const SizedBox(height: 16),
        _buildDescription(isCentered: !isDesktop),
        const SizedBox(height: 32),
        _buildStatsRow(isCentered: !isDesktop),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildHeading({required bool isCentered}) {
    return Wrap(
      alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
      children: [
        Text(
          "Hi, I'm ",
          style: GoogleFonts.outfit(
            fontSize: isCentered ? 42 : 56,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            height: 1.1,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFB703), Color(0xFFFB8500)],
          ).createShader(bounds),
          child: Text(
            "Faiz MK",
            style: GoogleFonts.outfit(
              fontSize: isCentered ? 42 : 56,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRotatingSubheading({required bool isCentered}) {
    if (isCentered) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Specializing in',
            style: GoogleFonts.outfit(
              color: Colors.white.withOpacity(0.7),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          const SkillsRotator(
            textStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFB703),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        Text(
          'Specializing in ',
          style: GoogleFonts.outfit(
            color: Colors.white.withOpacity(0.7),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(
          child: Align(alignment: Alignment.centerLeft, child: SkillsRotator()),
        ),
      ],
    );
  }

  Widget _buildDescription({required bool isCentered}) {
    return Text(
      isCentered
          ? 'An Enthusiastic Flutter developer crafted to turn ideas into production-ready, beautiful, and fluid mobile and web apps.'
          : 'An Enthusiastic Flutter developer who turns ideas into production-ready, beautiful, and fluid mobile & web apps. Expert in state management, high-performance UI, and clean code principles.',
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      style: GoogleFonts.outfit(
        color: Colors.white.withValues(alpha: 0.6),
        fontSize: isCentered ? 14 : 16,
        height: isCentered ? 1.5 : 1.6,
      ),
    );
  }

  Widget _buildStatsRow({required bool isCentered}) {
    final stats = [
      {'val': '1+', 'label': 'Years Exp'},
      {'val': '50+', 'label': 'Completed Apps'},
      {'val': '100%', 'label': 'On-Time Delivery'},
    ];

    final children = stats.map((stat) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: isCentered
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text(
              stat['val']!,
              style: GoogleFonts.outfit(
                color: const Color(0xFFFFB703),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              stat['label']!,
              style: GoogleFonts.outfit(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
      children: children,
    );
  }
}

class GridBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.015)
      ..strokeWidth = 1.0;

    const step = 50.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Centered radial glow
    final rect = Offset.zero & size;
    final gradient = RadialGradient(
      center: const Alignment(
        0.3,
        0.0,
      ), // slightly offset towards desktop mockup area
      radius: 0.7,
      colors: [
        Colors.blueAccent.withOpacity(0.05),
        Colors.purpleAccent.withOpacity(0.03),
        Colors.transparent,
      ],
    );
    final glowPaint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, glowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ConnectorLinesPainter extends CustomPainter {
  final List<Offset> chipPoints;
  final List<Offset> phonePoints;
  final List<Color> colors;
  final int? hoveredIndex;

  ConnectorLinesPainter({
    required this.chipPoints,
    required this.phonePoints,
    required this.colors,
    this.hoveredIndex,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < chipPoints.length; i++) {
      final isHovered = hoveredIndex == i;
      final start = chipPoints[i];
      final end = phonePoints[i];
      final color = colors[i];

      // Draw shadow/glow under the line if hovered
      if (isHovered) {
        final glowPaint = Paint()
          ..color = color.withOpacity(0.35)
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

        final path = Path()..moveTo(start.dx, start.dy);
        final controlX = start.dx + (end.dx - start.dx) * 0.45;
        path.quadraticBezierTo(controlX, start.dy, end.dx, end.dy);
        canvas.drawPath(path, glowPaint);
      }

      final paint = Paint()
        ..color = isHovered ? color.withOpacity(0.9) : color.withOpacity(0.18)
        ..strokeWidth = isHovered ? 2.8 : 1.2
        ..style = PaintingStyle.stroke;

      final path = Path()..moveTo(start.dx, start.dy);
      // Bend curve organically towards phone mockup border
      final controlX = start.dx + (end.dx - start.dx) * 0.45;
      path.quadraticBezierTo(controlX, start.dy, end.dx, end.dy);
      canvas.drawPath(path, paint);

      // Draw dots at connections
      final dotPaint = Paint()
        ..color = isHovered ? color : color.withOpacity(0.4)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(end, isHovered ? 4.5 : 2.5, dotPaint);
      canvas.drawCircle(start, isHovered ? 3.5 : 2.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ConnectorLinesPainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex ||
        oldDelegate.chipPoints != chipPoints ||
        oldDelegate.phonePoints != phonePoints;
  }
}

class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String url;

  const SocialIconButton({super.key, required this.icon, required this.url});

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> {
  bool _isHovered = false;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFFB703).withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFFB703)
                  : Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFFB703).withValues(alpha: 0.15),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: FaIcon(
            widget.icon,
            color: _isHovered ? const Color(0xFFFFB703) : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
