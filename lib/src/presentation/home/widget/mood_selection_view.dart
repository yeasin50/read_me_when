import 'package:flutter/material.dart';
import 'package:read_me_when/src/presentation/home/widget/mood_item_builder.dart';

import '../../../infrastructure/enum/mood.dart';

class MoodSelectionView extends StatelessWidget {
  const MoodSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          'Select Your Mood',
          style: textTheme.titleLarge,
        ),
        //toDO: pageView
        Expanded(
          child: RotatedBox(
            quarterTurns: 3,
            child: ListWheelScrollView(
              itemExtent: 120,
              children: Mood.values
                  .map((e) => RotatedBox(
                        quarterTurns: 1,
                        child: MoodItemBuilder(
                          mood: e,
                          onTap: () {},
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
        // Expanded(
        //   child: GridView.builder(
        //     padding: const EdgeInsets.all(16.0),
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 3,
        //       mainAxisSpacing: 16.0,
        //       crossAxisSpacing: 16.0,
        //     ),
        //     itemCount: Mood.values.length,
        //     itemBuilder: (context, index) {
        //       final mood = Mood.values[index];
        //       return MoodItemBuilder(
        //         mood: mood,
        //         onTap: () {},
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
