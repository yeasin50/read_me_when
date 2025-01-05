library verse_share;

import 'package:flutter/rendering.dart';

abstract interface class IVerseShare {
  Future<void> downloadImage({
    required RenderRepaintBoundary boundary,
    required String fileName,
  });
}
