// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/app/route_config.dart';

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
  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

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
      // backgroundColor: scaffoldBG,
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   onPressed: () {},
      //   child: const Icon(Icons.share_outlined),
      // ),
      floatingActionButton: SpeedDial(
        icon: Icons.share_outlined,
        activeIcon: Icons.close,
        spacing: 3,
        openCloseDial: isDialOpen,
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
              context.push(
                AppRoute.quoteShare,
                extra: {
                  "verse": verse,
                },
              );
            },
          ),
        ],
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
