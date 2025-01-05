import 'dart:developer';

enum AyahLanguage {
  arabic('ar'),
  bangla('bn'),
  english("en"),
  chines("ch"),
  ;

  const AyahLanguage(this.code);

  final String code;

  static AyahLanguage fromCode(String code) {
    try {
      return AyahLanguage.values.firstWhere((e) => e.code == code);
    } catch (e, t) {
      log("failed to get the language, ${e.toString()} $t");
      return AyahLanguage.english;
    }
  }
}
