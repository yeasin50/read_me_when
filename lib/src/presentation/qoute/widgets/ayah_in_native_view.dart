import 'package:flutter/material.dart';
import 'package:read_me_when/src/infrastructure/enum/mood.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

class AyahInNativeView extends StatefulWidget {
  const AyahInNativeView({super.key, required this.verse, required this.mood});

  final QuranicVerse verse;
  final Mood mood;

  @override
  State<AyahInNativeView> createState() => _AyahInNativeViewState();
}

class _AyahInNativeViewState extends State<AyahInNativeView> {
  Color get textColor => widget.mood.quoteTextColor;

  String get nativeAyat => widget.verse.banglaTranslation;

  void onNativeChanged() {}

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
            child: IconButton(
              onPressed: onNativeChanged,
              icon: const Icon(Icons.g_translate),
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
