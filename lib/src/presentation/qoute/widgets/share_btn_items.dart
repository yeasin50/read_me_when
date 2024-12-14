import 'package:flutter/widgets.dart';

class ShareBtnItem extends StatelessWidget {
  final Icon child;
  final String label;
  final Function()? onTap;
  final TextStyle? labelStyle;
  const ShareBtnItem({
    super.key,
    required this.child,
    required this.label,
    this.onTap,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
