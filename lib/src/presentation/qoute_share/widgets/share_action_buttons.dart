import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';
import '../generate_image.dart';
import '../utils/image_caputre.dart';

typedef OnImageDownload = Function(Size size);

typedef OnImageUpdate = Function(Uint8List);

class ShareAction extends StatefulWidget {
  const ShareAction({
    super.key,
    required this.imageKey,
    required this.isTextVisible,
    required this.onImageUpload,
    required this.onDownload,
  });

  final GlobalKey imageKey;
  final bool isTextVisible;
  final OnImageUpdate onImageUpload;
  final OnImageDownload onDownload;

  @override
  State<ShareAction> createState() => _ShareActionState();
}

class _ShareActionState extends State<ShareAction> {
  ///getting local file to change the background image and passing to the parent
  Future<void> uploadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        // onFileLoading: (status) => print(status),
        allowedExtensions: ['jpg', 'png'],
      );

      if (result != null) {
        final bytes = result.files.first.bytes;
        if (kIsWeb && bytes != null) {
          widget.onImageUpload(bytes);
        }
      } else {}
    } catch (e, strace) {
      debugPrint("${e.toString()}  ${strace.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      constraints: const BoxConstraints(maxWidth: 650),
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
              //todo:
              widget.onDownload(Size.zero);
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
              onPressed: uploadFile),
        ],
      ),
    );
  }
}
