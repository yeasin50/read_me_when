import 'package:flutter/material.dart';
import 'package:read_me_when/src/app/app_config.dart';
import 'package:read_me_when/src/app/read_me_when_app.dart';

void main() {
  runApp(
    const ReadMeWhen(
      config: AppConfig.dev,
    ),
  );
}
