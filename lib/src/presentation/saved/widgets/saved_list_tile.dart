import 'package:flutter/material.dart';
import 'package:read_me_when/src/infrastructure/db/user_preference_repo.dart';

import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/enum/mood.dart';
import '../../../infrastructure/models/quranic_verse.dart';

class SavedListTile extends StatelessWidget {
  const SavedListTile({
    super.key,
    required this.verse,
    this.onTap,
  });

  final QuranicVerse verse;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserPreferenceState>(
        stream: context.userPreference.savedStream,
        initialData: UserPreferenceState.none,
        builder: (context, snapshot) {
          final ayahLang = snapshot.requireData.ayahLanguage;

          return Hero(
            tag: verse,
            child: Card(
              child: ListTile(
                tileColor: verse.mood.scaffoldBackgroundColor,
                title: Text(
                  verse.nativeAyah(ayahLang),
                  style: TextStyle(color: verse.mood.quoteTextColor),
                ),
                onTap: onTap,
              ),
            ),
          );
        });
  }
}
