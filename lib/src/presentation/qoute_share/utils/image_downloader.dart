import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

void download(
  List<int> bytes, {
  required String downloadName,
}) {
  final _base64 = base64Encode(bytes);
  final anchor =
      AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
        ..target = 'blank';
  
  // trigger download
  document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  return;
}
