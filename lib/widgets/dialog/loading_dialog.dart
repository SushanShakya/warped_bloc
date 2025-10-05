import 'package:flutter/material.dart';
import 'package:warped_bloc/widgets/loading_widget.dart';

/// Shows this [Widget] by default when there is a loading
class DefaultLoadingDialog extends StatelessWidget {
  const DefaultLoadingDialog({Key? key}) : super(key: key);

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
