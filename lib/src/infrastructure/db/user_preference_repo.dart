//todo: use a local db
import 'dart:async';

import 'package:equatable/equatable.dart';

import '../enum/ayah_langage.dart';
import 'local_db.dart';

///- [ ] language support
///- [ ] theme Setting
///- [ ] suggestion Quote -> use Analytic repo for mood tracking
///
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
    _state = _state.copyWith(ayahLanguage: lang);
    _controller = StreamController.broadcast(onListen: () => _update(_state));
  }

  void _update(UserPreferenceState state) {
    _state = state;
    _controller.add(_state);
  }

  Future<void> dispose() async {
    await _controller.close();
  }

  Future<void> setLocal(AyahLanguage lang) async {
    await localDB.saveUserAyahPreferLanguage(lang);
    _update(state.copyWith(ayahLanguage: lang));
    
  }
}

class UserPreferenceState extends Equatable {
  const UserPreferenceState({required this.ayahLanguage});

  final AyahLanguage ayahLanguage;

  static const UserPreferenceState none = UserPreferenceState(ayahLanguage: AyahLanguage.bangla);

  @override
  List<Object?> get props => [ayahLanguage];

  UserPreferenceState copyWith({
    AyahLanguage? ayahLanguage,
  }) {
    return UserPreferenceState(ayahLanguage: ayahLanguage ?? this.ayahLanguage);
  }
}
