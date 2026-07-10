import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final ValueChanged<int>? onTabTap;

  const FooterSection({super.key, this.onTabTap});

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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1000;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Premium top divider with gold center-glow
        Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.0),
                Colors.white.withValues(alpha: 0.08),
                const Color(0xFFFFB703).withValues(alpha: 0.3),
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.0),
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
          ),
        ),
        const SizedBox(height: 60),

        isDesktop ? _buildDesktopFooter(context) : _buildMobileFooter(context),
      ],
    );
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Column 1: Brand / Description / Socials
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFFB703), Color(0xFFFB8500)],
                ).createShader(bounds),
                child: Text(
                  'FAIZ MK',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Crafting premium, high-performance Android & iOS applications with seamless, beautiful user experiences.',
                style: GoogleFonts.outfit(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _FooterSocialIcon(
                    icon: FontAwesomeIcons.github,
                    url: 'https://github.com/FaizMK01',
                    onTap: _launchUrl,
                  ),
                  const SizedBox(width: 14),
                  _FooterSocialIcon(
                    icon: FontAwesomeIcons.linkedinIn,
                    url: 'https://www.linkedin.com/in/faiz-mk-0205a52ba/',
                    onTap: _launchUrl,
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(flex: 1),

        // Column 2: Navigation Links
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderTitle('QUICK LINKS'),
              const SizedBox(height: 20),
              _FooterNavLink(label: 'Home', onTap: () => onTabTap?.call(0)),
              _FooterNavLink(label: 'Skills', onTap: () => onTabTap?.call(1)),
              _FooterNavLink(label: 'Projects', onTap: () => onTabTap?.call(2)),
              _FooterNavLink(
                label: 'Experience',
                onTap: () => onTabTap?.call(3),
              ),
              _FooterNavLink(label: 'Contact', onTap: () => onTabTap?.call(4)),
            ],
          ),
        ),

        // Column 3: Specialties
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderTitle('SPECIALTIES'),
              const SizedBox(height: 20),
              _buildSpecialtyItem('Flutter Development'),
              _buildSpecialtyItem('Android & iOS Dev'),
              _buildSpecialtyItem('BLoC & State Mgmt'),
              _buildSpecialtyItem('Clean Architecture'),
              _buildSpecialtyItem('Firebase & Supabase'),
            ],
          ),
        ),

        // Column 4: Contact info
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderTitle('GET IN TOUCH'),
              const SizedBox(height: 20),
              _FooterContactItem(
                icon: Icons.email_outlined,
                label: 'faizmk340@gmail.com',
                url: 'mailto:faizmk340@gmail.com',
                onTap: _launchUrl,
              ),
              const SizedBox(height: 16),
              _FooterContactItem(
                icon: Icons.phone_outlined,
                label: '+92 318 5441753',
                url: 'tel:+923185441753',
                onTap: _launchUrl,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Brand logo
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFFFB703), Color(0xFFFB8500)],
          ).createShader(bounds),
          child: Text(
            'FAIZ MK',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Crafting professional mobile & web apps.',
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterSocialIcon(
              icon: FontAwesomeIcons.github,
              url: 'https://github.com/FaizMK01',
              onTap: _launchUrl,
            ),
            const SizedBox(width: 16),
            _FooterSocialIcon(
              icon: FontAwesomeIcons.linkedinIn,
              url: 'https://www.linkedin.com/in/faiz-mk-0205a52ba/',
              onTap: _launchUrl,
            ),
          ],
        ),
        const SizedBox(height: 40),
        _buildHeaderTitle('GET IN TOUCH', isCentered: true),
        const SizedBox(height: 16),
        _FooterContactItem(
          icon: Icons.email_outlined,
          label: 'faizmk340@gmail.com',
          url: 'mailto:faizmk340@gmail.com',
          isCentered: true,
          onTap: _launchUrl,
        ),
        const SizedBox(height: 16),
        _FooterContactItem(
          icon: Icons.phone_outlined,
          label: '+92 318 5441753',
          url: 'tel:+923185441753',
          isCentered: true,
          onTap: _launchUrl,
        ),
      ],
    );
  }

  Widget _buildHeaderTitle(String title, {bool isCentered = false}) {
    return Text(
      title,
      style: GoogleFonts.outfit(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildSpecialtyItem(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          color: Colors.white.withValues(alpha: 0.6),
          fontSize: 14,
        ),
      ),
    );
  }
}

class _FooterNavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterNavLink({required this.label, required this.onTap});

  @override
  State<_FooterNavLink> createState() => _FooterNavLinkState();
}

class _FooterNavLinkState extends State<_FooterNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: Matrix4.translationValues(_isHovered ? 4 : 0, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isHovered ? 1.0 : 0.0,
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFFFFB703),
                    size: 16,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(left: _isHovered ? 4 : 0),
                  child: Text(
                    widget.label,
                    style: GoogleFonts.outfit(
                      color: _isHovered
                          ? const Color(0xFFFFB703)
                          : Colors.white.withValues(alpha: 0.6),
                      fontSize: 14,
                      fontWeight: _isHovered
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Function(String) onTap;

  const _FooterSocialIcon({
    required this.icon,
    required this.url,
    required this.onTap,
  });

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.diagonal3Values(
            _isHovered ? 1.08 : 1.0,
            _isHovered ? 1.08 : 1.0,
            1.0,
          ),
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: _isHovered
                ? const Color(0xFFFFB703).withValues(alpha: 0.1)
                : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFFFFB703)
                  : Colors.white.withValues(alpha: 0.06),
              width: 1.2,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFFB703).withValues(alpha: 0.12),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          alignment: Alignment.center,
          child: FaIcon(
            widget.icon,
            color: _isHovered
                ? const Color(0xFFFFB703)
                : Colors.white.withValues(alpha: 0.7),
            size: 17,
          ),
        ),
      ),
    );
  }
}

class _FooterContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;
  final bool isCentered;
  final Function(String) onTap;

  const _FooterContactItem({
    required this.icon,
    required this.label,
    required this.url,
    this.isCentered = false,
    required this.onTap,
  });

  @override
  State<_FooterContactItem> createState() => _FooterContactItemState();
}

class _FooterContactItemState extends State<_FooterContactItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(widget.url),
        child: Row(
          mainAxisAlignment: widget.isCentered
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.diagonal3Values(
                _isHovered ? 1.15 : 1.0,
                _isHovered ? 1.15 : 1.0,
                1.0,
              ),
              child: Icon(
                widget.icon,
                color: _isHovered
                    ? const Color(0xFFFFB703)
                    : const Color(0xFFFFB703).withValues(alpha: 0.8),
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Text(
                widget.label,
                style: GoogleFonts.outfit(
                  color: _isHovered
                      ? const Color(0xFFFFB703)
                      : Colors.white.withValues(alpha: 0.8),
                  fontSize: 14,
                  fontWeight: widget.isCentered
                      ? FontWeight.normal
                      : FontWeight.w500,
                  decoration: _isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: const Color(0xFFFFB703),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
