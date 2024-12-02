import 'package:flutter/material.dart';

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

  //todo: get device language/local from DateTime
  int currentNativeIndex = 1;
  void onNativeChanged(int index) {
    currentNativeIndex = index;
    setState(() {});
  }

  String get nativeAyat => switch (currentNativeIndex) {
        0 => verse.banglaTranslation,
        1 => verse.englishTranslation,
        2 => verse.chineseTranslation,
        _ => () {
            assert(false, "Missing language ");
            return "";
          }()
      };

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
                currentIndex: currentNativeIndex,
              )
              // IconButton(
              //   onPressed: onNativeChanged,
              //   icon: const Icon(Icons.g_translate),
              // ),
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
