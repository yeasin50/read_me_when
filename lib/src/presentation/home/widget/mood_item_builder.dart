import 'package:flutter/material.dart';

import 'package:read_me_when/src/infrastructure/enum/mood.dart';

class MoodItemBuilder extends StatelessWidget {
  const MoodItemBuilder({
    super.key,
    required this.mood,
    required this.onTap,
  });

  final Mood mood;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12.0),
      clipBehavior: Clip.hardEdge,
      color: mood.color,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            mood.icon,
            const SizedBox(height: 8.0),
            Text(
              mood.title,
              style: TextStyle(
                color: mood.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
