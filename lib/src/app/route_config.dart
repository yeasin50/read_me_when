import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/presentation/qoute_share/generate_image.dart';

import '../infrastructure/enum/mood.dart';
import '../infrastructure/models/quranic_verse.dart';
import '../presentation/bottom_nav/app_bottom_nav_bar.dart';
import '../presentation/home/home_page.dart';
import '../presentation/qoute/qoute_page.dart';
import '../presentation/saved/saved_page.dart';

class AppRoute {
  static String home = "/";
  static String favorite = "/favorite";
  static String history = "/history";

  static String quote = "/quote";
  static String quoteShare = "/shared";

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: home,
      routes: [
        GoRoute(
          path: quoteShare,
          pageBuilder: (context, state) {
            final verse = (state.extra as Map)["verse"];

            return MaterialPage(
              child: GenerateImageToShare(verse: verse),
            );
          },
        ),
        GoRoute(
            path: quote,
            pageBuilder: (context, state) {
              final moodName = (state.extra as Map? ?? {})["mood_name"];
              final verseItem = (state.extra as Map? ?? {})["verse"];
              final index = (state.extra as Map? ?? {})["index"];

              if (verseItem != null && verseItem is QuranicVerse) {
                debugPrint("from Saved page");
                return MaterialPage(
                  child: QuotePage.fromSaved(
                    mood: verseItem.mood,
                    verse: verseItem,
                    selectedVerseIndex: index,
                  ),
                );
              } else {
                return MaterialPage(
                  child: QuotePage(
                    key: ValueKey("From home page $moodName"),
                    mood: Mood.fromName(moodName),
                  ),
                );
              }
            }),
        StatefulShellRoute.indexedStack(
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state, shell) {
            return AppBottomNavBar(shell: shell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: home,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: HomePage(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: favorite,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: SavedPage(),
                  ),
                ),
              ],
            ),
            // StatefulShellBranch(
            //   routes: [
            //     GoRoute(
            //       path: history,
            //       pageBuilder: (context, state) => const NoTransitionPage(
            //         child: MoodTrackerPage(),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        )
      ],
    );
  }
}
