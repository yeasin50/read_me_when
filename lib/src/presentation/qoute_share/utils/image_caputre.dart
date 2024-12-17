import 'dart:developer';
import 'dart:io' as io;
import 'dart:html' as html; // For web download
import 'package:flutter/foundation.dart'; // kIsWeb
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

///  if fails return  a error message,
/// else return  null
/// ! currently only maintained for web
Future<(io.File? image, String?)?> captureWidget(
  RenderRepaintBoundary boundary, {
  required String fileName,
}) async {
  try {
    //todo: 
    ui.Image image = await boundary.toImage(pixelRatio: 2.0);
    // Step 2: Convert to ByteData and then Uint8List
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData == null) {
      print("Error: Could not get byte data");
      return null;
    }
    final Uint8List bytes = byteData.buffer.asUint8List();

    if (kIsWeb) {
      // Web: Use HTML Blob to trigger download
      final blob = html.Blob([bytes], 'application/octet-stream');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", fileName)
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      try {
        final directory = await getApplicationDocumentsDirectory();
        //todo: ayat_sura
        final filePath = '${directory.path}/$fileName.png';
        final io.File file = io.File(filePath);

        // Write the file
        await file.writeAsBytes(bytes);
        print("File saved at: $filePath");
      } catch (e) {
        print("Error saving file: $e");
      }
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
}
