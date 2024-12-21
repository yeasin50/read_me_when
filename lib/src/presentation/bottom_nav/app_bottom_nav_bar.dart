import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/route_config.dart';

class AppBottomNavBar extends StatefulWidget {
  const AppBottomNavBar({
    super.key,
    required this.shell,
  });
  final StatefulNavigationShell shell;

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar> {
  int currentIndex = 0;

  void onTap(int value) {
    if (currentIndex == value) return;
    currentIndex = value;
    setState(() {});

    if (value == 0) {
      context.go(AppRoute.home);
    } else if (value == 1) {
      context.go(AppRoute.favorite);
    } else if (value == 2) {
      context.go(AppRoute.history);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.shell,
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: widget.shell.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.article),
          //   label: "Story",
          // ),
        ],
      ),
    );
  }
}
