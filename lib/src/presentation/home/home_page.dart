import 'package:flutter/material.dart';
import 'package:read_me_when/src/presentation/home/widget/mood_selection_view.dart';

import '../../infrastructure/db/quranic_verse_repo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: MoodSelectionView(),
        ),
      ),
    );
  }
}
