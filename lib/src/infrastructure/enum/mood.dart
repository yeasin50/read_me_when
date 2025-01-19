import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum Mood {
  sad,
  happy,
  anger,
  disappointment,
  loneliness,
  fear,
  trust,
  love,
  surprise,
  disgust,
  ;

  static Mood? fromName(String? name) {
    try {
      return Mood.values.byName(name?.toLowerCase() ?? "");
    } catch (e) {
      return null;
    }
  }
}

extension MoodExt on Mood {
  String get title =>
      switch (this) { _ => "${name[0].toUpperCase()}${name.substring(1)}" };

  /// Primary color associated with the mood (for card background).
  @Deprecated("Will be removed for color consistence")
  Color get color => switch (this) {
        Mood.sad => Colors.blueGrey,
        Mood.happy => Colors.yellow,
        Mood.anger => Colors.red,
        Mood.disappointment => Colors.orangeAccent,
        Mood.loneliness => Colors.purple,
        Mood.fear => Colors.black,
        Mood.trust => Colors.green,
        Mood.love => Colors.pink,
        Mood.surprise => Colors.lightBlue,
        Mood.disgust => Colors.brown,
      };

  /// Secondary color for icons associated with the mood.
  Color get iconColor => switch (this) {
        Mood.sad => Colors.white, // Light text for dark mood
        Mood.happy => Colors.black, // Dark text for light mood
        Mood.anger => Colors.white, // Light icon for dark red
        Mood.disappointment => Colors.black, // Dark text for soft orange
        Mood.loneliness => Colors.white, // Light text for dark purple
        Mood.fear => Colors.white, // Light icon for dark
        Mood.trust => Colors.white, // White icon for green
        Mood.love => Colors.white, // Light icon for pink
        Mood.surprise => Colors.black, // Dark text for light blue
        Mood.disgust => Colors.white, // Light icon for brown
      };

  /// Text color associated with the mood (for title text).
  @Deprecated("Will be removed for color consistence")
  Color get textColor => switch (this) {
        Mood.sad => Colors.white, // Light text for dark mood
        Mood.happy => Colors.black, // Dark text for bright mood
        Mood.anger => Colors.white, // Light text for dark red background
        Mood.disappointment => Colors.black, // Dark text for soft orange
        Mood.loneliness => Colors.white, // Light text for dark purple
        Mood.fear => Colors.white, // Light text for black mood
        Mood.trust => Colors.black, // Dark text for green mood
        Mood.love => Colors.white, // Light text for pink
        Mood.surprise => Colors.black, // Dark text for cyan
        Mood.disgust => Colors.white, // Light text for brown background
      };

  /// Returns an appropriate icon based on the mood.
  Widget get icon => switch (this) {
        Mood.sad =>
          Icon(FontAwesomeIcons.faceSadTear, color: iconColor, size: 40.0),
        Mood.happy =>
          Icon(FontAwesomeIcons.faceSmileBeam, color: iconColor, size: 40.0),
        Mood.anger => Icon(FontAwesomeIcons.fire, color: iconColor, size: 40.0),
        Mood.disappointment =>
          Icon(FontAwesomeIcons.frown, color: iconColor, size: 40.0),
        Mood.loneliness =>
          Icon(FontAwesomeIcons.solidMoon, color: iconColor, size: 40.0),
        Mood.fear =>
          Icon(FontAwesomeIcons.skullCrossbones, color: iconColor, size: 40.0),
        Mood.trust =>
          Icon(FontAwesomeIcons.handHoldingHeart, color: iconColor, size: 40.0),
        Mood.love => Icon(FontAwesomeIcons.heart, color: iconColor, size: 40.0),
        Mood.surprise =>
          Icon(FontAwesomeIcons.faceSurprise, color: iconColor, size: 40.0),
        Mood.disgust => Icon(FontAwesomeIcons.skull,
            color: iconColor, size: 40.0), // Changed to Skull
      };

  // Complementary background color for the scaffold on the quote page (muted and calming tones)
  @Deprecated("Will be removed for color consistence")
  Color get scaffoldBackgroundColor => switch (this) {
        Mood.sad =>
          Color(0xFFFFF9C4), // Soft yellow for sad mood (Hex: #FFF9C4)
        Mood.happy =>
          Color(0xFFBBDEFB), // Light blue for happy mood (Hex: #BBDEFB)
        Mood.anger =>
          Color(0xFFFFAB91), // Muted orange for anger (Hex: #FFAB91)
        Mood.disappointment =>
          Color(0xFFFFE0B2), // Warm peach for disappointment (Hex: #FFE0B2)
        Mood.loneliness =>
          Color(0xFFE1BEE7), // Soft lavender for loneliness (Hex: #E1BEE7)
        Mood.fear =>
          Color(0xFF388E3C), // Muted dark green for fear (Hex: #388E3C)
        Mood.trust => Color(0xFFC8E6C9), // Soft green for trust (Hex: #C8E6C9)
        Mood.love =>
          Color(0xFFF48FB1), // Muted warm red for love (Hex: #F48FB1)
        Mood.surprise =>
          Color(0xFFE0F2F1), // Light minty blue for surprise (Hex: #E0F2F1)
        Mood.disgust =>
          Color(0xFFD7CCC8), // Soft light brown for disgust (Hex: #D7CCC8)
      };

  // Text color for the quote text (soft, neutral tones for better contrast and readability)
  @Deprecated("Will be removed for color consistence")
  Color get quoteTextColor => switch (this) {
        Mood.sad => Color(
            0xFF212121), // Dark grey text for yellow background (Hex: #212121)
        Mood.happy => Color(
            0xFF212121), // Dark grey text for light blue background (Hex: #212121)
        Mood.anger => Colors.white, // White text for orange background
        Mood.disappointment => Color(
            0xFF212121), // Dark grey text for peach background (Hex: #212121)
        Mood.loneliness => Color(
            0xFF212121), // Dark grey text for lavender background (Hex: #212121)
        Mood.fear => Colors.white, // White text for dark green background
        Mood.trust => Color(
            0xFF212121), // Dark grey text for green background (Hex: #212121)
        Mood.love => Color(
            0xFF212121), // Dark grey text for muted warm red background (Hex: #212121)
        Mood.surprise => Color(
            0xFF212121), // Dark grey text for minty blue background (Hex: #212121)
        Mood.disgust => Color(
            0xFF212121), // Dark grey text for light brown background (Hex: #212121)
      };
}
