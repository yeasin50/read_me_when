import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              pinned: true,
              elevation: 0,
              forceElevated: false,
              scrolledUnderElevation: 0,
              title: Text(
                'Select Your Mood',
                style: textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms, curve: Curves.easeOutQuad).slide(),
            ),
            SliverList.list(
              children: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: MoodSelectionView(),
                  ),
                ),
              ],
            ),
          ],
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: MoodSelectionView(),
        ),
      ),
    );
  }
}
