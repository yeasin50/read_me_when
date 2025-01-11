import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/infrastructure/app_repo.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

import '../../../app/route_config.dart';
import 'expandable_fab.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    super.key,
    required this.verse,
    required this.onChange,
  });

  final QuranicVerse verse;
  final ValueChanged<bool> onChange;

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      onToggle: onChange,
      distance: 60,
      children: [
        ActionButton(
          onPressed: () async {
            await context.shareService.copyQuote(verse);

            if (context.mounted == false) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Verse copied to clipboard"),
              ),
            );
          },
          label: "Copy Quote",
          icon: const Icon(Icons.copy_all_outlined),
        ),
        ActionButton(
          onPressed: () async {
            await context.shareService.copyLink(verse);

            if (context.mounted == false) return;

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Link copied to clipboard"),
              ),
            );
          },
          label: "Copy Link",
          icon: const Icon(Icons.link_outlined),
        ),
        ActionButton(
          onPressed: () {
            final langCode = context.userPreference.state.ayahLanguage.code;
            context.go(
              "${AppRoute.quoteShare}?lang=$langCode&id=${verse.id}",
            );
          },
          label: "Generate Image",
          icon: const Icon(Icons.image_outlined),
        ),
      ],
    );
  }
}
