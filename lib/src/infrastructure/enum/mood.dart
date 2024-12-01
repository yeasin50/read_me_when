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
}

extension MoodExt on Mood {
  String get title => switch (this) { _ => "${name[0].toUpperCase()}${name.substring(1)}" };

  /// Primary color associated with the mood (for card background).
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
        Mood.sad => Icon(FontAwesomeIcons.faceSadTear, color: iconColor, size: 40.0),
        Mood.happy => Icon(FontAwesomeIcons.faceSmileBeam, color: iconColor, size: 40.0),
        Mood.anger => Icon(FontAwesomeIcons.fire, color: iconColor, size: 40.0),
        Mood.disappointment => Icon(FontAwesomeIcons.frown, color: iconColor, size: 40.0),
        Mood.loneliness => Icon(FontAwesomeIcons.solidMoon, color: iconColor, size: 40.0),
        Mood.fear => Icon(FontAwesomeIcons.skullCrossbones, color: iconColor, size: 40.0),
        Mood.trust => Icon(FontAwesomeIcons.handHoldingHeart, color: iconColor, size: 40.0),
        Mood.love => Icon(FontAwesomeIcons.heart, color: iconColor, size: 40.0),
        Mood.surprise => Icon(FontAwesomeIcons.faceSurprise, color: iconColor, size: 40.0),
        Mood.disgust => Icon(FontAwesomeIcons.skull, color: iconColor, size: 40.0), // Changed to Skull
      };
}
