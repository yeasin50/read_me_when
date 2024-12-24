import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:read_me_when/src/app/app_config.dart';

import 'route_config.dart';
import 'theme_config.dart';
import '../infrastructure/app_repo.dart';

class ReadMeWhen extends StatefulWidget {
  const ReadMeWhen({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  State<ReadMeWhen> createState() => _ReadMeWhenState();
}

class _ReadMeWhenState extends State<ReadMeWhen> {
  // get lang => ui.window.locale;

  late final Future<AppRepo> future = AppRepo.init(
    language: "",
    appConfig: widget.config,
  );

  final routeConfig = AppRoute.router();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return FutureBuilder<AppRepo>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Theme(
            data: AppTheme.theme(textTheme),
            child: const Directionality(
              textDirection: TextDirection.ltr,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return AppRepoInheritedWidget(
          repo: snapshot.requireData,
          child: MaterialApp.router(
            scrollBehavior: const ScrollBehavior().copyWith(
              scrollbars: false,
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
            ),
            debugShowCheckedModeBanner: false,
            routerConfig: routeConfig,
          ),
        );
      },
    );
  }
}
