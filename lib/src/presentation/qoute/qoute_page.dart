// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../application/mood_session.dart';
import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/mood.dart';
import '../../infrastructure/models/quranic_verse.dart';
import '../qoute_share/generate_image.dart';
import 'widgets/app_bar.dart';
import 'widgets/ayah_in_native_view.dart';

class QuotePage extends StatefulWidget {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  QuotePage({
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
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   onPressed: () {},
      //   child: const Icon(Icons.share_outlined),
      // ),
      floatingActionButton: SpeedDial(
        icon: Icons.share_outlined,
        activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: widget.isDialOpen,
        childPadding: const EdgeInsets.all(4),
        spaceBetweenChildren: 3,
        buttonSize: const Size.fromRadius(30),
        visible: true,
        direction: SpeedDialDirection.up,
        animationDuration: const Duration(milliseconds: 500),
        switchLabelPosition: false,
        closeManually: false,
        // onOpen: () {
        //   widget.isDialOpen.value = true;
        // },
        useRotationAnimation: true,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.copy_all_outlined),
            label: 'Copy Quote',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              // debugPrint('Copy Quote');
              Clipboard.setData(const ClipboardData(text: 'Copied Text'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to Clipboard'),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.link_outlined),
            label: 'Copy Link',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              // debugPrint('Copy Link');
              Clipboard.setData(const ClipboardData(text: 'Copied Link'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to Clipboard'),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.image_outlined),
            label: 'Generate Image',
            labelStyle: const TextStyle(fontSize: 18.0),
            onTap: () {
              // debugPrint('Generate Image');
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const GenerateImageToShare()));  
            },
          ),
        ],
      ),
      body: session == null
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
    );
  }
}
