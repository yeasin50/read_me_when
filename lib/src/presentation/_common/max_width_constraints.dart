import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MaxWidthConstraints extends StatelessWidget {
  const MaxWidthConstraints({
    super.key,
    required this.child,
    this.mobileView,
  });
  final Widget child;
  final Widget? mobileView;

  static bool isMobileView(BuildContext ctx) => !kIsWeb;
  // MediaQuery.sizeOf(ctx).width < 650;
  @override
  Widget build(BuildContext context) {
    final bool isMobileView = MediaQuery.sizeOf(context).width < 650;

    return isMobileView
        ? mobileView ?? child
        : ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: child,
          );
  }
}
