import 'package:flutter/material.dart';
import '../../application/mood_session.dart';
import '../../infrastructure/app_repo.dart';
import '../../infrastructure/models/quranic_verse.dart';
import 'widgets/app_bar.dart';
import 'widgets/ayah_in_native_view.dart';

import '../../infrastructure/enum/mood.dart';

class QuotePage extends StatefulWidget {
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
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String get moodName => widget.mood.name;
  Color get textColor => widget.mood.quoteTextColor;
  Color get scaffoldBG => widget.mood.scaffoldBackgroundColor;

  MoodSession? session;
  void nextVerse() async {
    session?.nextVerse();
  }

  bool get fromSaved => widget.verse != null && widget.selectedVerseIndex != null;

  @override
  void initState() {
    super.initState();
    MoodSession.createSession(
      mood: widget.mood,
      verses: fromSaved //
          ? verseRepo.getFromIds(userPreference.state.savedAyahIds)
          : verseRepo.data[widget.mood] ?? [],
      selectedIndex: widget.selectedVerseIndex,
    ).then((value) => setState(
          () {
            session = value;
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: scaffoldBG,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.share_outlined),
      ),
      body: Hero(
        tag: widget.mood,
        child: SafeArea(
          child: session == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : StreamBuilder<QuranicVerse>(
                  stream: session!.stream,
                  builder: (context, snapshot) {
                    QuranicVerse? verse = snapshot.data;
                    return Column(
                      children: [
                        QuotePageAppBar(
                          textTheme: textTheme,
                          textColor: textColor,
                          verse: verse,
                        ),
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              if (verse == null) {
                                return const Center(child: CircularProgressIndicator());
                              }
                              return Center(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(24),
                                  child: AyahInNativeView(
                                    mood: widget.mood,
                                    verse: verse,
                                  ),
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
                    );
                  }),
        ),
      ),
    );
  }
}
