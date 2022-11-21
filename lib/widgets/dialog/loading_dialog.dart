import 'package:warped_bloc/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

/// Shows this [Widget] by default when there is a loading
class DefaultLoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: DefaultLoadingWidget(),
          ),
          const SizedBox(width: 10),
          const Expanded(child: Text('Loading...')),
        ],
      ),
    );
  }
}

void showLoadingDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => DefaultLoadingDialog(),
    );
