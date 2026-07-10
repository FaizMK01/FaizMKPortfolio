import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingChip extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color glowColor;
  final Duration floatDuration;
  final VoidCallback? onTap;
  final ValueChanged<bool>? onHoverChanged;

  const FloatingChip({
    super.key,
    required this.label,
    required this.icon,
    required this.glowColor,
    this.floatDuration = const Duration(milliseconds: 2500),
    this.onTap,
    this.onHoverChanged,
  });

  @override
  State<FloatingChip> createState() => _FloatingChipState();
}

class _FloatingChipState extends State<FloatingChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: widget.floatDuration,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() => _isHovered = true);
          widget.onHoverChanged?.call(true);
        },
        onExit: (_) {
          setState(() => _isHovered = false);
          widget.onHoverChanged?.call(false);
        },
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: _isHovered
                  ? widget.glowColor.withValues(alpha: .15)
                  : Colors.black.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered
                    ? widget.glowColor
                    : widget.glowColor.withValues(alpha: .3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.glowColor.withValues(alpha: .4)
                      : widget.glowColor.withValues(alpha: .1),
                  blurRadius: _isHovered ? 16 : 8,
                  spreadRadius: _isHovered ? 2 : 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  color: _isHovered ? Colors.white : widget.glowColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  widget.label,
                  style: GoogleFonts.outfit(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
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
