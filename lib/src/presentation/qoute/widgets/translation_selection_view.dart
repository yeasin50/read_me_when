import 'package:flutter/material.dart';

import '../../../infrastructure/enum/ayah_langage.dart';

/// show  a popup to select-update the ayah in native language
class TranslationSelectionView extends StatelessWidget {
  const TranslationSelectionView({
    super.key,
    required this.onChanged,
    required this.currentIndex,
  });

  final AyahLanguage currentIndex;

  /// selected Language index
  final ValueChanged<AyahLanguage> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AyahLanguage>(
      icon: const Material(
        child: Icon(Icons.translate),
      ),
      onSelected: onChanged,
      initialValue: currentIndex,
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: AyahLanguage.bangla,
            child: Text("Bangla"),
          ),
          PopupMenuItem(
            value: AyahLanguage.english,
            child: Text("English"),
          ),
          PopupMenuItem(
            value: AyahLanguage.chines,
            child: Text("China"),
          ),
          // PopupMenuItem(
          //   child: Text("Hindi"),
          // ),
          // PopupMenuItem(
          //   child: Text("Urdhu"),
          // ),
        ];
      },
    );
  }
}
