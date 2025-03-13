import 'package:flutter/material.dart';
import 'package:my_money/src/services/google_sheet_service.dart';
import 'package:my_money/src/state/record_state/state.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final recordState = RecordState.of(context);
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
            recordState.importCSV();
          },
        ),
        const ListTile(
          title: Row(
            children: [
              Icon(Icons.input),
              SizedBox(
                width: 8,
              ),
              Text("Backup to Google Spreadsheet")
            ],
          ),
          onTap: GoogleSheetService.startBackup,
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.input),
              SizedBox(
                width: 8,
              ),
              Text("Get All Spreadsheet File")
            ],
          ),
          onTap: () async {
            GoogleSheetService.getAllSpreadSheetFiles();
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              SizedBox(
                width: 8,
              ),
              Text("Delete All Records")
            ],
          ),
          onTap: recordState.deleteAllRecords,
        ),
      ],
    );
  }
}
