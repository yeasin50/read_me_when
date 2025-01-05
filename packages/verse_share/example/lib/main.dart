import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:verse_share/verse_share.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey _imageCaptureKey = GlobalKey();

  void captureImage() async {
    RenderRepaintBoundary boundary = _imageCaptureKey.currentContext!
        .findRenderObject() as RenderRepaintBoundary;
    await VerseShare()
        .downloadImage(boundary: boundary, fileName: "test_image");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        key: _imageCaptureKey,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Hello World!'),
              const SizedBox(height: 64),
              ElevatedButton(
                onPressed: captureImage,
                child: const Text("test "),
              )
            ],
          ),
        ),
      ),
    );
  }
}
