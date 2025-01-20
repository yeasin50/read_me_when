import 'package:flutter/material.dart';

import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/db/user_preference_repo.dart';
import '../../../infrastructure/enum/ayah_language.dart';

class LanguageUpdateView extends StatelessWidget {
  const LanguageUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserPreferenceState>(
      stream: context.userPreference.savedStream,
      builder: (context, snapshot) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${snapshot.data?.ayahLanguage.name}"),
            TranslationSelectionView(
              onChanged: (value) async {
                await context.userPreference.setLocal(value);
              },
              currentIndex: context.userPreference.state.ayahLanguage,
            ),
          ],
        );
      },
    );
  }
}

/// show  a popup to select-update the ayah in native language
class TranslationSelectionView extends StatelessWidget {
  const TranslationSelectionView({
    super.key,
    required this.onChanged,
    required this.currentIndex,
  });

  final AyahLanguage currentIndex;

  /// selected Language index
  final ValueChanged<AyahLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AyahLanguage>(
      icon: const Material(
        child: Icon(Icons.translate),
      ),
      onSelected: onChanged,
      initialValue: currentIndex,
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: AyahLanguage.bangla,
            child: Text("Bangla"),
          ),
          PopupMenuItem(
            value: AyahLanguage.english,
            child: Text("English"),
          ),
          PopupMenuItem(
            value: AyahLanguage.chines,
            child: Text("China"),
          ),
          // PopupMenuItem(
          //   child: Text("Hindi"),
          // ),
          // PopupMenuItem(
          //   child: Text("Urdhu"),
          // ),
        ];
      },
    );
  }
}
