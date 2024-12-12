import 'package:flutter/material.dart';

import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/mood.dart';
import '../../infrastructure/models/quranic_verse.dart';
import 'widgets/app_bar.dart';
import 'widgets/ayah_in_native_view.dart';

class QuotePage extends StatefulWidget {
  const QuotePage({
    super.key,
    required this.mood,
  })  : verse = null,
        selectedVerseIndex = null;

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
    setState(() {});
  }

  void onPreviousBack() {
    selectedIndex--;
    if (selectedIndex < 0) selectedIndex = verses.length - 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.share_outlined),
      ),
      body: Hero(
        tag: widget.verse ?? widget.mood,
        child: AnimatedContainer(
          duration: Durations.medium1,
          width: double.infinity,
          color: verse.mood.scaffoldBackgroundColor,
          padding: MediaQuery.paddingOf(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              QuotePageAppBar(
                textTheme: textTheme,
                textColor: textColor,
                verse: verse,
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: AyahInNativeView(mood: verse.mood, verse: verse),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 64),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    onPressed: onPreviousBack,
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton.icon(
                    onPressed: nextVerse,
                    iconAlignment: IconAlignment.end,
                    label: const Text("Next verse"),
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
              const SizedBox(height: 72),
            ],
          ),
        ),
      ),
    );
  }
}
