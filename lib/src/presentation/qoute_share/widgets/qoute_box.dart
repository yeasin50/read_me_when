import 'package:flutter/material.dart';

import '../../../infrastructure/enum/ayah_language.dart';
import '../../../infrastructure/models/quranic_verse.dart';

class QuoteBox extends StatelessWidget {
  const QuoteBox({
    super.key,
    required this.verse,
    required this.lang,
  });

  final QuranicVerse verse;
  final AyahLanguage lang;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      constraints: const BoxConstraints(maxWidth: 650),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              verse.nativeAyah(lang),
              textAlign: TextAlign.center,
              style: textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              verse.ayatInArabic,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "--- \n ${verse.suraName}:${verse.ayatNo}",
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
