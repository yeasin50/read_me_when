import '../enum/mood.dart';
import '../models/quranic_verse.dart';

class QuranicVerseState {
  const QuranicVerseState({
    required this.data,
    required this.savedItemIds,
  });

  final Map<Mood, List<QuranicVerse>> data;
  final List<String> savedItemIds;

  static QuranicVerseState none = const QuranicVerseState(
    data: {},
    savedItemIds: [],
  );

  List<QuranicVerse> getMoodForVerse(Mood m) => data[m] ?? [];

  List<QuranicVerse> get getSavedItems {
    return data.values //
        .reduce((value, element) => [...value, ...element])
        .where((verse) => verse.isFavorite)
        .toList();
  }

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
    List<String>? savedItemIds,
  }) {
    return QuranicVerseState(
      data: data ?? this.data,
      savedItemIds: savedItemIds ?? this.savedItemIds,
    );
  }

  @override
  String toString() => 'QuranicVerseState(data: ${data.length}, savedItemIds: ${savedItemIds.length}) hash${hashCode}';
}