import 'package:flutter/material.dart';

class EmptyStateMessage extends StatelessWidget {
  final String message;
  const EmptyStateMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
