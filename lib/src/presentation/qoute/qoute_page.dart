import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/app/read_me_when_app.dart';
import 'package:read_me_when/src/infrastructure/app_repo.dart';

import '../../app/route_config.dart';
import '../../infrastructure/models/quranic_verse.dart';
import '../_common/background_view.dart';
import '../_common/max_width_constraints.dart';
import 'widgets/ayah_change_button.dart';
import 'widgets/ayah_in_native_view.dart';
import 'widgets/saved_button.dart';
import 'widgets/share_button_v2.dart';

///  show a quranic verse for a specific mood
///
class VersePage extends StatefulWidget {
  const VersePage({
    super.key,
    required this.verses,
    this.selectedIndex = 0,
  });

  final int selectedIndex;
  final List<QuranicVerse> verses;

  @override
  State<VersePage> createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  late int selectedIndex = widget.selectedIndex;

  late List<QuranicVerse> verses = widget.verses;
  String get moodName => verses[selectedIndex].mood.name;
  QuranicVerse get verse => verses[selectedIndex];

  void updatePath() {
    final lang = context.userPreference.state.ayahLanguage.code;
    context.go("/?lang=$lang&id=${verse.id}");
  }

  void nextVerse() {
    selectedIndex++;
    if (selectedIndex >= verses.length) selectedIndex = 0;
    controller.animateToPage(
      selectedIndex,
      duration: Durations.medium1,
      curve: Curves.easeIn,
    );
    updatePath();
    setState(() {});
  }

  void onPreviousBack() {
    selectedIndex--;
    if (selectedIndex < 0) selectedIndex = verses.length - 1;
    controller.animateToPage(
      selectedIndex,
      duration: Durations.medium1,
      curve: Curves.easeOut,
    );
    updatePath();
    setState(() {});
  }

  ///  the  [AyahInNativeView] have some cool animation
  ///
  bool isAyahAnimationDone = false;
  bool isSharedSectionOpen = false;

  bool get showNextButton => !isSharedSectionOpen && isAyahAnimationDone;

  final PageController controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Hero(
          tag: moodName,
          child: AnimatedContainer(
            duration: Durations.medium1,
            width: double.infinity,
            padding: MediaQuery.paddingOf(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(
                    onPressed: () {
                      context.canPop()
                          ? context.pop()
                          : context.go(AppRoute.home);
                    },
                  ),
                ),
                Expanded(
                    child: Center(
                  child: MaxWidthConstraints(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: PageView.builder(
                              pageSnapping: true,
                              controller: controller,
                              itemCount: verses.length,
                              itemBuilder: (context, index) => Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SavedButton(verse: verse),
                                    ),
                                    const SizedBox(height: 72),
                                    AyahInNativeView(
                                      mood: verses[index].mood,
                                      verse: verses[index],
                                      onAnimationEnd: () {
                                        isAyahAnimationDone = true;
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 72),
                          Visibility.maintain(
                            visible: showNextButton,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton.icon(
                                  onPressed: selectedIndex == 0
                                      ? null
                                      : onPreviousBack,
                                  label: selectedIndex == 0
                                      ? SizedBox.fromSize()
                                      : const Text("Previous"),
                                ),
                                AyahChangeButton(
                                  onNext: nextVerse,
                                  onPrevious: onPreviousBack,
                                ),
                                ShareButtonV2(
                                  verse: verse,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 72),
                        ],
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
