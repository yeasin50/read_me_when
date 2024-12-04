import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//FIXME:  Not working
class AnimatedShellNavigator extends StatefulWidget {
  final StatefulNavigationShell shell;

  const AnimatedShellNavigator({
    super.key,
    required this.shell,
  });

  @override
  State<AnimatedShellNavigator> createState() => _AnimatedShellNavigatorState();
}

class _AnimatedShellNavigatorState extends State<AnimatedShellNavigator> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.shell.currentIndex;
  }

  @override
  void didUpdateWidget(covariant AnimatedShellNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shell.currentIndex != _currentIndex) {
      setState(() {
        _currentIndex = widget.shell.currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.shell.currentIndex == _currentIndex ? 1.0 : 0.0,
      duration: const Duration(seconds: 2),
      child: AnimatedScale(
        duration: const Duration(seconds: 2),
        scale: widget.shell.currentIndex == _currentIndex ? 1.0 : 0.0,
        child: widget.shell,
      ),
    );
  }
}
