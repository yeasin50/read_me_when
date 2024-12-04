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

  late int _activeIndex;

  static Future<MoodSession> createSession({
    required Mood mood,
    required List<QuranicVerse> verses,
    int? selectedIndex,
  }) async {
    var data = verses;
    if (selectedIndex == null) data.shuffle();

    final repo = MoodSession._(data);
    await repo._init(selectedIndex);
    return repo;
  }

  /// hold current mood for a specific session to prevent repeated ayah
  @Deprecated("every time gonna create session, so not needed, use [_activeIndex]")
  final List<String> _alreadyShowedAyah = [];

  //update the stream
  void _update(QuranicVerse verse) {
    _currentVerse = verse;
    _alreadyShowedAyah.add(_currentVerse!.id);

    _streamController.add(_currentVerse!);
    _activeIndex++;
  }

  Future<void> _init(int? selectedIdex) async {
    if (_verses.isEmpty) return;
    _activeIndex = selectedIdex ?? 0;
    final verse = selectedIdex == null ? _verses[_activeIndex] : _verses[_activeIndex];
    _streamController = StreamController(
      onListen: () => _update(verse),
    );
  }

  void nextVerse() {
    if (_activeIndex > _verses.length) _activeIndex = 0;
    _update(_verses[_activeIndex]);
  }

  void dispose() {
    _streamController.close();
  }
}
