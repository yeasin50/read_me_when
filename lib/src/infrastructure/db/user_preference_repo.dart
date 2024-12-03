//todo: use a local db
import 'dart:async';

import 'package:equatable/equatable.dart';

import '../enum/ayah_langage.dart';
import 'local_db.dart';

class UserPreferenceState extends Equatable {
  const UserPreferenceState({
    required this.ayahLanguage,
    this.savedAyahIds = const [],
  });

  final AyahLanguage ayahLanguage;
  final List<String> savedAyahIds;

  static const UserPreferenceState none = UserPreferenceState(ayahLanguage: AyahLanguage.bangla, savedAyahIds: []);

  @override
  List<Object?> get props => [ayahLanguage, savedAyahIds];

  UserPreferenceState copyWith({
    AyahLanguage? ayahLanguage,
    List<String>? savedAyahIds,
  }) {
    return UserPreferenceState(
      ayahLanguage: ayahLanguage ?? this.ayahLanguage,
      savedAyahIds: savedAyahIds ?? this.savedAyahIds,
    );
  }
}

///- [ ] language support
///- [ ] handle bookMark/Favorite
///- [ ] theme Setting
///- [ ] suggestion Quote -> use Analytic repo for mood tracking
///- [ ]
class UserPreferenceRepo {
  UserPreferenceRepo._(this.localDB);

  final LocalDatabase localDB;

  UserPreferenceState _state = UserPreferenceState.none;
  UserPreferenceState get state => _state;

  late StreamController<UserPreferenceState> _controller;
  Stream<UserPreferenceState> get savedStream => _controller.stream;

  static Future<UserPreferenceRepo> create({
    required String localLanguageCode,
  }) async {
    final ldb = await LocalDatabase.init();

    final repo = UserPreferenceRepo._(ldb);
    await repo._init();
    return repo;
  }

  Future<void> _init() async {
    final lang = await localDB.getUserAyahPreferLanguage();
    final ids = await localDB.getSavedAyahIds();
    _state = _state.copyWith(ayahLanguage: lang, savedAyahIds: ids);
    _controller = StreamController.broadcast(onListen: () => _update(_state));
  }

  void _update(UserPreferenceState state) {
    _state = state;
    _controller.add(_state);
  }

  ///  the one user prefer to show other than arabic
  AyahLanguage? _ayahNativeTranslation;
  AyahLanguage get ayahNativeLang => _ayahNativeTranslation ?? AyahLanguage.bangla;

  Future<void> setLocal(AyahLanguage lang) async {
    await localDB.saveUserAyahPreferLanguage(lang);
    _ayahNativeTranslation = lang;
    _update(state.copyWith(ayahLanguage: lang));
  }

  Future<void> saveFavorite(String ayahId) async {
    await localDB.addAyahId(ayahId);
    _update(state.copyWith(savedAyahIds: [...state.savedAyahIds, ayahId]));
  }

  Future<void> removeFavorite(String ayahId) async {
    await localDB.removeAyahSavedId(ayahId);
    final ids = _state.savedAyahIds..remove(ayahId);
    _update(state.copyWith(savedAyahIds: [...ids]));
  }
}
