import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillCategory {
  final String title;
  final IconData icon;
  final List<String> skills;
  final Color color;

  const SkillCategory({
    required this.title,
    required this.icon,
    required this.skills,
    required this.color,
  });
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static final List<SkillCategory> _categories = [
    const SkillCategory(
      title: 'Languages & Frameworks',
      icon: Icons.code_rounded,
      color: Color(0xFF0ea5e9), // Cyan
      skills: ['Dart (OOP)', 'Flutter'],
    ),
    const SkillCategory(
      title: 'Firebase & Supabase',
      icon: FontAwesomeIcons.fire,
      color: Color(0xFFFFB703), // Amber
      skills: [
        'Authentication',
        'Cloud Firestore',
        'Cloud Storage',
        'Cloud Messaging',
        'Cloud Functions'
      ],
    ),
    const SkillCategory(
      title: 'State Management',
      icon: FontAwesomeIcons.bolt,
      color: Color(0xFF8B5CF6), // Purple
      skills: ['Provider', 'GetX', 'BLoC', 'Cubit'],
    ),
    const SkillCategory(
      title: 'Architecture & Testing',
      icon: FontAwesomeIcons.layerGroup,
      color: Color(0xFFf97316), // Orange
      skills: ['MVVM', 'MVC', 'Clean Architecture', 'Unit Testing', 'Widget Testing'],
    ),
    const SkillCategory(
      title: 'REST APIs & Storage',
      icon: FontAwesomeIcons.database,
      color: Color(0xFF3ECF8E), // Supabase Green
      skills: ['Dio', 'HTTP', 'SharedPreferences', 'Hive'],
    ),
    const SkillCategory(
      title: 'Tools & Deployment',
      icon: FontAwesomeIcons.screwdriverWrench,
      color: Color(0xFF3b82f6), // Blue
      skills: [
        'Google Play Store',
        'VS Code',
        'Xcode',
        'Postman',
        'Figma',
        'Git & GitHub'
      ],
    ),
    const SkillCategory(
      title: 'Other Technologies',
      icon: Icons.extension_rounded,
      color: Color(0xFFEC4899), // Pink
      skills: [
        'Stripe Integration',
        'AI Integration',
        'Google Maps',
        'Implicit & Explicit Animations'
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    int columnsCount = 1;
    if (width >= 1050) {
      columnsCount = 3;
    } else if (width >= 700) {
      columnsCount = 2;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        const SizedBox(height: 48),
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
              'Core Expertise & Skills',
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
          'Detailed technical skills, programming languages, backend platforms, and engineering methodologies.',
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[0], index: 0, minHeight: 230)),
              const SizedBox(width: 24),
              Expanded(child: SkillCategoryCard(category: _categories[1], index: 1, minHeight: 230)),
              const SizedBox(width: 24),
              Expanded(child: SkillCategoryCard(category: _categories[2], index: 2, minHeight: 230)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[3], index: 3, minHeight: 230)),
              const SizedBox(width: 24),
              Expanded(child: SkillCategoryCard(category: _categories[4], index: 4, minHeight: 230)),
              const SizedBox(width: 24),
              Expanded(child: SkillCategoryCard(category: _categories[5], index: 5, minHeight: 230)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[6], index: 6, minHeight: 230)),
              const SizedBox(width: 24),
              const Expanded(child: SizedBox()),
              const SizedBox(width: 24),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      );
    } else if (columns == 2) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[0], index: 0, minHeight: 230)),
              const SizedBox(width: 20),
              Expanded(child: SkillCategoryCard(category: _categories[1], index: 1, minHeight: 230)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[2], index: 2, minHeight: 230)),
              const SizedBox(width: 20),
              Expanded(child: SkillCategoryCard(category: _categories[3], index: 3, minHeight: 230)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[4], index: 4, minHeight: 230)),
              const SizedBox(width: 20),
              Expanded(child: SkillCategoryCard(category: _categories[5], index: 5, minHeight: 230)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: SkillCategoryCard(category: _categories[6], index: 6, minHeight: 230)),
              const SizedBox(width: 20),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      );
    } else {
      // Mobile Single Column
      return Column(
        children: List.generate(_categories.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SkillCategoryCard(category: _categories[index], index: index),
          );
        }),
      );
    }
  }
}

class SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;
  final int index;
  final double? minHeight;

  const SkillCategoryCard({
    super.key,
    required this.category,
    required this.index,
    this.minHeight,
  });

  @override
  State<SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<SkillCategoryCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    // Offset phase durations so cards float out of sync
    final durationMs = 2200 + (widget.index * 250);
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: durationMs),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = widget.category;

    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        // If hovered, lock to a stable lift position, else float gently
        final translationY = _isHovered ? -8.0 : _floatAnimation.value;
        return Transform.translate(
          offset: Offset(0, translationY),
          child: child,
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(24),
          constraints: BoxConstraints(
            minHeight: widget.minHeight ?? 0,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F16),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered
                  ? category.color.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? category.color.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.15),
                blurRadius: _isHovered ? 20 : 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Header: Icon & Category Name
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FaIcon(
                      category.icon,
                      color: category.color,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      category.title,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Skills chips wrap
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: category.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: category.color.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: category.color.withValues(alpha: 0.18),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      skill,
                      style: GoogleFonts.outfit(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
