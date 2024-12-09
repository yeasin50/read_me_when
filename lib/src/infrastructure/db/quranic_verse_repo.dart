import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../enum/ayah_langage.dart';
import '../enum/mood.dart';
import '../models/quranic_verse.dart';
import 'load_from_asset_json.dart';
import 'user_preference_repo.dart';

class QuranicVerseRepo {
  QuranicVerseRepo._();

  QuranicVerseState _state = QuranicVerseState.none;
  QuranicVerseState get state => _state;

  late StreamController<QuranicVerseState> _controller;
  Stream<QuranicVerseState> get verseStream => _controller.stream;

  static Future<QuranicVerseRepo> create(UserPreferenceState userPrefState) async {
    final repo = QuranicVerseRepo._();
    await repo._init(userPrefState);
    return repo;
  }

  Future<void> _init(UserPreferenceState userPrefState) async {
    final verses = await _load();

    Map<Mood, List<QuranicVerse>> refineData = {};
    Map<Mood, List<QuranicVerse>> savedItem = {};
    //refine if saved or not
    for (final k in verses.keys) {
      List<QuranicVerse> data = [];
      savedItem[k] = [];
      for (int i = 0; i < verses[k]!.length; i++) {
        QuranicVerse verse = verses[k]![i];
        if (userPrefState.savedAyahIds.contains(verse.id)) {
          verse = verse.copyWith(isFavorite: true);
          savedItem[k] = [...savedItem[k] ?? [], verse];
        }
        data.add(verse);
      }
      refineData[k] = data;
    }

    _state = QuranicVerseState(
      data: refineData,
      savedItemIds: userPrefState.savedAyahIds,
      savedItems: savedItem,
      nativeLang: userPrefState.ayahLanguage,
    );

    _controller = StreamController.broadcast(onListen: () => _update(_state));
  }

  void _update(QuranicVerseState newState) {
    _state = newState;
    _controller.add(_state);
  }

  void dispose() {
    _controller.close();
  }

  /// hold from assets
  final Map<Mood, String> _moodFiles = {
    Mood.sad: "sadness_db",
    Mood.anger: "anger_db",
    Mood.disappointment: "disappointment_db",
    Mood.disgust: "disgust_db",
    Mood.fear: "fear_db",
    Mood.happy: "happiness_db",
    Mood.loneliness: "loneliness_db",
    Mood.love: "love_db",
    Mood.surprise: "surprise_db",
    Mood.trust: "trust_db",
  };

  Future<Map<Mood, List<QuranicVerse>>> _load() async {
    try {
      final Map<Mood, List<QuranicVerse>> data = {};
      List<Future> futures = [];

      for (final m in _moodFiles.entries) {
        futures.add(loadVerseFromFile(m.key, m.value));
      }

      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        data[_moodFiles.keys.elementAt(i)] = results[i];
      }

      return data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

class QuranicVerseState extends Equatable {
  const QuranicVerseState({
    required this.data,
    required this.savedItemIds,
    required this.savedItems,
    required this.nativeLang,
  });

  final Map<Mood, List<QuranicVerse>> data;
  final Map<Mood, List<QuranicVerse>> savedItems;
  final List<String> savedItemIds;

  final AyahLanguage nativeLang;

  static QuranicVerseState none = const QuranicVerseState(
    data: {},
    savedItemIds: [],
    savedItems: {},
    nativeLang: AyahLanguage.bangla,
  );

  List<QuranicVerse> getMoodForVerse(Mood m) => data[m] ?? [];

  List<QuranicVerse> getFromIds(List<String> ids) {
    final List<QuranicVerse> verses = [];
    for (final key in data.keys) {
      for (final item in data[key] ?? <QuranicVerse>[]) {
        if (ids.contains(item.id)) {
          verses.add(item);
        }
      }
    }
    return verses;
  }

  QuranicVerseState copyWith({
    Map<Mood, List<QuranicVerse>>? data,
    Map<Mood, List<QuranicVerse>>? savedItems,
    List<String>? savedItemIds,
    AyahLanguage? nativeLang,
  }) {
    return QuranicVerseState(
      data: data ?? this.data,
      savedItems: savedItems ?? this.savedItems,
      savedItemIds: savedItemIds ?? this.savedItemIds,
      nativeLang: nativeLang ?? this.nativeLang,
    );
  }

  @override
  List<Object?> get props => [data, savedItemIds, savedItems, nativeLang];
}
