import 'dart:async';

import 'package:flutter/material.dart';

import '../enum/mood.dart';
import '../models/quranic_verse.dart';
import 'load_from_asset_json.dart';
import 'local_db.dart';
import 'quranic_verse_state.dart';

export 'quranic_verse_state.dart';

class QuranicVerseRepo {
  QuranicVerseRepo._(this._localDatabase);

  final LocalDatabase _localDatabase;

  QuranicVerseState _state = QuranicVerseState.none;
  QuranicVerseState get state => _state;

  late StreamController<QuranicVerseState> _controller;
  Stream<QuranicVerseState> get verseStream => _controller.stream;

  Stream<Map<Mood, List<QuranicVerse>>> get savedItems {
    return _controller.stream.map(
      (event) {
        Map<Mood, List<QuranicVerse>> filteredData = {};
        for (final entry in event.data.entries) {
          for (final verse in entry.value) {
            if (verse.isFavorite) {
              filteredData[entry.key] = [...filteredData[entry.key] ?? [], verse];
            }
          }
        }

        return Map.from(filteredData);
      },
    );
  }

  static Future<QuranicVerseRepo> create(LocalDatabase db) async {
    final repo = QuranicVerseRepo._(db);
    final savedAyah = await db.getSavedAyahIds();

    print("savedAyah ${savedAyah}");
    await repo._init(savedAyah);
    return repo;
  }

  Future<void> _init(List<String> savedAyahIds) async {
    final verses = await _load();

    Map<Mood, List<QuranicVerse>> refineData = {};
    //refine if saved or not
    for (final k in verses.keys) {
      List<QuranicVerse> data = [];
      for (int i = 0; i < verses[k]!.length; i++) {
        QuranicVerse verse = verses[k]![i];
        data.add(verse.copyWith(isFavorite: savedAyahIds.contains(verse.id)));
      }
      refineData[k] = data;
    }

    _state = QuranicVerseState(
      data: refineData,
      savedItemIds: savedAyahIds,
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

  Future<void> addFavorite(QuranicVerse verse) async {
    await _localDatabase.addAyahId(verse.id);
    _update(state.copyWith(
      savedItemIds: [..._state.savedItemIds, verse.id],
      data: {
        ..._state.data,
        verse.mood: [
          ..._state.data[verse.mood] ?? [],
          verse.copyWith(isFavorite: true),
        ]
      },
    ));
  }

  Future<void> removeFavorite(QuranicVerse verse) async {
    await _localDatabase.removeAyahSavedId(verse.id);
    print("savedAyah removeFavorite ${verse.id}");

    final moodData = _state.data[verse.mood];
    moodData?.removeWhere((element) => element.id == verse.id);
    moodData?.add(verse.copyWith(isFavorite: false));

    _update(state.copyWith(
      savedItemIds: [..._state.savedItemIds..remove(verse.id)],
      data: {..._state.data, verse.mood: moodData ?? []},
    ));
  }

  Future<void> clearPref() async {
    await _localDatabase.removeAyahSavedId("", true);
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
