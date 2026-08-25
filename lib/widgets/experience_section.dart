import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Experience {
  final String company;
  final String location;
  final String role;
  final String date;
  final List<String> responsibilities;
  final Color color;

  const Experience({
    required this.company,
    required this.location,
    required this.role,
    required this.date,
    required this.responsibilities,
    required this.color,
  });
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  static final List<Experience> _experiences = [
    const Experience(
      company: '11 Values',
      location: 'Rwp, onsite',
      role: 'Flutter Developer',
      date: 'July 2025 - Feb 2026',
      color: Color(0xFFFFB703), // Amber
      responsibilities: [
        'Built a digital clock app with live prayer times, weather, and nearest mosque detection using Aladhan API, Firebase, and GetX.',
        'Developed ABC Islam app featuring audio-based ABC learning, multiple-choice quizzes, and video content for numbers and 99 Names of Allah.',
        'Built EzeeScanner with Google Drive auto-upload via OAuth 2.0, BLoC state management, watermark, edit, and blur features.',
        'Developed Bulgarian project with login, signup, forgot password authentication, and event notifications using Google Calendar API.',
      ],
    ),
    const Experience(
      company: 'Codex Dev',
      location: 'Peshawar, onsite',
      role: 'Flutter Developer',
      date: 'Jan 2025 - June 2025',
      color: Color(0xFF0EA5E9), // Cyan
      responsibilities: [
        'Built and enhanced Sales Reports, Product Management, and Payment modules using BLoC state management for clean architecture.',
        'Optimized image sliders and history tracking for faster load times and better performance.',
        'Implemented Settings pages including Disclaimer, About Us, and Privacy Policy.',
        'Integrated secure payment handling and ensured data consistency across modules.',
      ],
    ),
    const Experience(
      company: 'Synergistic Tech Solutions',
      location: 'Mardan, onsite',
      role: 'Flutter Developer Intern',
      date: 'June 2024 - Dec 2024',
      color: Color(0xFF8B5CF6), // Purple
      responsibilities: [
        'Built a Flutter Notes App with Firebase Auth, Firestore for storage, and Firebase Storage for image management.',
        'Implemented user profile settings with real-time sync and a clean responsive UI.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 850;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildSectionHeader(),
        const SizedBox(height: 48),

        // Timeline Items
        Column(
          children: List.generate(_experiences.length, (index) {
            return TimelineItemRow(
              item: _experiences[index],
              isFirst: index == 0,
              isLast: index == _experiences.length - 1,
              isDesktop: isDesktop,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFFFFB703),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Work Experience',
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'My professional background and timeline of working with onsite teams and internships.',
          style: GoogleFonts.outfit(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class TimelineItemRow extends StatefulWidget {
  final Experience item;
  final bool isFirst;
  final bool isLast;
  final bool isDesktop;

  const TimelineItemRow({
    super.key,
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.isDesktop,
  });

  @override
  State<TimelineItemRow> createState() => _TimelineItemRowState();
}

class _TimelineItemRowState extends State<TimelineItemRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.isDesktop) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Column: Date range
            SizedBox(
              width: 180,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, right: 24),
                  child: Text(
                    widget.item.date,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.outfit(
                      color: _isHovered
                          ? widget.item.color
                          : Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // Middle Column: Timeline node
            TimelineNode(
              isHovered: _isHovered,
              color: widget.item.color,
              isFirst: widget.isFirst,
              isLast: widget.isLast,
            ),

            // Right Column: Experience Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: ExperienceCard(
                    item: widget.item,
                    isHovered: _isHovered,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Mobile Layout
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Column: Timeline node
            TimelineNode(
              isHovered: _isHovered,
              color: widget.item.color,
              isFirst: widget.isFirst,
              isLast: widget.isLast,
            ),

            // Right Column: Date + Card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _isHovered = true),
                  onExit: (_) => setState(() => _isHovered = false),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: Text(
                          widget.item.date,
                          style: GoogleFonts.outfit(
                            color: _isHovered
                                ? widget.item.color
                                : Colors.white.withValues(alpha: 0.5),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ExperienceCard(item: widget.item, isHovered: _isHovered),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class TimelineNode extends StatelessWidget {
  final bool isHovered;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const TimelineNode({
    super.key,
    required this.isHovered,
    required this.color,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vertical Line
          Positioned(
            top: isFirst ? 32 : 0,
            bottom: isLast ? null : 0,
            height: isLast ? 32 : null,
            child: Container(
              width: 2,
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          // Glow and Circle Dot
          Positioned(
            top: 24,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: isHovered ? 18 : 12,
              height: isHovered ? 18 : 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHovered ? color : Colors.white.withValues(alpha: 0.25),
                border: Border.all(
                  color: isHovered
                      ? Colors.white
                      : color.withValues(alpha: 0.5),
                  width: isHovered ? 3 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: isHovered ? 0.6 : 0.15),
                    blurRadius: isHovered ? 12 : 6,
                    spreadRadius: isHovered ? 2 : 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience item;
  final bool isHovered;

  const ExperienceCard({
    super.key,
    required this.item,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(isHovered ? 6.0 : 0.0, 0.0, 0.0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F16),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHovered
              ? item.color.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.06),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isHovered
                ? item.color.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.15),
            blurRadius: isHovered ? 20 : 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header info
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: item.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FaIcon(
                  FontAwesomeIcons.briefcase,
                  color: item.color,
                  size: 16,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.role,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${item.company} • ${item.location}',
                      style: GoogleFonts.outfit(
                        color: item.color,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Responsibilities list
          Column(
            children: item.responsibilities.map((bullet) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 10.0),
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item.color.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bullet,
                        style: GoogleFonts.outfit(
                          color: Colors.white.withValues(alpha: 0.75),
                          fontSize: 14,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
