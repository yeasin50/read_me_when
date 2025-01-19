import 'package:flutter/material.dart';
import 'package:read_me_when/src/infrastructure/app_repo.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

class ShareButtonV2 extends StatelessWidget {
  const ShareButtonV2({
    super.key,
    required this.verse,
  });
  final QuranicVerse verse;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.shareService.copyLink(verse);
      },
      child: const Text("Share"),
    );
  }
}
