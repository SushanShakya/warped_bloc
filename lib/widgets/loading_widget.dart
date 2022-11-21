import 'package:flutter/material.dart';

/// Used by [DefaultBuilderConfig] to show [Loading] whenever
/// there is a [Loading State]
class DefaultLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
