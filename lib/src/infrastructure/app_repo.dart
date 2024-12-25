import 'package:flutter/material.dart';

import '../app/app_config.dart';
import 'db/local_db.dart';
import 'db/quranic_verse_repo.dart';
import 'db/user_preference_repo.dart';
import 'quote_share_service.dart';

/// base class to provide db across the app
class AppRepo {
  const AppRepo._({
    required this.config,
    required this.verseRepo,
    required this.preferenceRepo,
    required this.shareService,
  });

  final QuranicVerseRepo verseRepo;
  final UserPreferenceRepo preferenceRepo;

  //! might replace  in a repo in future
  final QuoteShareService shareService;

  final AppConfig config;
  static Future<AppRepo> init({
    required AppConfig appConfig,
    required String language,
  }) async {
    final userRepo = await UserPreferenceRepo.create(
      localLanguageCode: language,
    );
    final pref = await LocalDatabase.init();
    final verseRepo = await QuranicVerseRepo.create(pref);

    final uri = Uri.parse(appConfig.baseApiUrl);

    final quoteShareService = await QuoteShareService.create(
      pref: userRepo,
      hostUri: uri,
    );

    final repo = AppRepo._(
      config: appConfig,
      shareService: quoteShareService,
      preferenceRepo: userRepo,
      verseRepo: verseRepo,
    );
    return repo;
  }
}

@immutable
class AppRepoInheritedWidget extends InheritedWidget {
  const AppRepoInheritedWidget({
    super.key,
    required this.repo,
    required super.child,
  });

  final AppRepo repo;

  static AppRepo of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context
          .dependOnInheritedWidgetOfExactType<AppRepoInheritedWidget>()!
          .repo;
    } else {
      return context
          .getInheritedWidgetOfExactType<AppRepoInheritedWidget>()!
          .repo;
    }
  }

  @override
  bool updateShouldNotify(covariant AppRepoInheritedWidget oldWidget) {
    return oldWidget.repo != repo;
  }
}

extension AppRepoBuildContext on BuildContext {
  AppRepo get repo => AppRepoInheritedWidget.of(this, listen: false);

  QuranicVerseRepo get verseRepo => repo.verseRepo;
  UserPreferenceRepo get userPreference => repo.preferenceRepo;
  QuoteShareService get shareService => repo.shareService;
}

extension AppRepoState<T extends StatefulWidget> on State<T> {
  QuranicVerseRepo get verseRepo => context.verseRepo;
  UserPreferenceRepo get userPreference => context.userPreference;
  QuoteShareService get shareService => context.shareService;
}
