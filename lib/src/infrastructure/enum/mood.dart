import 'dart:ui';

import 'package:flutter/material.dart';

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

extension MoodColor on Mood {
  Color get color => Colors.cyan;
}
