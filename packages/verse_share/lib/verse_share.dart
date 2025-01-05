library verse_share;

import 'package:flutter/src/rendering/proxy_box.dart';
import 'package:verse_share/src/iverse_share.dart';

import 'src/share_android.dart' if (dart.library.html) 'src/share_web.dart'
    as share;

class VerseShare implements IVerseShare {
  @override
  Future<void> downloadImage({
    required RenderRepaintBoundary boundary,
    required String fileName,
  }) async {
    await share.downloadImage(boundary: boundary, fileName: fileName);
  }
}
