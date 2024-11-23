import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  });

  final int suraNo;
  final String suraName;
  final String ayatNo;
  final String ayatInArabic;
  final String englishTranslation;
  final String banglaTranslation;
  final String chineseTranslation;

  final bool isFavorite;

  @override
  List<Object?> get props => [
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
    return 'QuranicVerse(suraNo: $suraNo, suraName: $suraName, ayatNo: $ayatNo, ayatInArabic: $ayatInArabic, englishTranslation: $englishTranslation, banglaTranslation: $banglaTranslation, chineseTranslation: $chineseTranslation, isFavorite: $isFavorite)';
  }

  factory QuranicVerse.fromMap(Map<String, dynamic> map) {
    try {
      return QuranicVerse(
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
}
