import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/infrastructure/db/quranic_verse_repo.dart';
import 'package:read_me_when/src/presentation/saved/widgets/saved_list_tile.dart';
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

class _SavedPageState extends State<SavedPage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<QuranicVerseState>(
      stream: verseRepo.verseStream,
      builder: (context, snapshot) {
        final response = snapshot.data ?? QuranicVerseState.none;

        if (response.data.isEmpty) {
          return const Center(child: Text("You have not saved any"));
        }

        final groupData = groupBy(snapshot.requireData.getSavedItems, (p0) => p0.mood);
        return SafeArea(
          key: ValueKey(response.hashCode),
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
                          return SavedListTile(
                            verse: verse,
                            onTap: () {
                              context.push(AppRoute.quote, extra: {
                                "verse": verse,
                                "index": index,
                              });
                            },
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

  @override
  bool get wantKeepAlive => true;
}
