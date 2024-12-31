import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/db/user_preference_repo.dart';
import '../../../infrastructure/enum/ayah_langage.dart';
import '../../../infrastructure/enum/mood.dart';
import '../../../infrastructure/models/quranic_verse.dart';
import 'translation_selection_view.dart';

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
    void onNativeChanged(AyahLanguage lang) async {
      await context.userPreference.setLocal(lang);
    }

    final textTheme = Theme.of(context).textTheme;

    return StreamBuilder<UserPreferenceState>(
      stream: context.userPreference.savedStream,
      builder: (context, snapshot) {
        var ayahLang = snapshot.data?.ayahLanguage;

        ayahLang ??= AyahLanguage.english;

        return IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                  child: Text(
                verse.nativeAyah(ayahLang),
                style: textTheme.headlineLarge?.copyWith(color: textColor),
                textAlign: TextAlign.center,
              )
                      .animate(delay: 200.ms, target: 0, value: 1) //
                      .blurXY(end: 16, duration: 300.ms)
                      .tint(color: const Color(0xFF80DDFF))),
              Align(
                alignment: Alignment.centerRight,
                child: TranslationSelectionView(
                  onChanged: onNativeChanged,
                  currentIndex: ayahLang,
                ),
              ),
              const SizedBox(height: 8),
              RepaintBoundary(
                child: Text(
                  verse.ayatInArabic,
                  style: textTheme.titleLarge?.copyWith(color: textColor),
                  textAlign: TextAlign.center,
                )
                    .animate(
                      delay: 500.ms,
                      onComplete: (_) => onAnimationEnd?.call(),
                    )
                    .fadeIn(duration: 600.ms, delay: 400.ms) //
                    .shimmer(
                      blendMode: BlendMode.exclusion,
                      color: verse.mood.color.withAlpha(150),
                    )
                    .animate()
                    .move(
                      begin: const Offset(16, 0),
                      curve: Curves.easeOutQuad,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
