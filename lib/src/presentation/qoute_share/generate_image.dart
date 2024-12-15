import 'package:flutter/material.dart';
import 'package:read_me_when/src/app/theme_config.dart';

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
      decoration: BoxDecoration(
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
          child: Container(
            decoration: const BoxDecoration(),
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: Center(
                      child: Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      '$verse',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  )),
                ),
                const Spacer(),
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
