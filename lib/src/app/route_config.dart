import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../infrastructure/enum/mood.dart';
import '../infrastructure/models/quranic_verse.dart';
import '../presentation/bottom_nav/app_bottom_nav_bar.dart';
import '../presentation/home/home_page.dart';
import '../presentation/qoute/qoute_page.dart';
import '../presentation/saved/saved_page.dart';

class AppRoute {
  static String home = "/";
  static String favorite = "/favorite";
  static String story = "/story";

  static String quote = "/quote";

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: favorite,
      routes: [
        GoRoute(
            path: quote,
            pageBuilder: (context, state) {
              final moodName = (state.extra as Map? ?? {})["mood_name"];
              final verseItem = (state.extra as Map? ?? {})["verse"];
              final index = (state.extra as Map? ?? {})["index"];
              Mood mood;

              if (verseItem != null && verseItem is QuranicVerse) {
                mood = verseItem.mood;
              } else {
                mood = Mood.fromName(moodName);
              }

              return CupertinoPage(
                child: QuotePage(mood: mood, verse: verseItem, selectedVerseIndex: index),
              );
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
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: story,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: Text("Story"),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
