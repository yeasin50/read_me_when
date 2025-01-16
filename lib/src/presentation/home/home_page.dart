import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'widget/background_view.dart';
import 'widget/mood_selection_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: HomeBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Read Me When',
                    style: textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
                      .slide(),
                  const SizedBox(height: 64),
                  const MoodSelectionView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
