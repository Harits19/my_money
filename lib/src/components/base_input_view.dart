import 'package:flutter/material.dart';

class BaseInputView extends StatelessWidget {
  const BaseInputView({
    super.key,
    required this.title,
    required this.body,
    required this.onSave,
  });
  final String title;
  final List<Widget> body;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: body,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: FilledButton(
                onPressed: onSave,
                child: const Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
