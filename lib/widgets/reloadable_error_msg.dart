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
            //"Error while loading photos!\nProbably can't get data from NASA (try to check your network connection)\n${state.err.toString()}"),
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