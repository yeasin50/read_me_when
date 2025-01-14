import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.message = "... Visit home"});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () => context.go("/"),
          label: const Text("Go Home"),
        )
      ],
    );
  }
}
