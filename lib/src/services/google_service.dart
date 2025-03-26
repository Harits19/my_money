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

  AuthClient? get auth {
    return _authClient;
  }

  @Deprecated("use AuthProvider to get current AuthClient value")
  Future<AuthClient> get authClient async {
    if (_authClient != null) {
      myLog.i('authClient - returned current _authClient');
      return _authClient!;
    }
    myLog.i('authClient - current _authClient is null, get new authenticate');

    final newValue = await authenticate();
    _authClient = newValue;
    return newValue;
  }

  late final googleSignIn = GoogleSignIn(
    scopes: scopes,
  );

  Future<AuthClient> authenticate() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("authenticate - google user is null");
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

  Future<AuthClient> changeAccount() async {
    await googleSignIn.signOut();
    return await authenticate();
  }
}
