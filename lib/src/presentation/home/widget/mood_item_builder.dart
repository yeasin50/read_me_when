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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: mood.color,
          borderRadius: BorderRadius.circular(12.0),
        ),
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
