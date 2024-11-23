import 'package:flutter_test/flutter_test.dart';
import 'package:read_me_when/src/infrastructure/db/quranic_verse_repo.dart';
import 'package:read_me_when/src/infrastructure/enum/mood.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('quranic verse repo ...', () {
    test(
      "database shouldn't return any error",
      () async {
        final repo = QuranicVerseRepo();
        final result = await repo.load();
        expect(result, null);
      },
    );

    test(
      "make sure we have proper data",
      () async {
        final repo = QuranicVerseRepo();
        await repo.load();
        expect(repo.data.length, Mood.values.length);
        final List<QuranicVerse> data = repo.data.values.fold(//
            [], (previousValue, element) => [...previousValue, ...element]);

        for (final item in data) {
          expect(item.suraNo, isNotNull, reason: "suraNo is null for $item");
          expect(item.suraName, isNotEmpty, reason: "suraName is empty for $item");
          expect(item.ayatNo, isNotEmpty, reason: "ayatNo is empty for $item");
          expect(item.ayatInArabic, isNotEmpty, reason: "ayatInArabic is empty for $item");
          expect(item.englishTranslation, isNotEmpty, reason: "englishTranslation is empty for $item");
          expect(item.banglaTranslation, isNotEmpty, reason: "banglaTranslation is empty for $item");
          expect(item.chineseTranslation, isNotEmpty, reason: "chineseTranslation is empty for $item");
        }
      },
    );
  });
}
