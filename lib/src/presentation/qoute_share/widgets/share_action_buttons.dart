import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';
import '../generate_image.dart';
import '../utils/image_caputre.dart';

class ShareAction extends StatefulWidget {
  const ShareAction({
    super.key,
    required this.imageKey,
  });

  final GlobalKey imageKey;

  @override
  State<ShareAction> createState() => _ShareActionState();
}

class _ShareActionState extends State<ShareAction> {
  @override
  Widget build(BuildContext context) {
    final verse =
        context.findAncestorWidgetOfExactType<GenerateImageToShare>()?.verse;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withAlpha(150),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () async {
              try {
                RenderRepaintBoundary boundary = widget.imageKey.currentContext!
                    .findRenderObject() as RenderRepaintBoundary;
                await captureWidget(boundary, fileName: verse!.fileName);
              } catch (e) {
                ///
              }
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
        ],
      ),
    );
  }
}

class _EditOption extends StatelessWidget {
  const _EditOption({
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
