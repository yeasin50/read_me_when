import 'package:flutter/material.dart';
import 'package:read_me_when/src/infrastructure/app_repo.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

class QuoteBox extends StatelessWidget {
  const QuoteBox({super.key, required this.verse});

  final QuranicVerse verse;

  @override
  Widget build(BuildContext context) {
    final lang = context.userPreference.state.ayahLanguage;

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
            Text(
              verse.ayatInArabic,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
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
