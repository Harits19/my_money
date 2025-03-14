import 'package:flutter/material.dart';

class LinearProgress extends StatelessWidget {
  const LinearProgress({
    super.key,
    this.isLoading = false,
  });
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: const LinearProgressIndicator(),
    );
  }
}
