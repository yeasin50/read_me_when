import 'package:flutter/material.dart';

import '../../../infrastructure/enum/mood.dart';

class MoodItemBuilder extends StatefulWidget {
  const MoodItemBuilder({
    super.key,
    required this.mood,
    required this.onTap,
  });

  final Mood mood;
  final VoidCallback onTap;

  @override
  State<MoodItemBuilder> createState() => _MoodItemBuilderState();
}

class _MoodItemBuilderState extends State<MoodItemBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heartBitAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Durations.short4,
    );

    _heartBitAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 1.3),
        weight: 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.3, end: .8),
        weight: 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: .8, end: 1),
        weight: 1,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void onTap() {
    _controller.forward(from: 0).then(
      (value) {
        widget.onTap();
      },
    );
  }

  void onLongPress() {
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _heartBitAnimation,
      builder: (context, child) => Material(
        borderRadius: BorderRadius.circular(12.0),
        clipBehavior: Clip.hardEdge,
        color: widget.mood.color,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          child: Transform.scale(
            scale: _heartBitAnimation.value,
            child: child!,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.mood.icon,
          const SizedBox(height: 8.0),
          Text(
            widget.mood.title,
            style: TextStyle(
              color: widget.mood.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
