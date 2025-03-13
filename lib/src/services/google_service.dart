import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart';
import 'package:my_money/src/services/debug_service.dart';

class GoogleService {
  GoogleService({
    required this.scopes,
  });

  final List<String> scopes;

   AuthClient? _authClient;

   Future<AuthClient?> get authClient async {
    _authClient ??= await authenticate();
    return _authClient;
  }

   Future<AuthClient?> authenticate() async {
    final googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      myLog.i("authenticate - google user is null");
      return null;
    }

    myLog
        .i("authenticate - success login with client ${googleUser.toString()}");

    final googleAuth = await googleUser.authentication;

    myLog.i(
        "authenticate - success login with googleAuth ${googleAuth.accessToken}");

    final client = authenticatedClient(
      Client(),
      AccessCredentials(
        AccessToken(
          "Bearer",
          googleAuth.accessToken!,
          DateTime.now()
              .add(
                const Duration(hours: 1),
              )
              .toUtc(),
        ),
        googleAuth.idToken,
        scopes,
      ),
    );

    myLog.i("authenticate - success login with client ${client.toString()}");

    return client;
  }
}
