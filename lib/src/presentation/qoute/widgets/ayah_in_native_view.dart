import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/enum/mood.dart';
import '../../../infrastructure/models/quranic_verse.dart';

class AyahInNativeView extends StatelessWidget {
  const AyahInNativeView({
    super.key,
    required this.verse,
    required this.mood,
    this.onAnimationEnd,
  });

  final QuranicVerse verse;
  final Mood mood;

  Color get textColor => mood.quoteTextColor;

  /// we gonna have pretty good animation  here.
  /// So, return  a callBack  when  the animation  is end
  final VoidCallback? onAnimationEnd;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final ayahLang = context.userPreference.state.ayahLanguage;

    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            child: Text(
              verse.ayatInArabic,
              style: textTheme.titleLarge?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(duration: 500.milliseconds, delay: 250.ms)
                .shimmer(
                  blendMode: BlendMode.exclusion,
                  color: const Color(0xFFFFD700),
                )
                .animate()
                .move(
                  begin: const Offset(16, 0),
                  curve: Curves.easeOutQuad,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            "${verse.suraName}(${verse.suraNo}:${verse.ayatNo})",
            style: textTheme.bodyMedium,
          )
              .animate(delay: .7.seconds) //
              .fadeIn(),
          const SizedBox(height: 24),
          RepaintBoundary(
            child: Text(
              verse.nativeAyah(ayahLang),
              style: textTheme.headlineLarge?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            )
                .animate(
                  delay: 1.seconds,
                  onComplete: (_) => onAnimationEnd?.call(),
                ) //
                .fadeIn(duration: 300.ms),
          ),
        ],
      ),
    );
  }
}
