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
  });

  final Mood mood;

  static MaterialPageRoute route({required Mood mood}) {
    return MaterialPageRoute(
      builder: (context) => QuotePage(mood: mood),
    );
  }

  @override
  State<QuotePage> createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  String get moodName => widget.mood.name;
  Color get textColor => widget.mood.quoteTextColor;
  Color get scaffoldBG => widget.mood.scaffoldBackgroundColor;

  bool isSaved = false;

  MoodSession? session;
  void nextVerse() async {
    session?.nextVerse();
  }

  @override
  void initState() {
    super.initState();
    MoodSession.createSession(
      mood: widget.mood,
      verses: verseRepo.data[widget.mood] ?? [],
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
      body: session == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuranicVerse>(
              stream: session!.stream,
              builder: (context, snapshot) {
                QuranicVerse? verse = snapshot.data;
                String surahName = "${verse?.suraName ?? ""}(${verse?.suraNo ?? ""})";
                String ayah = "Ayah-${verse?.ayatNo ?? ""}";
                return Column(
                  children: [
                    QuotePageAppBar(
                      surahName: surahName,
                      textTheme: textTheme,
                      textColor: textColor,
                      ayah: ayah,
                      isSaved: isSaved,
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
    );
  }
}
