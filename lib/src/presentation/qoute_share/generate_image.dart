import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../app/theme_config.dart';
import '../../infrastructure/models/quranic_verse.dart';
import 'widgets/qoute_box.dart';
import 'widgets/share_action_buttons.dart';

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
    final GlobalKey _imageCaptureKey = GlobalKey();
    bool isTextVisible = false;
    Uint8List? _backgroundImage;

    void updateBackgroundImage(Uint8List? image){
      _backgroundImage = image;
    }

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
            child: const BackButton(color: Colors.black),
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
                  image: _backgroundImage != null ? MemoryImage(_backgroundImage!) : const AssetImage('assets/share_bg_img/1.jpg') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: QuoteBox(verse: verse),
                    ),
                  ),
                  Visibility(
                    visible: isTextVisible,
                    child: const Positioned(
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
                  ),
                ],
              ),
            ),
          ),
          
          Align(
            alignment: const Alignment(0, .95),
            child: ShareAction(imageKey: _imageCaptureKey, isTextVisible: isTextVisible, onImageUpload: updateBackgroundImage),
          ),
        ],
      ),
    );
  }
}
