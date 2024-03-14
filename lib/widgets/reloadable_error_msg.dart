import 'package:flutter/material.dart';

class ReloadableErrorMessage extends StatelessWidget {
  final void Function()? reloadFunc;
  final String? errorMsg;
  const ReloadableErrorMessage({super.key, this.reloadFunc, this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            errorMsg ?? "Unhandled error",
            ),
        TextButton(
          onPressed: reloadFunc ?? () {},
          child: const Text('Reload...'),
        )
      ],
    );
  }
}