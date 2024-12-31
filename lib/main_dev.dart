import 'package:flutter/material.dart';
import 'package:read_me_when/src/app/app_config.dart';
import 'package:read_me_when/src/app/read_me_when_app.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(
    const ReadMeWhen(
      config: AppConfig.dev,
    ),
  );
}
