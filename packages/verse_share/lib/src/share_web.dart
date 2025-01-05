library verse_share;

import 'dart:developer';
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

Future<void> downloadImage({
  required RenderRepaintBoundary boundary,
  required String fileName,
}) async {
  assert(kIsWeb, "should be web only");
  try {
    //todo:
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      log("Error: Could not get byte data");
      return;
    }
    final Uint8List bytes = byteData.buffer.asUint8List();

    if (kIsWeb) {
      // Web: Use HTML Blob to trigger download
      final blob = html.Blob([bytes], 'application/octet-stream');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.AnchorElement(href: url)
        ..setAttribute("download", "$fileName.png")
        ..click();
      html.Url.revokeObjectUrl(url);
    }
  } catch (e, t) {
    log("something went wrong on image download $e, \n $t");
  }
}
