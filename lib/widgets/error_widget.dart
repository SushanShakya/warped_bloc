// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// This is the default [Widget] that gets shown whenever
/// any error occurs.
class DefaultErrorWidget extends StatelessWidget {
  final String message;
  final void Function()? onRetry;
  const DefaultErrorWidget({
    Key? key,
    required this.message,
    this.onRetry,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 10),
        Visibility(
          visible: onRetry != null,
          child: TextButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ),
      ],
    );
  }
}
