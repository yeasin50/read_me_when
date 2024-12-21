import 'package:flutter/material.dart';

class MoodSessionLoadingView extends StatelessWidget {
  const MoodSessionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
