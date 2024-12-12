import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/db/user_preference_repo.dart';
import '../../../infrastructure/enum/ayah_langage.dart';
import '../../../infrastructure/enum/mood.dart';
import '../../../infrastructure/models/quranic_verse.dart';
import 'translation_selection_view.dart';

class AyahInNativeView extends StatefulWidget {
  const AyahInNativeView({super.key, required this.verse, required this.mood});

  final QuranicVerse verse;
  final Mood mood;

  @override
  State<AyahInNativeView> createState() => _AyahInNativeViewState();
}

class _AyahInNativeViewState extends State<AyahInNativeView> with SingleTickerProviderStateMixin {
  Color get textColor => widget.mood.quoteTextColor;

  QuranicVerse get verse => widget.verse;

  late StreamSubscription<UserPreferenceState> nativeLangAyahSubs;
  AyahLanguage nativeLang = AyahLanguage.bangla;

  void onNativeChanged(AyahLanguage lang) async {
    nativeLang = lang;
    await userPreference.setLocal(lang);
    setState(() {});
  }

  String get nativeAyat => verse.nativeAyah(nativeLang);

  @override
  void initState() {
    super.initState();

    nativeLangAyahSubs = userPreference.savedStream.listen(
      (event) {
        nativeLang = event.ayahLanguage;
      },
    );
  }

  @override
  void dispose() {
    nativeLangAyahSubs.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            child: Text(
              nativeAyat,
              style: textTheme.headlineLarge?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            )
                .animate(delay: 200.ms, target: 0, value: 1) //
                .blurXY(end: 16, duration: 300.ms)
                .tint(color: const Color(0xFF80DDFF)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TranslationSelectionView(
              onChanged: onNativeChanged,
              currentIndex: nativeLang,
            ),
          ),
          const SizedBox(height: 8),
          RepaintBoundary(
              child: Text(
            widget.verse.ayatInArabic,
            style: textTheme.titleLarge?.copyWith(color: textColor),
            textAlign: TextAlign.center,
          )
                  .animate(delay: 500.ms)
                  .fadeIn(duration: 600.ms, delay: 400.ms) //
                  .shimmer(blendMode: BlendMode.exclusion, color: verse.mood.color.withAlpha(150))
                  .move(begin: const Offset(16, 0), curve: Curves.easeOutQuad)),
        ],
      ),
    );
  }
}
