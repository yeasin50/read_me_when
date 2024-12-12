import 'package:flutter/material.dart';
import '../../../infrastructure/app_repo.dart';

import '../../../infrastructure/models/quranic_verse.dart';

class QuotePageAppBar extends StatefulWidget {
  const QuotePageAppBar({
    super.key,
    required this.verse,
    required this.textTheme,
    required this.textColor,
  });

  final QuranicVerse? verse;

  final TextTheme textTheme;
  final Color textColor;

  @override
  State<QuotePageAppBar> createState() => _QuotePageAppBarState();
}

class _QuotePageAppBarState extends State<QuotePageAppBar> {
  late bool isSaved = widget.verse?.isFavorite ?? false;

  void toggleSaved() async {
    isSaved = !isSaved;
    setState(() {});
    isSaved
        ? await context.verseRepo.addFavorite(widget.verse!)
        : await context.verseRepo.removeFavorite(widget.verse!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        Expanded(
          child: Column(
            children: [
              Text(
                widget.verse?.suraName ?? "...",
                style: widget.textTheme.headlineLarge?.copyWith(color: widget.textColor),
              ),
              Text(
                widget.verse?.ayatNo ?? "...",
                style: widget.textTheme.titleSmall?.copyWith(color: widget.textColor),
              ),
            ],
          ),
        ),
        IconButton.outlined(
          onPressed: toggleSaved,
          icon: Icon(
            isSaved ? Icons.favorite : Icons.favorite_outline,
          ),
        ),
      ],
    );
  }
}
