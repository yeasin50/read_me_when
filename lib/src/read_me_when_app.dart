import 'package:flutter/material.dart';

import 'app/route_config.dart';

class ReadMeWhen extends StatefulWidget {
  const ReadMeWhen({super.key});

  @override
  State<ReadMeWhen> createState() => _ReadMeWhenState();
}

class _ReadMeWhenState extends State<ReadMeWhen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoute.router(),
    );
  }
}
