import 'package:flutter/material.dart';

import '../../../infrastructure/app_repo.dart';
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

class _AyahInNativeViewState extends State<AyahInNativeView> {
  Color get textColor => widget.mood.quoteTextColor;

  QuranicVerse get verse => widget.verse;

  late AyahLanguage nativeLang = userPreference.ayahNativeLang;
  void onNativeChanged(AyahLanguage lang) {
    nativeLang = lang;
    userPreference.setLocal(lang);
    setState(() {});
  }

  String get nativeAyat => verse.nativeAyah(nativeLang);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            nativeAyat,
            style: textTheme.headlineLarge?.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TranslationSelectionView(
              onChanged: onNativeChanged,
              currentIndex: nativeLang,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.verse.ayatInArabic,
            style: textTheme.titleLarge?.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
