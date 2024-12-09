import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:read_me_when/src/infrastructure/enum/ayah_langage.dart';
import 'package:read_me_when/src/infrastructure/enum/mood.dart';

extension QuranicVerseExt on QuranicVerse {
  String nativeAyah(AyahLanguage lang) => switch (lang) {
        AyahLanguage.bangla => banglaTranslation,
        AyahLanguage.english => englishTranslation,
        AyahLanguage.chines => chineseTranslation,
        _ => () {
            assert(false, "Missing language ");
            return "";
          }()
      };
}

class QuranicVerse extends Equatable {
  const QuranicVerse({
    required this.suraNo,
    required this.suraName,
    required this.ayatNo,
    required this.ayatInArabic,
    required this.englishTranslation,
    required this.banglaTranslation,
    required this.chineseTranslation,
    this.isFavorite = false,
    required this.mood,
  });

  final int suraNo;
  final String suraName;
  final String ayatNo;
  final String ayatInArabic;
  final String englishTranslation;
  final String banglaTranslation;
  final String chineseTranslation;

  final bool isFavorite;

  final Mood mood;

  String get id => "$suraNo-$ayatNo";

  static const QuranicVerse ui = QuranicVerse(
    suraNo: 1,
    mood: Mood.happy,
    suraName: "Al-Fatiha",
    ayatNo: "1",
    ayatInArabic: "بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ",
    englishTranslation: "In the name of Allah, the Most Gracious, the Most Merciful",
    banglaTranslation: "আল্লাহর নামে, যিনি পরম দয়ালু, পরম করুণাময়",
    chineseTranslation: "奉普慈、全能的真主的名",
  );
  @override
  List<Object?> get props => [
        mood,
        suraNo,
        suraName,
        ayatNo,
        ayatInArabic,
        englishTranslation,
        banglaTranslation,
        chineseTranslation,
        isFavorite,
      ];

  @override
  String toString() {
    return 'QuranicVerse(suraNo: $suraNo, suraName: $suraName, ayatNo: $ayatNo, ayatInArabic: $ayatInArabic, englishTranslation: $englishTranslation, banglaTranslation: $banglaTranslation, chineseTranslation: $chineseTranslation, isFavorite: $isFavorite, mood: $mood)';
  }

  factory QuranicVerse.fromMap(Map<String, dynamic> map, {required Mood mood}) {
    try {
      return QuranicVerse(
        mood: mood,
        suraNo: map['sura_no']?.toInt() ?? 0,
        suraName: map['sura_name'] ?? '',
        ayatNo: map['ayat_no']?.toString() ?? '',
        ayatInArabic: map['arabic'] ?? '',
        englishTranslation: map['english'] ?? '',
        banglaTranslation: map['bangla'] ?? '',
        chineseTranslation: map['chinese'] ?? '',
        isFavorite: map["is_favorite"] ?? false,
      );
    } catch (e) {
      debugPrint("QuranicVerse.fromMap $map");
      rethrow;
    }
  }

  QuranicVerse copyWith({
    int? suraNo,
    String? suraName,
    String? ayatNo,
    String? ayatInArabic,
    String? englishTranslation,
    String? banglaTranslation,
    String? chineseTranslation,
    bool? isFavorite,
    Mood? mood,
  }) {
    return QuranicVerse(
      suraNo: suraNo ?? this.suraNo,
      suraName: suraName ?? this.suraName,
      ayatNo: ayatNo ?? this.ayatNo,
      ayatInArabic: ayatInArabic ?? this.ayatInArabic,
      englishTranslation: englishTranslation ?? this.englishTranslation,
      banglaTranslation: banglaTranslation ?? this.banglaTranslation,
      chineseTranslation: chineseTranslation ?? this.chineseTranslation,
      isFavorite: isFavorite ?? this.isFavorite,
      mood: mood ?? this.mood,
    );
  }
}
