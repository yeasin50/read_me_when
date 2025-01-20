import 'package:flutter/material.dart';

class BackgroundView extends StatefulWidget {
  const BackgroundView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<BackgroundView> createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    _colorAnimation1 = ColorTween(
      begin: const Color(0xFFB2DFDB),
      end: const Color(0xFFF3E5F5),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation2 = ColorTween(
      begin: const Color(0xFFBBDEFB),
      end: const Color(0xFFFFFDE7),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _colorAnimation1.value ?? Colors.transparent,
                _colorAnimation2.value ?? Colors.transparent,
              ],
            ),
          ),
          child: child,
        );
      },
    );
  }
}
