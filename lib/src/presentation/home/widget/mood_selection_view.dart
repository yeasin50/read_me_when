import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/route_config.dart';
import '../../../infrastructure/enum/mood.dart';
import 'mood_item_builder.dart';

/// show the [Mood] selection view to navigate to
///
class MoodSelectionView extends StatelessWidget {
  const MoodSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Select Your Mood',
          style: textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: Mood.values
              .map(
                (e) => SizedBox.square(
                  dimension: 200,
                  child: MoodItemBuilder(
                    mood: e,
                    onTap: () {
                      context.push(
                        AppRoute.quote,
                        extra: {"mood_name": e.name},
                      );
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
