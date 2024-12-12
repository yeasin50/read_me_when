import 'package:flutter/material.dart';

import 'db/local_db.dart';
import 'db/quranic_verse_repo.dart';
import 'db/user_preference_repo.dart';

/// base class to provide db across the app
class AppRepo {
  const AppRepo._(this.verseRepo, this.preferenceRepo);

  final QuranicVerseRepo verseRepo;
  final UserPreferenceRepo preferenceRepo;

  static Future<AppRepo> init({required String language}) async {
    final userRepo = await UserPreferenceRepo.create(localLanguageCode: language);
    final pref = await LocalDatabase.init();
    final verseRepo = await QuranicVerseRepo.create(pref);

    final repo = AppRepo._(verseRepo, userRepo);
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
      return context.dependOnInheritedWidgetOfExactType<AppRepoInheritedWidget>()!.repo;
    } else {
      return context.getInheritedWidgetOfExactType<AppRepoInheritedWidget>()!.repo;
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
}

extension AppRepoState<T extends StatefulWidget> on State<T> {
  QuranicVerseRepo get verseRepo => context.verseRepo;
  UserPreferenceRepo get userPreference => context.userPreference;
}
