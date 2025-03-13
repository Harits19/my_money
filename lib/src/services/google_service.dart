import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:my_money/src/services/debug_service.dart';

const clientIdKey =
    "446239923751-isvift1eheeqksfk47ipl29qmnepmirv.apps.googleusercontent.com";

class GoogleService {
  GoogleService._();

  static Future<AutoRefreshingAuthClient> authenticate() async {
    final clientId = ClientId(clientIdKey);
    final scopes = [SheetsApi.spreadsheetsScope];

    final flow = await clientViaUserConsent(clientId, scopes, prompt);
    return flow;
  }

  static void prompt(String url) {
    myLog.i("Please go to the following URL and grant access:");
    myLog.i("  => $url");
    myLog.i("Enter the authorization code:");
  }
}
