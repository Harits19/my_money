import 'package:flutter/material.dart';
import 'package:my_money/src/components/linear_progress.dart';
import 'package:my_money/src/services/debug_service.dart';
import 'package:my_money/src/state/auth_state/state.dart';
import 'package:my_money/src/state/record_state/state.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final recordState = RecordState.of(context);
    final authState = AuthState.of(context);
    final isAuthenticated = authState.isAuthenticated;
    myLog.i('current accountClient in setting ${authState.maybeAuthClient}');
    final isHaveSpreadsheetId = recordState.spreadsheetId.isNotEmpty;
    const setAccountMessage =
        "Set the account to get data from Google Spreadsheet";
    final isRecordLoading = recordState.isLoading;

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
          onTap: () async {
            await authState.setAccount();
            await Future.delayed(const Duration(seconds: 1));
            await recordState.getCurrentSpreadsheetId();
          },
        ),
        const Divider(),
        const ListTile(
          subtitle: Text(setAccountMessage),
          enabled: false,
        ),
        ListTile(
          leading: const Icon(Icons.input),
          enabled: isHaveSpreadsheetId && !isRecordLoading,
          title: const Text("Pull from Google Spreadsheet"),
          onTap: () async {
            await recordState.pullFromGoogleSpreadsheet();
          },
        ),
        ListTile(
          leading: const Icon(Icons.input),
          title: const Text("Push to Google Spreadsheet"),
          onTap: recordState.pushToGoogleSpreadsheet,
          enabled: isAuthenticated && !isRecordLoading,
        ),
        ListTile(
          leading: const Icon(Icons.link),
          title: const Text('Open Spreadsheet'),
          subtitle: Text(recordState.spreadsheetId),
          enabled: isHaveSpreadsheetId && !isRecordLoading,
          onTap: () async {
            final link =
                "https://docs.google.com/spreadsheets/d/${recordState.spreadsheetId}/edit";
            await launchUrl(
              Uri.parse(link),
              mode: LaunchMode.externalApplication,
            );
          },
        )
      ],
    );
  }
}
