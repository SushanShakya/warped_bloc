import 'package:flutter/material.dart';

class DefaultLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
