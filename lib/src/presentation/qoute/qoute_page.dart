import 'package:flutter/material.dart';

import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/mood.dart';
import '../../infrastructure/models/quranic_verse.dart';
import 'widgets/app_bar.dart';
import 'widgets/ayah_in_native_view.dart';

class QuotePage extends StatelessWidget {
  const QuotePage({
    super.key,
    required this.mood,
    this.verse,
    this.selectedVerseIndex,
  });

  final Mood mood;

  /// if from saved, theses wont be null
  final QuranicVerse? verse;
  final int? selectedVerseIndex;

  @override
  Widget build(BuildContext context) {
    final List<QuranicVerse> data = verse != null //
        ? context.verseRepo.state.savedItems.values.expand((e) => e).toList()
        : context.verseRepo.state.data[mood] ?? [];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.share_outlined),
      ),
      body: Hero(
          tag: verse ?? mood,
          child: MoodSessionView(
            verses: data,
            selectedIndex: selectedVerseIndex ?? 0,
          )),
    );
  }
}

///
class MoodSessionView extends StatefulWidget {
  const MoodSessionView({
    super.key,
    required this.verses,
    required this.selectedIndex,
  });

  final List<QuranicVerse> verses;
  final int selectedIndex;

  @override
  State<MoodSessionView> createState() => _MoodSessionViewState();
}

class _MoodSessionViewState extends State<MoodSessionView> {
  late int selectedIndex = widget.selectedIndex;

  String get moodName => widget.verses[selectedIndex].mood.name;
  Color get textColor => widget.verses[selectedIndex].mood.quoteTextColor;

  QuranicVerse get verse => widget.verses[selectedIndex];

  void nextVerse() {
    selectedIndex++;
    if (selectedIndex >= widget.verses.length) selectedIndex = 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      duration: Durations.medium1,
      color: verse.mood.scaffoldBackgroundColor,
      padding: MediaQuery.paddingOf(context),
      child: Column(
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
          SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: nextVerse,
              iconAlignment: IconAlignment.end,
              child: const Text("Next Verse"),
            ),
          ),
          const SizedBox(height: 72),
        ],
      ),
    );
  }
}
