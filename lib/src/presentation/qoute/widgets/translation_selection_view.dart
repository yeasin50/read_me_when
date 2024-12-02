import 'package:flutter/material.dart';

/// show  a popup to select-update the ayah in native language
class TranslationSelectionView extends StatelessWidget {
  const TranslationSelectionView({
    super.key,
    required this.onChanged,
    required this.currentIndex,
  });

  final int currentIndex;

  /// selected Language index
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Material(
        child: Icon(Icons.translate),
      ),
      onSelected: onChanged,
      initialValue: currentIndex,
      itemBuilder: (context) {
        return const [
          PopupMenuItem(
            value: 0,
            child: Text("Bangla"),
          ),
          PopupMenuItem(
            value: 1,
            child: Text("English"),
          ),
          PopupMenuItem(
            value: 2,
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
