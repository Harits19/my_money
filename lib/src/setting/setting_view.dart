import 'package:flutter/material.dart';
import 'package:my_money/src/components/linear_progress.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final recordState = RecordState.of(context);
    return Column(
      children: [
        LinearProgress(
          isLoading: recordState.isLoading,
        ),
        ListTile(
          leading: const Icon(Icons.input),
          title: const Text("Import CSV Record"),
          onTap: recordState.importCSV,
        ),
        ListTile(
          leading: const Icon(Icons.input),
          title: const Text("Set Account"),
          onTap: recordState.changeAccount,
        ),
        ListTile(
          leading: const Icon(Icons.input),
          title: const Text("Push to Google Spreadsheet"),
          onTap: recordState.pushToGoogleSpreadsheet,
        ),
        const Divider(),
        recordState.spreadsheetId.isNotEmpty
            ? ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Open Spreadsheet'),
                subtitle: Text(recordState.spreadsheetId),
                onTap: () async {
                  final link =
                      "https://docs.google.com/spreadsheets/d/${recordState.spreadsheetId}/edit";
                  await launchUrl(
                    Uri.parse(link),
                    mode: LaunchMode.externalApplication,
                  );
                },
              )
            : const SizedBox(),
      ],
    );
  }
}
