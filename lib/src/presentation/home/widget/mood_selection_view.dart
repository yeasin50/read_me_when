import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/infrastructure/app_repo.dart';

import '../../../infrastructure/enum/mood.dart';
import '../../_common/max_width_constraints.dart';
import 'mood_item_builder.dart';

/// show the [Mood] selection view to navigate to
///
class MoodSelectionView extends StatelessWidget {
  const MoodSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxWidthConstraints(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: Mood.values
                .map(
                  (e) => SizedBox.square(
                    dimension: 150,
                    child: Hero(
                      tag: e,
                      child: MoodItemBuilder(
                        mood: e,
                        onTap: () {
                          final verse =
                              context.verseRepo.state.getMoodInitialVerse(e);
                          final lang =
                              context.userPreference.state.ayahLanguage.code;
                          context.go("/?lang-$lang&id=${verse.id}");
                        },
                      ),
                    ),
                  ),
                )
                .toList()
                .animate(interval: 100.ms)
                .scale(delay: 50.ms),
          ),
        ],
      ),
    );
  }
}
