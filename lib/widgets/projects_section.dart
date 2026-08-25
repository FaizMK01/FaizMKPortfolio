import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Project {
  final String title;
  final String subtitle;
  final List<String> bullets;
  final List<String> tech;
  final String? link;
  final Color primaryColor;
  final IconData icon;

  const Project({
    required this.title,
    required this.subtitle,
    required this.bullets,
    required this.tech,
    required this.primaryColor,
    required this.icon,
    this.link,
  });
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static final List<Project> _projects = [
    const Project(
      title: 'Equally',
      subtitle: 'Bill Splitting & Debt Settlement App',
      icon: FontAwesomeIcons.wallet,
      primaryColor: Color(0xFF3ECF8E), // Supabase Green
      link:
          'https://play.google.com/store/apps/details?id=com.devorastudios.equally',
      tech: ['Flutter', 'Riverpod', 'Supabase', 'Hive', 'Clean Architecture'],
      bullets: [
        'Built a Flutter bill-splitting app with Supabase backend for real-time expense management and automated debt settlement.',
        'Integrated FCM, Supabase Edge Functions, and offline-first architecture using Hive.',
        'Used Clean Architecture & Riverpod, handling full development and deployment independently.',
      ],
    ),
    const Project(
      title: 'Study Coach AI',
      subtitle: 'AI-Powered Study Planner & Tutor',
      icon: FontAwesomeIcons.graduationCap,
      primaryColor: Color(0xFF8B5CF6), // Purple
      link:
          'https://play.google.com/store/apps/details?id=com.devorastudios.studycoach',
      tech: ['Flutter', 'BLoC', 'Hive', 'Gemini API', 'Groq API'],
      bullets: [
        'Built a cross-platform Flutter app with BLoC and glassmorphic UI for clean, scalable architecture.',
        'Developed Pomodoro timer, study analytics dashboard, and gamified XP system for subject progress tracking.',
        'Integrated Gemini API to generate personalized AI study plans and provide coding help and subject tutoring.',
        'Used Groq API (llama-3.3-70b-versatile model) for real-time AI chatbot conversations.',
      ],
    ),
    const Project(
      title: 'Chat AI Bot',
      subtitle: 'Smart Assistant & Creative Tool',
      icon: FontAwesomeIcons.robot,
      primaryColor: Color(0xFFEC4899), // Pink
      tech: ['Flutter', 'GetX', 'APIs'],
      bullets: [
        'Built an AI chat app with text-to-image generation, translation, and media sharing.',
        'Optimized state management using GetX with custom animations for smooth UX.',
      ],
    ),
    const Project(
      title: 'E-Commerce App',
      subtitle: 'Full-Featured Online Store & Dashboard',
      icon: FontAwesomeIcons.bagShopping,
      primaryColor: Color(0xFFFFB703), // Amber/Orange
      tech: ['Flutter', 'GetX', 'Firebase', 'Stripe'],
      bullets: [
        'Built a Flutter e-commerce app with separate user/admin panels, Firebase integration, and real-time product management.',
        'Integrated Stripe payment gateway and GetX for smooth state management.',
      ],
    ),
    const Project(
      title: 'Doctor Appointment App',
      subtitle: 'Real-time Booking & Map Finder',
      icon: FontAwesomeIcons.userDoctor,
      primaryColor: Color(0xFF0EA5E9), // Cyan/Blue
      tech: ['Flutter', 'GetX', 'Firebase', 'Google Maps'],
      bullets: [
        'Built a real-time doctor booking app with Google Maps integrating nearest doctor search (within 10km).',
        'Integrated Firebase Auth & Firestore for robust user authentication and live data management.',
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    int columnsCount = 1;
    if (width >= 1150) {
      columnsCount = 3;
    } else if (width >= 750) {
      columnsCount = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        _buildSectionHeader(),
        const SizedBox(height: 48),

        // Grid/List of projects
        _buildResponsiveGrid(columnsCount),
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
              'My Projects',
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
          'A selection of mobile applications I have designed and developed recently.',
          style: GoogleFonts.outfit(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildResponsiveGrid(int columns) {
    if (columns == 3) {
      return Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ProjectCard(project: _projects[0])),
                const SizedBox(width: 24),
                Expanded(child: ProjectCard(project: _projects[1])),
                const SizedBox(width: 24),
                Expanded(child: ProjectCard(project: _projects[2])),
              ],
            ),
          ),
          const SizedBox(height: 24),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ProjectCard(project: _projects[3])),
                const SizedBox(width: 24),
                Expanded(child: ProjectCard(project: _projects[4])),
                const SizedBox(width: 24),
                const Expanded(
                  child: SizedBox(),
                ), // spacer to keep grid aligned
              ],
            ),
          ),
        ],
      );
    } else if (columns == 2) {
      return Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ProjectCard(project: _projects[0])),
                const SizedBox(width: 20),
                Expanded(child: ProjectCard(project: _projects[1])),
              ],
            ),
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ProjectCard(project: _projects[2])),
                const SizedBox(width: 20),
                Expanded(child: ProjectCard(project: _projects[3])),
              ],
            ),
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: ProjectCard(project: _projects[4])),
                const SizedBox(width: 20),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      );
    } else {
      // Mobile Single Column
      return Column(
        children: _projects
            .map(
              (project) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ProjectCard(project: project),
              ),
            )
            .toList(),
      );
    }
  }
}

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'flutter':
        return const Color(0xFF0ea5e9);
      case 'riverpod':
        return const Color(0xFF6366f1);
      case 'supabase':
        return const Color(0xFF3ECF8E);
      case 'bloc':
        return const Color(0xFF3b82f6);
      case 'hive':
        return const Color(0xFFFFB703);
      case 'gemini api':
        return const Color(0xFF8B5CF6);
      case 'groq api':
        return const Color(0xFFEC4899);
      case 'getx':
        return const Color(0xFFa855f7);
      case 'apis':
        return const Color(0xFF14b8a6);
      case 'firebase':
        return const Color(0xFFf59e0b);
      case 'stripe':
        return const Color(0xFF635bff);
      case 'google maps':
        return const Color(0xFF22c55e);
      case 'clean architecture':
        return const Color(0xFFf97316);
      default:
        return const Color(0xFF64748b);
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: project.link != null ? () => _launchUrl(project.link!) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(
            0.0,
            _isHovered ? -8.0 : 0.0,
            0.0,
          ),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F16),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? project.primaryColor.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? project.primaryColor.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.2),
                blurRadius: _isHovered ? 24 : 12,
                spreadRadius: _isHovered ? 1 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Main content Column (non-positioned child that defines Stack height)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top Header with Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: project.primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: project.primaryColor.withValues(alpha: 0.25),
                            width: 1,
                          ),
                        ),
                        child: FaIcon(
                          project.icon,
                          color: project.primaryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.title,
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              project.subtitle,
                              style: GoogleFonts.outfit(
                                color: project.primaryColor.withValues(
                                  alpha: 0.9,
                                ),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description bullets
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: project.bullets.map((bullet) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0, right: 10.0),
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: project.primaryColor.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                bullet,
                                style: GoogleFonts.outfit(
                                  color: Colors.white.withValues(alpha: 0.7),
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

                  // Reserved space for the footer positioned elements
                  SizedBox(height: project.link != null ? 110 : 65),
                ],
              ),

              // Footer elements (positioned at the bottom of the card)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tech chips wrap
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: project.tech.map((t) {
                        final tColor = _getTagColor(t);
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: tColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: tColor.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            t,
                            style: GoogleFonts.outfit(
                              color: tColor.withValues(alpha: 0.95),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    // Play Store link button if present
                    if (project.link != null) ...[
                      const SizedBox(height: 20),
                      Divider(
                        color: Colors.white.withValues(alpha: 0.06),
                        height: 1,
                      ),
                      const SizedBox(height: 12),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'View on Play Store',
                              style: GoogleFonts.outfit(
                                color: project.primaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            FaIcon(
                              FontAwesomeIcons.googlePlay,
                              color: project.primaryColor,
                              size: 13,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
