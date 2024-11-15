import 'package:flutter/material.dart';

import '../enum/mood.dart';
import '../models/quranic_verse.dart';
import 'load_from_asset_json.dart';

class QuranicVerseRepo {
  //
  final Map<Mood, List<QuranicVerse>> _data = {};
  Map<Mood, List<QuranicVerse>> get data => _data;

  /// hold from assets
  final Map<Mood, String> _moodFiles = {Mood.sad: "sadness_db"};

  /// return null is Everything is fine,
  /// return string when something went wrong to notify the user
  Future<String?> load() async {
    try {
      List<Future> futures = [];

      for (final m in _moodFiles.entries) {
        futures.add(loadVerseFromFile(m.value));
      }

      final results = await Future.wait(futures);

      for (int i = 0; i < results.length; i++) {
        _data[_moodFiles.keys.elementAt(i)] = results[i];
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return "Failed to load ${e.toString()}";
    }
  }
}
