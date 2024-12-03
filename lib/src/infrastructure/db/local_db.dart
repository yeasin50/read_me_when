import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../enum/ayah_langage.dart';

/// could use abstract,
class LocalDatabase {
  LocalDatabase._(this.db);
  final SharedPreferences db;

 static Future<LocalDatabase> init() async {
    final pref = await SharedPreferences.getInstance();
    return LocalDatabase._(pref);
  }

  Future<bool> saveUserAyahPreferLanguage(AyahLanguage lang) async {
    await db.setString("ayah_native_lang", lang.name);
    return true;
  }

  Future<AyahLanguage> getUserAyahPreferLanguage() async {
    final ayahLang = db.getString("ayah_native_lang");

    AyahLanguage lang = AyahLanguage.values.firstWhereOrNull(//
        (e) => e.name == ayahLang) ?? AyahLanguage.bangla;
    return lang;
  }

  Future<List<String>> getSavedAyahIds() async {
    final ids = db.getStringList("get_saved_ayahs_ids");
    return ids ?? <String>[];
  }

  Future<bool> addAyahId(String id) async {
    final ids = db.getStringList("get_saved_ayahs_ids") ?? [];
    await db.setStringList("get_saved_ayahs_ids", [...ids, id]);
    return true;
  }

  Future<bool> removeAyahSavedId(String id) async {
    final ids = db.getStringList("get_saved_ayahs_ids") ?? [];
    if (ids.contains(id)) {
      ids.remove(id);
    }
    await db.setStringList("get_saved_ayahs_ids", [...ids]);

    return true;
  }
}
