import 'package:flutter_test/flutter_test.dart';
import 'package:read_me_when/src/insfrastructure/db/quranic_verse_repo.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('quranic verse repo ...', () {
    final repo = QuranicVerseRepo();

    test(
      "database should pass parse",
      () async {
        final result = await repo.load();
        expect(result, null);
      },
    );
  });
}
