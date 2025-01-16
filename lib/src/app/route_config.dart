import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../infrastructure/app_repo.dart';
import '../infrastructure/enum/ayah_language.dart';
import '../infrastructure/enum/mood.dart';
import '../infrastructure/models/quranic_verse.dart';
import '../presentation/error/error_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/qoute/qoute_page.dart';
import '../presentation/qoute_share/generate_image.dart';

class AppRoute {
  static String home = '/';
  static String favorite = "/favorite";
  static String history = "/history";

  static String quote = "/verse";

  @Deprecated("this will be removed, use homepage sub route")
  static String quoteShare = "/share";

  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router() {
    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: home,
      routes: [
        GoRoute(
          path: home,
          pageBuilder: (context, state) {
            final idStr = state.uri.queryParameters["id"] ?? '';
            //todo: set userLang if null
            final langCode = state.uri.queryParameters["lang"] ?? 'en';

            if (idStr.trim().isEmpty) {
              return const NoTransitionPage(
                child: HomePage(),
              );
            }
            final verse = context.verseRepo.state.getFromId(idStr);

            return MaterialPage(
              child: verse == null
                  ? const ErrorPage(message: "failed to fetch")
                  : GenerateImageToShare(
                      verse: verse,
                      lang: AyahLanguage.fromCode(langCode),
                    ),
            );
          },
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
