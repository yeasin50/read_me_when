import 'dart:developer';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

Future<void> downloadImage({
  required RenderRepaintBoundary boundary,
  required String fileName,
}) async {
  assert(!kIsWeb, "  should not be web");

  try {
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    // Step 2: Convert to ByteData and then Uint8List
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      log("Error: Could not get byte data");
      return null;
    }
    final Uint8List bytes = byteData.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    //todo: ayat_sura
    final filePath = '${directory.path}/$fileName.png';
    final io.File file = io.File(filePath);

    // Write the file
    await file.writeAsBytes(bytes);
    log("File saved at: $filePath");
    return null;
  } catch (e) {
    log("Error saving file: $e");
    return null;
  }
}
