import 'package:flutter/material.dart';

class SimpleNavButton extends NavButton {
  const SimpleNavButton({
    required super.icon,
    required super.label,
    super.onTap,
    super.axis,
    super.key,
  });
}

abstract class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.icon,
    required this.label,
    this.axis = Axis.vertical,
    this.isActive = false,
    this.onTap,
  });

  final VoidCallback? onTap;
  final bool isActive;
  final String label;
  final Widget icon;
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: switch (axis) {
        Axis.horizontal => Row(
            children: [
              icon,
              Text(
                label,
                style: textTheme.titleMedium?.copyWith(),
              ),
            ],
          ),
        Axis.vertical => Column(
            children: [
              icon,
              Text(label),
            ],
          )
      },
    );
  }
}
