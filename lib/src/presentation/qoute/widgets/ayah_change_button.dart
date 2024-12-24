import 'package:flutter/material.dart';

class AyahChangeButton extends StatelessWidget {
  const AyahChangeButton({
    super.key,
    this.onNext,
    this.onPrevious,
  });

  final VoidCallback? onNext;
  final VoidCallback? onPrevious;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //      IconButton.outlined(
        //   onPressed: onPrevious,
        //   icon: const Icon(Icons.arrow_back_ios_new),
        // ),
        // const SizedBox(width: 24),
        ElevatedButton.icon(
          onPressed: onNext,
          iconAlignment: IconAlignment.end,
          label: const Text("Next verse"),
        ),
      ],
    );
  }
}
