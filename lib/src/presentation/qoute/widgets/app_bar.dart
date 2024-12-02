import 'package:flutter/material.dart';

class QuotePageAppBar extends StatelessWidget {
  const QuotePageAppBar({
    super.key,
    required this.surahName,
    required this.textTheme,
    required this.textColor,
    required this.ayah,
    required this.isSaved,
  });

  final String surahName;
  final TextTheme textTheme;
  final Color textColor;
  final String ayah;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                ayah,
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
    );
  }
}
