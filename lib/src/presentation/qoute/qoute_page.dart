import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';
import 'package:read_me_when/src/presentation/qoute/widgets/ayah_in_native_view.dart';

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

  String get surahName => "${verse.suraName}(${verse.suraNo})";
  String get ayat => "Ayah-${verse.ayatNo}";

  //todo: load ayah based on mood
  QuranicVerse verse = QuranicVerse.ui;

  void nextVerse() async {}

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
      body: Column(
        children: [
          Row(
            children: [
              const BackButton(),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      surahName,
                      style: textTheme.headlineLarge?.copyWith(color: textColor),
                    ),
                    Text(
                      ayat,
                      style: textTheme.titleSmall?.copyWith(color: textColor),
                    ),
                  ],
                ),
              ),
              IconButton.outlined(
                onPressed: () {},
                icon: Icon(
                  isSaved ? Icons.favorite : Icons.favorite_outline,
                ),
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AyahInNativeView(
                          mood: widget.mood,
                          verse: verse,
                        ),
                        const SizedBox(height: 64),
                        SizedBox(
                          width: 250,
                          child: OutlinedButton(
                            onPressed: nextVerse,
                            // icon: Icon(Icons.arrow_forward_ios),
                            child: Text("Next Verse"),
                            iconAlignment: IconAlignment.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
