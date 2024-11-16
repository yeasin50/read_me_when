import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:read_me_when/src/presentation/bottom_nav/app_bottom_nav_bar.dart';
import 'package:read_me_when/src/presentation/home/home_page.dart';

class AppRoute {
  static String home = "/";
  static String favorite = "/favorite";
  static String story = "/story";

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: home,
      routes: [
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (context, state, child) {
            return AppBottomNavBar(
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: home,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
            ),
            GoRoute(
              path: favorite,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Text("Favorite"),
              ),
            ),
            GoRoute(
              path: story,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: Text("Story"),
              ),
            ),
          ],
        )
      ],
    );
  }
}
