import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsRotator extends StatefulWidget {
  final List<String> skills;
  final Duration interval;
  final TextStyle? textStyle;

  const SkillsRotator({
    super.key,
    this.skills = const [
      'Mobile App Developer',
      'Flutter Developer',
      'Android & iOS',
    ],
    this.interval = const Duration(milliseconds: 2500),
    this.textStyle,
  });

  @override
  State<SkillsRotator> createState() => _SkillsRotatorState();
}

class _SkillsRotatorState extends State<SkillsRotator> {
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(widget.interval, (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.skills.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = widget.textStyle ??
        GoogleFonts.outfit(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.amber,
        );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Is this the child entering?
        final isEntering = child.key == ValueKey<int>(_currentIndex);
        
        final slideTween = isEntering
            ? Tween<Offset>(begin: const Offset(0.0, 0.4), end: Offset.zero)
            : Tween<Offset>(begin: const Offset(0.0, -0.4), end: Offset.zero);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideTween.animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        widget.skills[_currentIndex],
        key: ValueKey<int>(_currentIndex),
        style: themeStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}
