import 'package:flutter/services.dart';
import 'package:read_me_when/src/infrastructure/enum/ayah_langage.dart';
import 'package:read_me_when/src/infrastructure/models/quranic_verse.dart';

class QuoteShareService {
  

  static Future<void> copyQuote(QuranicVerse verse) async {
    await Clipboard.setData(ClipboardData(text: "${verse.nativeAyah(AyahLanguage.bangla)}"));
  }

  static Future<void> copyLink(QuranicVerse verse) async {
    await Clipboard.setData(ClipboardData(text: verse.id));
  }
}