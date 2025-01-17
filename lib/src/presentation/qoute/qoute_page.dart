import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/route_config.dart';
import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/mood.dart';
import '../../infrastructure/models/quranic_verse.dart';
import '../_common/max_width_constraints.dart';
import 'widgets/ayah_change_button.dart';
import 'widgets/ayah_in_native_view.dart';
import 'widgets/saved_button.dart';
import 'widgets/share_button.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({
    super.key,
    required this.mood,
  })  : verse = null,
        selectedVerseIndex = null;

  @Deprecated("This has been removed for web release v1")
  const QuotePage.fromSaved({
    super.key,
    required this.mood,
    required this.verse,
    required this.selectedVerseIndex,
  }) : assert(selectedVerseIndex != null, "selectedVerseIndex can't be null");

  final Mood mood;

  /// if from saved, theses wont be null
  final QuranicVerse? verse;
  final int? selectedVerseIndex;

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  late int selectedIndex = widget.selectedVerseIndex ?? 0;

  late List<QuranicVerse> verses = //
      widget.selectedVerseIndex == null //
          ? verseRepo.state.getMoodForVerse(widget.mood)
          : verseRepo.state.getSavedItems;

  String get moodName => verses[selectedIndex].mood.name;
  Color get textColor => verses[selectedIndex].mood.quoteTextColor;

  QuranicVerse get verse => verses[selectedIndex];

  void nextVerse() {
    selectedIndex++;
    if (selectedIndex >= verses.length) selectedIndex = 0;
    controller.animateToPage(
      selectedIndex,
      duration: Durations.medium1,
      curve: Curves.easeIn,
    );
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
    return Scaffold(
      floatingActionButton: ShareButton(
        verse: verse,
        onChange: (value) {
          isSharedSectionOpen = value;
          setState(() {});
        },
      ),
      backgroundColor: verse.mood.scaffoldBackgroundColor,
      body: Hero(
        tag: widget.verse ?? widget.mood,
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
                                      setState(
                                          () => isAyahAnimationDone = true);
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
                                onPressed:
                                    selectedIndex == 0 ? null : onPreviousBack,
                                label: selectedIndex == 0
                                    ? SizedBox.fromSize()
                                    : const Text("Previous"),
                              ),
                              AyahChangeButton(
                                onNext: nextVerse,
                                onPrevious: onPreviousBack,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text("Share"),
                              )
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
    );
  }
}
