import 'package:flutter/material.dart';
import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/db/user_preference_repo.dart';

import '../../../infrastructure/models/quranic_verse.dart';

class QuotePageAppBar extends StatelessWidget {
  const QuotePageAppBar({
    super.key,
    required this.verse,
    required this.textTheme,
    required this.textColor,
  });

  final QuranicVerse? verse;

  final TextTheme textTheme;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        Expanded(
          child: Column(
            children: [
              Text(
                verse?.suraName ?? "...",
                style: textTheme.headlineLarge?.copyWith(color: textColor),
              ),
              Text(
                verse?.ayatNo ?? "...",
                style: textTheme.titleSmall?.copyWith(color: textColor),
              ),
            ],
          ),
        ),
        StreamBuilder<UserPreferenceState>(
            stream: context.userPreference.savedStream,
            builder: (context, snapshot) {
              bool isSaved = snapshot.data?.savedAyahIds.contains(verse?.id) ?? false;
              debugPrint("isSaved ${snapshot.data?.savedAyahIds}");
              return IconButton.outlined(
                onPressed: () async {
                  if (verse?.id == null) return;
                  isSaved
                      ? await context.userPreference.removeFavorite(verse!.id)
                      : await context.userPreference.saveFavorite(verse!.id);
                },
                icon: Icon(
                  isSaved ? Icons.favorite : Icons.favorite_outline,
                ),
              );
            }),
      ],
    );
  }
}
