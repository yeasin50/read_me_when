import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';
import '../generate_image.dart';
import '../utils/image_caputre.dart';

class ShareAction extends StatefulWidget {
  const ShareAction({
    super.key,
    required this.imageKey,
    required this.isTextVisible,
    required this.onImageUpload,
  });

  final GlobalKey imageKey;
  final bool isTextVisible;
  final Function(Uint8List) onImageUpload;

  @override
  State<ShareAction> createState() => _ShareActionState();
}

class _ShareActionState extends State<ShareAction> {
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

  void _toggleTextVisibility(bool isTextVisible) {
    setState(() {
      isTextVisible = isTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final verse =
        context.findAncestorWidgetOfExactType<GenerateImageToShare>()?.verse;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      constraints: BoxConstraints(maxWidth: 650),
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
              try {
                _toggleTextVisibility(true);
                await Future.delayed(const Duration(milliseconds: 100));

                RenderRepaintBoundary boundary = widget.imageKey.currentContext!
                    .findRenderObject() as RenderRepaintBoundary;
                await captureWidget(boundary, fileName: verse!.fileName);

                _toggleTextVisibility(false);
              } catch (e) {
                ///
              }
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
            onPressed: () async {
              uploadFile();
            },
          ),
        ],
      ),
    );
  }
}
