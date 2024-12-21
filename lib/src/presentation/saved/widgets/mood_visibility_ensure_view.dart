import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:read_me_when/src/infrastructure/enum/mood.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

///  a widget that ensure visibility  of Mood widget that will scroll on specific position
///
class MoodVisibleControllerView extends StatelessWidget {
  const MoodVisibleControllerView({
    super.key,
    required this.controller,
    required this.groupData,
  });
  final ScrollController controller;
  final Map<Mood, List<QuranicVerse>> groupData;

  @override
  Widget build(BuildContext context) {
    void animateTo(groupData, Mood tappedMood) {
      double offset = 0;
      for (final entry in groupData.entries) {
        if (entry.key == tappedMood) break;
        offset += kToolbarHeight; //for headerAppBar
        offset += entry.value.length * (60.0 + 16);
      }
      controller.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(24),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 8),
            ...groupData.keys.map((e) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ActionChip(
                    label: Text(e.title),
                    onPressed: () {
                      animateTo(groupData, e);
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
