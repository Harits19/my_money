import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_money/src/services/google_service.dart';
import 'package:my_money/src/state/record_state/state.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.input),
              SizedBox(
                width: 8,
              ),
              Text("Import CSV Record")
            ],
          ),
          onTap: () async {
            RecordState.of(context).importCSV();
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.input),
              SizedBox(
                width: 8,
              ),
              Text("Backup to Google Spreadsheet")
            ],
          ),
          onTap: () async {
            GoogleService.authenticate();
          },
        ),
      ],
    );
  }
}
