import 'package:flutter/material.dart';
import 'package:read_me_when/src/app/theme_config.dart';
import 'package:read_me_when/src/presentation/qoute_share/widgets/qoute_box.dart';

import '../../infrastructure/models/quranic_verse.dart';

/// only image generator to share the quote
///
class GenerateImageToShare extends StatelessWidget {
  const GenerateImageToShare({
    super.key,
    required this.verse,
  });

  final QuranicVerse verse;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/share_bg_img/1.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Center(
            child: Material(
              shape: const CircleBorder(),
              color: AppTheme.background.withAlpha(150),
              child: const BackButton(color: Colors.black),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: QuoteBox(verse: verse),
                ),
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withAlpha(150),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  // margin: const EdgeInsets.all(24),
                  // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print("tapped");
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // share image
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // change background image
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.color_lens,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // change text color
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class EditOption extends StatelessWidget {
  const EditOption({
    super.key,
    required this.icon,
    this.onPressed,
  });
  final IconData icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPressed,
    );
  }
}
