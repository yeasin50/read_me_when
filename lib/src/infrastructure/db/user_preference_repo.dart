//todo: use a local db
import '../enum/ayah_langage.dart';

///- [ ] language support
///- [ ] handle bookMark/Favorite
///- [ ] theme Setting
///- [ ] suggestion Quote -> use Analytic repo for mood tracking
///- [ ]
class UserPreferenceRepo {
  UserPreferenceRepo._();

  static Future<UserPreferenceRepo> create({
    required String localLanguageCode,
  }) async {
    //todo: load from local db

    return UserPreferenceRepo._();
  }

  ///  the one user prefer to show other than arabic
  AyahLanguage? _ayahNativeTranslation;
  AyahLanguage get ayahNativeLang => _ayahNativeTranslation ?? AyahLanguage.bangla;
  void setLocal(AyahLanguage lang) => _ayahNativeTranslation = lang;
}
