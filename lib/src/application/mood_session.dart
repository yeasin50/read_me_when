import 'dart:async';

import '../infrastructure/enum/mood.dart';
import '../infrastructure/models/quranic_verse.dart';

/// Create a session  to show a specific mood when user open the ayah  on fist time/everyTime based on feelings
///
class MoodSession {
  MoodSession._(this._verses);

  final List<QuranicVerse> _verses;

  QuranicVerse? _currentVerse;
  late StreamController<QuranicVerse> _streamController;
  Stream<QuranicVerse> get stream => _streamController.stream;

  static Future<MoodSession> createSession({
    required Mood mood,
    required List<QuranicVerse> verses,
  }) async {
    final data = verses..shuffle();
    final repo = MoodSession._(data);
    await repo._init();
    return repo;
  }

  /// hold current mood for a specific session to prevent repeated ayah
  final List<String> _alreadyShowedAyah = [];

  //update the stream
  void _update(QuranicVerse verse) {
    _currentVerse = verse;
    _alreadyShowedAyah.add(_currentVerse!.id);

    _streamController.add(_currentVerse!);
  }

  Future<void> _init() async {
    _streamController = StreamController(
      onListen: () => _update(_verses.first),
    );
  }

  void nextVerse() {
    if (_alreadyShowedAyah.length >= _verses.length) {
      _verses.shuffle();
      _alreadyShowedAyah.clear();
    }

    _alreadyShowedAyah.add(_verses[_alreadyShowedAyah.length].id);
    _update(_verses[_alreadyShowedAyah.length]);
  }

  void dispose() {
    _alreadyShowedAyah.clear();
    _streamController.close();
  }
}
