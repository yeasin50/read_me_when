import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/app/route_config.dart';

import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/mood.dart';
import '../../infrastructure/models/quranic_verse.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.userPreference.savedStream,
      builder: (context, snapshot) {
        final ids = snapshot.data?.savedAyahIds ?? [];
        if (ids.isEmpty) {
          return const Center(child: Text("You have not saved any"));
        }
        final nativeLang = snapshot.data!.ayahLanguage;
        final data = context.verseRepo.getFromIds(ids);
        return CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Saved Verses"),
            ),
            SliverList.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final verse = data[index];
                return Card(
                  child: ListTile(
                    leading: verse.mood.icon,
                    tileColor: verse.mood.scaffoldBackgroundColor,
                    title: Text(
                      verse.nativeAyah(nativeLang),
                      style: TextStyle(color: verse.mood.quoteTextColor),
                    ),
                    onTap: () {
                      context.push(AppRoute.quote, extra: {
                        "verse": verse,
                        "index": index,
                      });
                    },
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }
}
