import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:verse_share/verse_share.dart';

import '../../app/route_config.dart';
import '../../infrastructure/enum/ayah_langage.dart';

import '../../app/theme_config.dart';
import '../../infrastructure/models/quranic_verse.dart';
import 'widgets/qoute_box.dart';
import 'widgets/share_action_buttons.dart';

/// only image generator to share the quote
///
class GenerateImageToShare extends StatefulWidget {
  const GenerateImageToShare({
    super.key,
    required this.verse,
    required this.lang,
  });

  final QuranicVerse verse;
  final AyahLanguage lang;

  @override
  State<GenerateImageToShare> createState() => _GenerateImageToShareState();
}

class _GenerateImageToShareState extends State<GenerateImageToShare> {
  ///
  bool isTextVisible = false;
  final GlobalKey _imageCaptureKey = GlobalKey();

  void onImageDownload(Size imageSize) async {
    try {
      setState(() => isTextVisible = true);
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          debugPrint(timeStamp.inMicroseconds.toString());
          RenderRepaintBoundary boundary = _imageCaptureKey.currentContext!
              .findRenderObject() as RenderRepaintBoundary;
          await VerseShare().downloadImage(
              boundary: boundary, fileName: widget.verse.fileName);
          setState(() => isTextVisible = false);
        },
      );
    } catch (e) {
      ///
    }
  }

  Uint8List? _backgroundImage;
  void updateBackgroundImage(Uint8List? image) {
    _backgroundImage = image;
    setState(() {});
  }

  bool get fromHome => context.canPop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Center(
          child: Material(
            shape: const CircleBorder(),
            color: AppTheme.background.withAlpha(150),
            child: fromHome
                ? BackButton(
                    color: Colors.black, onPressed: () => context.pop())
                : IconButton.outlined(
                    onPressed: () => context.go(AppRoute.home),
                    icon: const Icon(Icons.home)),
          ),
        ),
      ),
      body: Stack(
        children: [
          RepaintBoundary(
            key: _imageCaptureKey,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _backgroundImage != null
                      ? MemoryImage(_backgroundImage!)
                      : const AssetImage('assets/share_bg_img/1.jpg')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: QuoteBox(
                        verse: widget.verse,
                        lang: widget.lang,
                      ),
                    ),
                  ),
                  if (isTextVisible)
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: Text(
                        'Read Me When',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .95),
            child: ShareAction(
              imageKey: _imageCaptureKey,
              isTextVisible: isTextVisible,
              onImageUpload: updateBackgroundImage,
              onDownload: onImageDownload,
            ),
          ),
        ],
      ),
    );
  }
}
