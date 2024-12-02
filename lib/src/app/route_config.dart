import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/infrastructure/enum/mood.dart';
import 'package:read_me_when/src/presentation/qoute/qoute_page.dart';

import '../presentation/bottom_nav/app_bottom_nav_bar.dart';
import '../presentation/home/home_page.dart';

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
      initialLocation: quote,
      routes: [
        GoRoute(
            path: quote,
            pageBuilder: (context, state) {
              final moodName = (state.extra as Map? ?? {})["mood_name"];

              final mood = Mood.fromName(moodName);
              return NoTransitionPage(child: QuotePage(mood: mood));
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
                    child: Text("Favorite"),
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
