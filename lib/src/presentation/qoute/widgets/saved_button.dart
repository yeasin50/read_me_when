import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../infrastructure/app_repo.dart';
import '../../../infrastructure/models/quranic_verse.dart';

class SavedButton extends StatefulWidget {
  const SavedButton({
    super.key,
    required this.verse,
  });
  final QuranicVerse? verse;

  @override
  State<SavedButton> createState() => _SavedButtonState();
}

class _SavedButtonState extends State<SavedButton> {
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
    return kIsWeb
        ? const SizedBox.shrink()
        : IconButton.outlined(
            onPressed: toggleSaved,
            icon: Icon(
              isSaved ? Icons.favorite : Icons.favorite_outline,
            ),
          ).animate(delay: 1.5.seconds).fadeIn();
  }
}
