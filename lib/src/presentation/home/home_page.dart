import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/ayah_language.dart';
import '../_common/max_width_constraints.dart';
import '../qoute/widgets/translation_selection_view.dart';
import 'widget/background_view.dart';
import 'widget/mood_selection_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onNativeChanged(AyahLanguage lang) async {
    await context.userPreference.setLocal(lang);
  }

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
                  const MaxWidthConstraints(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: LanguageUpdateView(),
                    ),
                  ),
                  const SizedBox(height: 48),
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
