import 'package:flutter/services.dart';

import 'db/user_preference_repo.dart';
import 'models/quranic_verse.dart';

class QuoteShareService {
  const QuoteShareService._(
    this._userPref,
    this._deployUri,
  );

  final UserPreferenceRepo _userPref;
  final Uri _deployUri;

  static Future<QuoteShareService> create({
    required UserPreferenceRepo pref,
    required Uri hostUri,
  }) async {
    ///
    return QuoteShareService._(pref, hostUri);
  }

  Future<void> copyQuote(QuranicVerse verse) async {
    final lang = _userPref.state.ayahLanguage;

    final String quoteText = """
${verse.nativeAyah(lang)}

${verse.ayatInArabic} (${verse.suraName},${verse.ayatNo})
""";

    await Clipboard.setData(ClipboardData(text: quoteText));
  }

  Future<void> copyLink(QuranicVerse verse) async {
    final langCode = _userPref.state.ayahLanguage.code;
    final quoteLink =
        _deployUri.replace(query: "lang=$langCode&id=${verse.id}").toString();
    await Clipboard.setData(ClipboardData(text: quoteLink));
  }
}
