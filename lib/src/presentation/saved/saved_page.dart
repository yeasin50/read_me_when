import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/route_config.dart';
import 'widgets/mood_visibility_ensure_view.dart';

import '../../infrastructure/app_repo.dart';
import '../../infrastructure/enum/mood.dart';
import '../../infrastructure/models/quranic_verse.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.verseRepo.verseStream,
      builder: (context, snapshot) {
        final ids = snapshot.data?.savedItems ?? {};
        if (ids.isEmpty) {
          return const Center(child: Text("You have not saved any"));
        }

        final groupData = snapshot.requireData.savedItems;

        return SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const SliverAppBar.medium(title: Text("Saved verses")),
              SliverAppBar(
                pinned: true,
                title: MoodVisibleControllerView(
                  controller: _scrollController,
                  groupData: groupData,
                ),
              ),
              for (final moodData in groupData.entries)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      SliverAppBar(
                        title: Text(moodData.key.title),
                        leading: moodData.key.icon,
                      ),
                      SliverList.separated(
                        itemCount: moodData.value.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final verse = moodData.value[index];
                          return Hero(
                            tag: verse,
                            child: Card(
                              child: ListTile(
                                tileColor: verse.mood.scaffoldBackgroundColor,
                                title: Text(
                                  verse.nativeAyah(snapshot.requireData.nativeLang),
                                  style: TextStyle(color: verse.mood.quoteTextColor),
                                ),
                                onTap: () {
                                  context.push(AppRoute.quote, extra: {
                                    "verse": verse,
                                    "index": index,
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
