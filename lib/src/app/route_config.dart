import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../infrastructure/app_repo.dart';
import '../infrastructure/enum/ayah_langage.dart';
import '../infrastructure/enum/mood.dart';
import '../infrastructure/models/quranic_verse.dart';
import '../presentation/home/home_page.dart';
import '../presentation/qoute/qoute_page.dart';
import '../presentation/qoute_share/generate_image.dart';

class AppRoute {
  static String home = "/";
  static String favorite = "/favorite";
  static String history = "/history";

  static String quote = "/verse";
  static String quoteShare = "/share";

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: home,
      initialExtra: {"initial": true},
      redirect: (context, state) {
        if ((state.extra as Map?)?["initial"] != true) return null;

        print(state.uri.queryParameters);

        // final id = state.uri.queryParameters["id"];
        // final lang = state.uri.queryParameters["lang"] ?? "en";
        // return id == null ? null : "$quoteShare/$lang/$id";
      },
      routes: [
        GoRoute(
          path: home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: quote,
          pageBuilder: (context, state) {
            final moodName = state.uri.queryParameters["mood"];
            return MaterialPage(
              name: quote,
              child: QuotePage(
                mood: Mood.fromName(moodName),
              ),
            );
          },
        ),
        GoRoute(
          path: quoteShare,
          pageBuilder: (context, state) {
            QuranicVerse? verse = (state.extra as Map?)?["verse"];
            final id = state.uri.queryParameters["id"] ?? "";
            final langCode = state.uri.queryParameters["lang"] ?? "en";

            verse ??= context.verseRepo.state.getFromId(id);
            return MaterialPage(
              child: verse == null
                  ? const Text("failed to fetch")
                  : GenerateImageToShare(
                      verse: verse,
                      lang: AyahLanguage.fromCode(langCode),
                    ),
            );
          },
        ),
      ],
    );
  }
}
